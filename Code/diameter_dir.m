function d = diameter_dir(A)
    % build directed graph
    G = digraph(A);

    % compute all-pairs shortest paths
    D = distances(G);

    % ignore self-distances
    D(eye(size(D))==1) = NaN;

    % diameter is the maximum of all finite distances
    d = max(D(~isnan(D)));

end
