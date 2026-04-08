function [adj,lengths,thicknesses,nodes,node_distances] = simulateVEGFCblocker(adjacencyMatrix,lengths, thicknesses, nodes,distances,p,r,gamma)
    adj = adjacencyMatrix;
    N = size(adjacencyMatrix, 1);    
    for i = 1:N
        for j = 1:N
            if i > N || j > N
                break
            end
            if adj(i,j) == 1
                drop_probability = gamma*(1-(lengths(i,j)/2));
                if rand<drop_probability
                    adj(i,j) = 0;
                    lengths(i,j) = 0;
                    thicknesses(i,j) = 0;
                end
            end
        end
    end
    connected = checkIfConnectedDirected(adj);
    if ~connected
        [adj,lengths,thicknesses,nodes,distances] = keep_largest_component(adj,lengths,thicknesses,nodes,distances);
    end
    [adj,lengths,thicknesses,nodes,node_distances] = assymetricWattsStrogatz4(adj,lengths, thicknesses,nodes,distances,p,r);
end