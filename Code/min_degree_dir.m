function k_min = min_degree_dir(A)
    % compute in‐ and out‐degrees
    k_in  = sum(A, 1)';   % sum of each column
    k_out = sum(A, 2);    % sum of each row
    
    % total degrees
    k_total = k_in + k_out;
    
    % minimum
    k_min = min(k_total);
end
