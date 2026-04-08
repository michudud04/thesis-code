function k_max = max_degree_dir(A)    
    % compute degrees
    k_in    = sum(A, 1)'; 
    k_out   = sum(A, 2);
    k_total = k_in + k_out;
    
    % maximum
    k_max = max(k_total);
end
