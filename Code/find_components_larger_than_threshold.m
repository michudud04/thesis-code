function [components_larger_than,lenghts,thicknesses] = find_components_larger_than_threshold(adj,lenghts,thicknesses,threshold)
    
    G = digraph(adj);
    comp = conncomp(G, 'Type', 'strong');
    
    % Count nodes in each component
    counts = histcounts(comp, 1:max(comp)+1);
    
    % Find all components above the threshold
    componentsToKeep = find(counts >= threshold);
    
    % Get node indices
    nodesToKeep = find(ismember(comp, componentsToKeep));
    
    % Extract submatrix
    components_larger_than = adj(nodesToKeep, nodesToKeep);
    lengths = lengths(nodesToKeep, nodesToKeep);
    thicknesses = thicknesses(nodesToKeep,nodesToKeep);
end