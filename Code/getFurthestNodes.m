    function [nodeA, nodeB] = getFurthestNodes(adjMatrix)
        G = digraph(adjMatrix);          
        D = distances(G);                 % all‐pairs distances
        D(eye(size(D))==1) = -Inf;        % ignore zeros on diagonal
        [maxDist, idx] = max(D(:));       % find the largest distance
        [nodeA, nodeB] = ind2sub(size(D), idx);
    end
