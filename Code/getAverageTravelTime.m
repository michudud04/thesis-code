function time = getAverageTravelTime(lengths,thicknesses,congestion,units)
    time = 0;
    for i = 1:size(congestion,1)
        for j = 1:size(congestion,1)
            time = time + congestion(i,j).*(thicknesses(i,j).*congestion(i,j) + lengths(i,j));
        end
    end
    time = time/units;
end
