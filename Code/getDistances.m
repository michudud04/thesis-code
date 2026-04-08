function distances = getDistances(coordinates)
    for i = 1:length(coordinates)
        for j = 1:length(coordinates)
            distances(i,j) = sqrt((coordinates(i,1)- coordinates(j,1))^2 + (coordinates(i,2)-coordinates(j,2))^2);
        end
    end
end