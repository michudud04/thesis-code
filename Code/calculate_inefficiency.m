function [throughput_greedy,inefficiency,inefficiency_normalized ] = calculate_inefficiency(nodes,adjacencyMatrix,lengths,thicknesses,units)
    isconnected = checkIfConnectedDirected(adjacencyMatrix);
    if isconnected == false
        throughput_greedy = 0;
        inefficiency = 1;
        inefficiency_normalized = 1;
    else

        [source,sink] = getFurthestNodes(adjacencyMatrix);
        congestion_WLU = zeros(size(adjacencyMatrix));
        
        G = digraph(adjacencyMatrix);
        possible_paths = allpaths(G,source,sink);
        flow_utilities = zeros(1,size(possible_paths,1));
        for i = 1:units
            %compute utilities for each possible path
            for j = 1:length(possible_paths)
                temp_path = cell2mat(possible_paths(j));%retrieving array from cell
                temp_congestion = congestion_WLU(:,:);
                for k = 1:length(temp_path)-1
                    startNode = temp_path(k);
                    endNode = temp_path(k+1);
                    temp_congestion(startNode,endNode) = temp_congestion(startNode,endNode) + 1;
                end
                flow_utilities(j) = getWLUTime(lengths,thicknesses,temp_congestion,temp_path);
            end
            [m,new_index] = min(flow_utilities);
            new_path = cell2mat(possible_paths(new_index));
        
            %update congestion
            for j = 1:length(new_path)-1
                startNode = new_path(j);
                endNode = new_path(j+1);
                congestion_WLU(startNode,endNode) = congestion_WLU(startNode,endNode) + 1;
            end
            congestion_WLU;
        end
        %disp("computed WLU") 
        congestion_greedy = zeros(size(adjacencyMatrix));
        node_distances = getDistances(nodes);
        for i = 1:units
            %compute utilities for each possible path
            [~,new_path] = a_star(adjacencyMatrix, lengths, thicknesses, congestion_greedy, node_distances, source, sink);
        
            %update congestion
            for j = 1:length(new_path)-1
                startNode = new_path(j);
                endNode = new_path(j+1);
                congestion_greedy(startNode,endNode) = congestion_greedy(startNode,endNode) + 1;
            end
        end
        %normalize 
        throughput_greedy = getAverageTravelTime(lengths,thicknesses,congestion_greedy,units);
        throughput_WLU = getAverageTravelTime(lengths,thicknesses,congestion_WLU,units);
        inefficiency = throughput_greedy-throughput_WLU;
        inefficiency_normalized = inefficiency/throughput_WLU;
    end
end