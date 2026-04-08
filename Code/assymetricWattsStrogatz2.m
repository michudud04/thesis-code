function [adjacencyMatrix,lengths,thicknesses,nodes,distances] = assymetricWattsStrogatz2(adjacencyMatrix, lengths, thicknesses, nodes,distances,p,r)
%r is the probability of a connection disappearing. set as 0 for everything
%other than vegfa-
    assert(size(adjacencyMatrix,1) == size(adjacencyMatrix,2), ...
           'assymetricWattsStrogatz2: adjacencyMatrix must be square on entry');

    N = size(adjacencyMatrix, 1);  % Number of nodes
    for i = 1:size(adjacencyMatrix,1)% Iterate over all nodes  
        if size(adjacencyMatrix, 1) ~= size(adjacencyMatrix, 2)
            error('assymetricWattsStrogatz2: adjacencyMatrix became non-square (size %d x %d) at i=%d', N, nCols, i);
        end
        if i>size(adjacencyMatrix,1)
                break %account for resizing
            end
        neighbors = find(adjacencyMatrix(i, :));
        %size(neighbors)
        % Find existing outgoing neighbors
        for j = 1:length(neighbors)
            if rand < p  % Rewire with probability p
                % Remove the existing edge
                adjacencyMatrix(i, neighbors(j)) = 0;
                if rand < r
                    lengths(i,neighbors(j)) = 0;
                    thicknesses(i,neighbors(j)) = 0;
                else              
                   % Create list of possible new targets (excluding self and current neighbors)
                    possibleTargets = [];
                    for k = 1:size(adjacencyMatrix,1)
                        if adjacencyMatrix(i,k) == 0
                            possibleTargets(end+1) = k;
                        end
                    end
                    lengths(i,neighbors(j)) = 0;
                    thicknesses(i,neighbors(j)) = 0;
    
                    % Check if rewiring is possible
                    if isempty(possibleTargets)
                        continue;  % No valid node to rewire to
                    end
    
                    % Choose a new node randomly from valid targets
                    probabilities = negatedSoftMax(distances(i,possibleTargets));
                    newNodeIndex = randsample(1:length(possibleTargets), 1, true, probabilities);
                    newNode = possibleTargets(newNodeIndex);
                    
                    % Add new edge
                    if newNode > N
                        continue
                    end
                    works = ((size(adjacencyMatrix,1))==size(adjacencyMatrix,2));
                    adjacencyMatrix(i, newNode) = 1;
                    lengths(i,newNode) = distances(i,newNode);
                    thicknesses(i,newNode) = rand;
                    if ((size(adjacencyMatrix,1))~=size(adjacencyMatrix,2)) && works
                        disp("I chuj kurwa tu sie zjebalo")
                    end
                end
                assert(ismatrix(adjacencyMatrix) && size(adjacencyMatrix,1) == size(adjacencyMatrix,2), ...
            'tu sie pierdoli skurwysyn');

            end 
            connected = checkIfConnectedDirected(adjacencyMatrix);
            if ~connected
                size(adjacencyMatrix,1)
                size(adjacencyMatrix,2)
                [adjacencyMatrix,lengths,thicknesses,nodes,distances] = keep_largest_component(adjacencyMatrix,lengths,thicknesses,nodes,distances);
                N = size(adjacencyMatrix,1);
                size(adjacencyMatrix,1)
                size(adjacencyMatrix,2)
            end
            if i>size(adjacencyMatrix,1)
                break %account for resizing
            end
            if j>size(adjacencyMatrix,1)
                break
            end
            neighbors = find(adjacencyMatrix(i, :)); %recompute neighbors
        end
    end
end
