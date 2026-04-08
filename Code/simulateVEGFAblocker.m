function [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = simulateVEGFAblocker(adjacencyMatrix,lengths, thicknesses, nodes,distances,p,r)
    [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = assymetricWattsStrogatz4(adjacencyMatrix,lengths, thicknesses, nodes, distances, p,r);
end