function neighbors = getClosestNeighbors(distances,n)
    %n determines how many closest neighbors we want to find
    [~, sortedIndices] = sort(distances, 'ascend');

    % Select the first n closest neighbors
    neighbors = sortedIndices(2:n+1); 
end