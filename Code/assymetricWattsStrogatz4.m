function [adj,lengths,thicknesses,nodes,distances] = assymetricWattsStrogatz4(adjacencyMatrix, lengths, thicknesses,nodes, distances, p,r,min_component_size)
    %r is the probability of a connection disappearing. set as 0 for everything
    %other than vegfa-
    adj = adjacencyMatrix;
    N = size(adj, 1);  % Number of nodes
    for i = 1:N  % Iterate over all nodes
        neighbors = find(adj(i, :));  % Find existing outgoing neighbors
        for j = 1:length(neighbors)
            if rand < p  % Rewire with probability p
                % Remove the existing edge
                adj(i, neighbors(j)) = 0;
                if rand < r
                    %removing for good
                    lengths(i,neighbors(j)) = 0;
                    thicknesses(i,neighbors(j)) = 0;
                else              
                   % Create list of possible new targets (excluding self and current neighbors)
                    possibleTargets = setdiff(1:N, [i, find(adj(i, :) == 1)]);
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
                    adj(i, newNode) = 1;
                    lengths(i,newNode) = distances(i,newNode);
                    thicknesses(i,newNode) = rand;
                end
            end
        end
    end
    connected = checkIfConnectedDirected(adjacencyMatrix);
    if ~connected
        [adj,lengths,thicknesses,nodes,distances] = keep_largest_component(adjacencyMatrix,lengths,thicknesses,nodes,distances);
    end
end

