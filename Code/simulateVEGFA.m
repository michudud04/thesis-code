function [adj,lengths,thicknesses,nodes,node_distances] = simulateVEGFA(adjacencyMatrix,lengths, thicknesses, nodes,distances, p,q)
    %p is the rewiring probability for  Watts Strogatz, q is the new vessel
    %formation
    adj = adjacencyMatrix;
    assert(size(adj,1) == size(adj,2), 'simulateVEGFA: adjacencyMatrix must be square on entry');

    N = size(adjacencyMatrix, 1);  % <-- Define N!
    for i = 1:size(adj,1)
        unconnected_nodes = find(adj(i,:) == 0 & (1:N) ~= i);
        if rand<q
            if isempty(unconnected_nodes)
                node = []; % or node = -1; to indicate no unconnected nodes
            else
                idx = randi(length(unconnected_nodes));
                node = unconnected_nodes(idx);
                adj(i,node) = 1;
                lengths(i,node) = distances(i,node);
                thicknesses(i,node) = rand;
            end
        end
    end
    [adj,lengths,thicknesses,nodes,node_distances] = assymetricWattsStrogatz4(adj,lengths, thicknesses,nodes,distances,p,0);
end