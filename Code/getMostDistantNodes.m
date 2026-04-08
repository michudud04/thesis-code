function nodes = getMostDistantNodes(distances)
    [~,node1] = max(distances);
    [~,node2] = max(max(distances));
    nodes = [node1,node2];
end