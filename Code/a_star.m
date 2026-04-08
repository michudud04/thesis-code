function [totalCost, path] = a_star(adjacencyMatrix, lengths, thicknesses, congestion, node_distances, startNode, goalNode)
    n = size(lengths, 1);
    
    gScore = Inf(1, n);         % Cost from start to node
    gScore(startNode) = 0;

    fScore = Inf(1, n); % Estimated total cost (g + h)
    node_distances(startNode,goalNode);
    fScore(startNode) = node_distances(startNode, goalNode);

    openSet = true(1, n);       % Set of nodes to evaluate
    cameFrom = NaN(1, n);       % Path reconstruction

    while any(openSet)
        % Pick node in open set with lowest fScore
        currentCandidates = fScore;
        currentCandidates(~openSet) = Inf;
        [~, current] = min(currentCandidates);

        if current == goalNode
            path = reconstructPath(cameFrom, current);
            totalCost = gScore(goalNode);
            return;
        end

        openSet(current) = false;

        for neighbor = 1:n
            if adjacencyMatrix(current, neighbor)
                edgeCost = lengths(current, neighbor) + ...
                           thicknesses(current, neighbor) * congestion(current, neighbor);

                tentative_gScore = gScore(current) + edgeCost;

                if tentative_gScore < gScore(neighbor)
                    cameFrom(neighbor) = current;
                    gScore(neighbor) = tentative_gScore;
                    fScore(neighbor) = tentative_gScore + node_distances(neighbor, goalNode);
                    openSet(neighbor) = true;
                end
            end
        end
    end

    % If we reach here, no path exists
    path = [];
    totalCost = Inf;
end

function path = reconstructPath(cameFrom, current)
    path = current;
    while ~isnan(cameFrom(current))
        current = cameFrom(current);
        path = [current, path];
    end
end
