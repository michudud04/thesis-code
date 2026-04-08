function [lengths,thicknesses] = generateWeights(adjacencyMatrix,distances)
    lengths = zeros(size(adjacencyMatrix));
    for i = 1:size(adjacencyMatrix,1)
        for j = 1:size(adjacencyMatrix,1)
            if adjacencyMatrix(i,j)~=0
                lengths(i,j) = distances(i,j);
            end
        end
    end
    thicknesses = zeros(size(adjacencyMatrix));
    for i = 1:size(adjacencyMatrix,1)
        for j = 1:size(adjacencyMatrix,1)
            if adjacencyMatrix(i,j)~=0
                thicknesses(i,j) = rand;
            end
        end
    end
end