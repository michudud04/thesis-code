%simulation hyperparameters
n_cells = 10; %number of cells at the start of the simulation
initial_degree = 4; %initial degree of each cell upon initialization
n_iterations = 50; 
rewiring_probabilities = [0.001,0.01,0.1]; 
decay_rate = 0.3; %for vegfs b
growing_probability = 0.01;
final_growing_probability = min(1,2*growing_probability);
new_vessel_probability = 0.05;
drop_probability = 0.05; %only for VEGF c
units = 100;
runs = 25;
molecule = "a-";

inefficiencies_norm = zeros(runs,3);
sigmas = zeros(runs,3);
avg_degrees = zeros(runs,3);
change_in_degree_normalized = zeros(runs,3);
%change_in_time = zeros(runs,5);



for j = 1:3
    rewiring_probability = rewiring_probabilities(j);
    disp(j)
    for i = 1:runs
        disp(i)
        %create a new graph
        %disp(i)
        connected = false;
        while connected == false
            [nodes,adjacencyMatrix,lengths,thicknesses] = initializationRoutine(n_cells,initial_degree);
            connected = checkIfConnectedDirected(adjacencyMatrix);
        end
        node_distances = getDistances(nodes);
        %first look at the inefficiency in the graph
        [average_travel_time, inefficiency_before,inefficiency_before_normalized] = calculate_inefficiency(nodes,adjacencyMatrix,lengths,thicknesses,units);
        degree_before = avg_degree_dir(adjacencyMatrix); 
        %run the simulation main loop
        [nodes_a,adjacencyMatrix_a,lengths_a,thicknesses_a] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,new_vessel_probability,drop_probability,initial_degree,molecule);    
        %now we have the new network, we need to look at the throughput
        [time_a,~,inefficiency_a_normalized] = calculate_inefficiency(nodes_a,adjacencyMatrix_a,lengths_a,thicknesses_a,units);

        inefficiencies_norm(i,j) = inefficiency_a_normalized;

        sigmas(i,j) = sigma_smallworld_dir(adjacencyMatrix_a);
        %change_in_time(i,j) = (time_a-average_travel_time)/average_travel_time;
        degree_after = avg_degree_dir(adjacencyMatrix_a);
        avg_degrees(i,j) = degree_after;
        change_in_degree_normalized(i,j) = (degree_after-degree_before)/degree_before;
    end
end
labels = {'0.001','0.01','0.1'};
inefficiencies_cell = mat2cell(inefficiencies_norm, size(inefficiencies_norm,1), ones(1,size(inefficiencies_norm,2)));
figure; plot_box_jitter(inefficiencies_cell, labels)
xlabel('rewiring probability')
ylabel('inefficiency')
title('VEGF ' + molecule)

inefficiencies_reshaped = inefficiencies_norm(:).' ;
sigmas_reshaped = sigmas(:).';

figure;
scatter(sigmas_reshaped, inefficiencies_reshaped, 'filled');
xlabel('sigma');
ylabel('Inefficiency Normalized');
title('VEGF ' + molecule)

grid on;

% Calculate Pearson correlation coefficient
r = corr(sigmas_reshaped', inefficiencies_reshaped');  % Transpose to ensure column vectors
r_squared = r^2;

% Display results
fprintf('Correlation coefficient (r): %.4f\n', r);
fprintf('Coefficient of determination (r^2): %.4f\n', r_squared);

avg_degrees_reshaped = avg_degrees(:).';
figure;
scatter(avg_degrees_reshaped, inefficiencies_reshaped, 'filled');
xlabel('Average Degree');
ylabel('Inefficiency Normalized');
title('VEGF ' + molecule)

% Calculate Pearson correlation coefficient
r2 = corr(avg_degrees_reshaped', inefficiencies_reshaped');  % Transpose to ensure column vectors
r2_squared = r2^2;

% Display results
fprintf('Correlation coefficient (r): %.4f\n', r2);
fprintf('Coefficient of determination (r^2): %.4f\n', r2_squared);
