function [largest_component,lengths,thicknesses,nodes_new,node_distances] = keep_largest_component(adj,lengths,thicknesses,nodes,node_distances)
    % A is your adjacency matrix
    %size(adj,1)
    %size(adj,2)
    %disp("keep largest component");
    G = digraph(adj);   % Create a directed graph object
    
    % Find weakly connected components (change to conncomp(G,'Type','strong') for SCC)
    comp = conncomp(G, 'Type', 'strong'); 
    
    % Find the largest component
    counts = histcounts(comp, 1:max(comp)+1);
    [~, largestComp] = max(counts);
    
    % Keep nodes in the largest component
    nodesToKeep = find(comp == largestComp);
    
    % Extract submatrix
    largest_component = adj(nodesToKeep, nodesToKeep);
    lengths = lengths(nodesToKeep, nodesToKeep);
    thicknesses = thicknesses(nodesToKeep,nodesToKeep);

    %disp(size(nodes,1));
    %disp(size(nodes,2));
    %disp(size(adj,1));
    %disp(size(adj,2));
    %disp(nodesToKeep);
    
    nodes_new = nodes(nodesToKeep,:);
    node_distances = node_distances(nodesToKeep,nodesToKeep);
    assert(ismatrix(largest_component) && size(largest_component,1) == size(largest_component,2), ...
       'adjacencyMatrix must be a square matrix at function entry');


end