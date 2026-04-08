function probabilities = negatedSoftMax(distances)
    %first mutiply all the distances with -1, then calculate the
    %probabilities
    probabilities = softMax(-distances);
end