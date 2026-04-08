function [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = simulateVEGFB(adjacencyMatrix,lengths, thicknesses, nodes,distances, p)
    [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = assymetricWattsStrogatz4(adjacencyMatrix, lengths, thicknesses, nodes,distances,p,0);
end