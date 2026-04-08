function [nodes,adjacencyMatrix,lengths,thicknesses] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,gamma,new_vessel_probability,drop_probability,initial_degree,molecule) 
    for i = 1:n_iterations
        if (initial_degree>size(adjacencyMatrix,1))
            initial_degree = size(adjacencyMatrix,1);
        end
        %simulate the molecule
        if molecule == "a-" || molecule ==  "b-" || molecule == "c-"
            current_growing_probability = growing_probability*exp(-decay_rate*i);
        elseif molecule == "c"
            current_growing_probability = final_growing_probability * (1 - exp(-growing_probability * i));
        else
            current_growing_probability = growing_probability;
        end
        %simulate growth
        if rand<current_growing_probability
            % adjacencyMatrix
            % nodes
            disp('growing');
            N = size(adjacencyMatrix,1);
            % if (size(adjacencyMatrix,1)~=size(adjacencyMatrix,2))
            %     disp("cos sie pojebalo")
            % end
            new_node = generatePointsInACircle(1);
            adjacencyMatrix(N+1,N+1)= 0;
            nodes(end+1,:) = new_node;
            node_distances = getDistances(nodes);
            % if (size(adjacencyMatrix,1)~=size(adjacencyMatrix,2))
            %     disp("cos sie pojebalo")
            % end
            adjacencyMatrix;
            nodes;
            node_distances;
            neighbors = getClosestNeighbors(node_distances(N+1,:),initial_degree);
            %ensure connectivity
            for j = 1:initial_degree
                adjacencyMatrix(N+1,neighbors(j)) = 1;
                adjacencyMatrix(neighbors(j),N+1) = 1;
            end
            lengths(N+1,N+1) = 0;
            %lengths
            %node_distances
            lengths(N+1,:)= node_distances(N+1,:);
            lengths(:,N+1) = node_distances(:,N+1);
            for j = 1:N+1
                if adjacencyMatrix(N+1,j)~=0
                    thicknesses(N+1,j) = rand;
                end
                if adjacencyMatrix(j,N+1)~=0
                    thicknesses(j,N+1) = rand;
                end
            end
        end
        %run rewiring procedure with molecule
        if molecule == "a" || molecule == "c"
            [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = simulateVEGFA(adjacencyMatrix,lengths, thicknesses, nodes,node_distances,rewiring_probability,new_vessel_probability);
        elseif molecule == "b"
            current_rewiring_probability = rewiring_probability*exp(-decay_rate*n_iterations);
            [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = simulateVEGFB(adjacencyMatrix,lengths, thicknesses, nodes,node_distances,current_rewiring_probability);
        elseif molecule == "b-"
            [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = simulateVEGFBblocker(adjacencyMatrix,lengths, thicknesses, nodes,node_distances,rewiring_probability,gamma);
        elseif molecule == "c-"
            [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = simulateVEGFCblocker(adjacencyMatrix,lengths, thicknesses, nodes,node_distances,rewiring_probability,drop_probability,gamma);
        else
            [adjacencyMatrix,lengths,thicknesses,nodes,node_distances] = simulateVEGFAblocker(adjacencyMatrix,lengths, thicknesses, nodes,node_distances,rewiring_probability,drop_probability);
        end
    end
end