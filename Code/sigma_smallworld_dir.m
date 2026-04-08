function [cc,pl,sigma] = sigma_smallworld_dir(A, nRand)
   
    %   sigma = SIGMA_SMALLWORLD_DIR(A, nRand) uses nRand null graphs
    %   to estimate C_r and L_r.
    
    if nargin<2 || isempty(nRand)
        nRand = 10;
    end
    
    % Ensure binary, no self‐loops
    A = A~=0;
    A = A - diag(diag(A));
    
    % Create directed graph object
    G = digraph(A);
    
    C_all = clustering_coef_bd(A);   
    % (clustering_coef_bd handles directed graphs by counting directed triangles)
    C = mean(C_all);
    
    % Directed path‐length: use distances on digraph
    distMat = distances(G);
    distMat(isinf(distMat)) = NaN;     %ignore unreachable pairs
    L = nanmean(distMat(:));
    
    % Null model metrics
    Cr_vals = zeros(nRand,1);
    Lr_vals = zeros(nRand,1);
    N = numnodes(G);
    E = nnz(A);
    
    for i = 1:nRand
        % Generate random directed Erdős–Rényi graph with same density
        p = E / (N*(N-1));
        Ar = rand(N) < p;
        Ar = Ar - diag(diag(Ar));        % zero out self‐loops
        
        Gr = digraph(Ar);
        
        % Clustering in null graph
        Cr_vals(i) = mean(clustering_coef_bd(Ar));
        
        % Path‐length in null graph
        d_r = distances(Gr);
        d_r(isinf(d_r)) = NaN;
        Lr_vals(i) = nanmean(d_r(:));
    end
    
    Cr = mean(Cr_vals);
    Lr = mean(Lr_vals);
    cc= C/Cr;
    pl = L/Lr;
    % Small‐world coefficient
    sigma = (C/Cr) / (L/Lr);
end
