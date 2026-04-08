function [adjacencyMatrix,lengths,thicknesses,nodes,distances] = assymetricWattsStrogatz3(adjacencyMatrix, lengths, thicknesses, nodes,distances,p,r)
% Asymmetric Watts--Strogatz style rewiring with defensive handling of
% changes to adjacencyMatrix (e.g. when keep_largest_component reduces nodes).
    % input validation
    restartFromStart = false;    % flag used when keep_largest_component reindexes nodes
    i = 1;
    while i <= size(adjacencyMatrix,1)
        % refresh sizes every iteration (adjacencyMatrix may change)
        N = size(adjacencyMatrix,1);
        % if N ~= size(adjacencyMatrix,2)
        %     error('assymetricWattsStrogatz2: adjacencyMatrix became non-square (size %d x %d) at i=%d', ...
        %           size(adjacencyMatrix,1), size(adjacencyMatrix,2), i);
        % end

        % get current outgoing neighbors for node i
        neighbors = find(adjacencyMatrix(i, :));
        j = 1;

        while j <= length(neighbors)
            % validate that neighbors(j) is still a valid column index and edge still exists
            if neighbors(j) > size(adjacencyMatrix,2) || adjacencyMatrix(i, neighbors(j)) == 0
                % neighbors became stale: recompute and restart neighbor loop
                neighbors = find(adjacencyMatrix(i,:));
                j = 1;
                continue;
            end

            if rand < p
                target = neighbors(j);

                % Remove the existing edge
                adjacencyMatrix(i, target) = 0;
                if rand < r
                    lengths(i,target) = 0;
                    thicknesses(i,target) = 0;
                else
                    % build possibleTargets using current adjacency (columns)
                    possibleTargets = find(adjacencyMatrix(i,:) == 0 & (1:size(adjacencyMatrix,2)) ~= i);

                    % clear old metadata for removed edge
                    lengths(i,target) = 0;
                    thicknesses(i,target) = 0;

                    if ~isempty(possibleTargets)
                        probabilities = negatedSoftMax(distances(i,possibleTargets));
                        newNodeIndex = randsample(1:length(possibleTargets), 1, true, probabilities);
                        newNode = possibleTargets(newNodeIndex);

                        % sanity-check newNode is within current bounds
                        if newNode <= size(adjacencyMatrix,2)
                            adjacencyMatrix(i, newNode) = 1;
                            lengths(i,newNode) = distances(i,newNode);
                            thicknesses(i,newNode) = rand;
                        end
                    end
                end

                % After a structural change, check connectivity
                connected = checkIfConnectedDirected(adjacencyMatrix);
                if ~connected
                    % Reduce to largest component, which may reindex nodes.
                    [adjacencyMatrix,lengths,thicknesses,nodes,distances] = ...
                        keep_largest_component(adjacencyMatrix,lengths,thicknesses,nodes,distances);

                    % Restart entire outer loop from the beginning (safe reindexing)
                    restartFromStart = true;
                    break;  % break out of neighbor loop
                else
                    % If still connected, neighbors changed -> recompute and restart neighbors loop
                    neighbors = find(adjacencyMatrix(i,:));
                    j = 1;
                    continue;
                end
            else
                % no rewiring for this neighbor, go to next
                j = j + 1;
            end
        end % end neighbor loop

        if restartFromStart
            restartFromStart = false;
            i = 1;        % restart outer loop from first node (indices were remapped)
            continue;     % do not increment i further this iteration
        else
            i = i + 1;    % advance to next node
        end
    end % end outer while
end
