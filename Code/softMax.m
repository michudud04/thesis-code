function probabilities = softMax(scores)
    % Compute exponentials of the raw scores
    exp_values = exp(scores);
    
    % Normalize to get probabilities
    probabilities = exp_values / sum(exp_values);
end