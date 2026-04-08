function probabilities = invertedSoftMax(distances)
    probabilities = softMax(1./ distances);
end