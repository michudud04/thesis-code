function isConnected = checkIfConnectedDirected(adjMatrix)
    %disp("checking if connected")
    %size(adjMatrix)
    G = digraph(adjMatrix);
    bins = conncomp(G, 'Type', 'strong'); % strongly connected
    isConnected = length(unique(bins)) == 1;
end