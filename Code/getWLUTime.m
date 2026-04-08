function wlu = getWLUTime(lengths,thicknesses,congestion,path)
    wlu = 0;
    for i = 1:length(path)-1
        startNode = path(i);
        endNode = path(i+1);
        wlu = wlu + congestion(startNode,endNode)*(lengths(startNode,endNode)+(congestion(startNode,endNode)*thicknesses(startNode,endNode)))-(congestion(startNode,endNode)-1)*(lengths(startNode,endNode)+((congestion(startNode,endNode)-1)*thicknesses(startNode,endNode)));
    end
end