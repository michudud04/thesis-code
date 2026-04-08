function [nodes,edges,lengths,thicknesses] = initializationRoutine(n_cells,initial_degree)
    nodes = generatePointsInACircle(n_cells);
    distances = getDistances(nodes);
    edges = zeros(n_cells);
    for i = 1:n_cells
        neighbors = getClosestNeighbors(distances(i,:),initial_degree);
        for j = 1:initial_degree
            edges(i,neighbors(j)) = 1;
        end
    end
    [lengths,thicknesses] = generateWeights(edges,distances);
    [source,sink] = getFurthestNodes(edges);
end