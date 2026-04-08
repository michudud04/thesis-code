function paths = findAllPaths(graph, startNode, endNode)
    paths = {}; %use a cell because paths can have different lengths

    findPaths(startNode, endNode, []);

    function findPaths(currentNode, endNode, currentPath)
        currentPath = [currentPath, currentNode];
        if currentNode == endNode
            paths = [paths; {currentPath}]; 
            return;
        end

        neighbors = find(graph(currentNode, :));

        for i = 1:length(neighbors)
            neighbor = neighbors(i);
            if ~ismember(neighbor, currentPath)
                findPaths(neighbor, endNode, currentPath);
            end
        end
    end
end