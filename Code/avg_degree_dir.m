function k_avg = avg_degree_dir(A)
    % compute degrees
    k_in    = sum(A, 1)'; 
    k_out   = sum(A, 2);
    k_total = k_in + k_out;
    
    % average
    k_avg = mean(k_total)/2;
end
