%simulation hyperparameters
n_cells = 25;%number of cells at the start of the simulation
initial_degree = 13; %initial degree of each cell upon initialization
n_iterations = 5; 
rewiring_probability = 0.05; 
decay_rate = 0.2; %for vegfs b
growing_probability = 0.01;
final_growing_probability = min(1,2*growing_probability);
new_vessel_probability = 0.05;
drop_probability = 0.05;%only for VEGF c

gamma = 0.1; %parameter for drop probabilities for vegf b- and c- 
min_component_size = 3; %minimum connected component size
units = 100;
runs = 1000;

inefficiencies_a_norm = zeros(1,runs);
inefficiencies_b_norm = zeros(1,runs);
inefficiencies_c_norm = zeros(1,runs);
inefficiencies_am_norm = zeros(1,runs);
inefficiencies_bm_norm = zeros(1,runs);
inefficiencies_cm_norm = zeros(1,runs);

sigmas_a = zeros(1,runs);
sigmas_b = zeros(1,runs);
sigmas_c = zeros(1,runs);
sigmas_am = zeros(1,runs);
sigmas_bm = zeros(1,runs);
sigmas_cm = zeros(1,runs);

cc_a = zeros(1,runs);
cc_b = zeros(1,runs);
cc_c = zeros(1,runs);
cc_am = zeros(1,runs);
cc_bm = zeros(1,runs);
cc_cm = zeros(1,runs);

pl_a = zeros(1,runs);
pl_b = zeros(1,runs);
pl_c = zeros(1,runs);
pl_am = zeros(1,runs);
pl_bm = zeros(1,runs);
pl_cm = zeros(1,runs);

sizes_a = zeros(1,runs);
sizes_b = zeros(1,runs);
sizes_c = zeros(1,runs);
sizes_am = zeros(1,runs);
sizes_bm = zeros(1,runs);
sizes_cm = zeros(1,runs);


avg_degree_a = zeros(1,runs);
avg_degree_b = zeros(1,runs);
avg_degree_c = zeros(1,runs);
avg_degree_am = zeros(1,runs);
avg_degree_bm = zeros(1,runs);
avg_degree_cm = zeros(1,runs);

connectivity_a = zeros(1,runs);
connectivity_b = zeros(1,runs);
connectivity_c = zeros(1,runs);
connectivity_am = zeros(1,runs);
connectivity_bm = zeros(1,runs);
connectivity_cm = zeros(1,runs);
for i = 1:runs
    i
    %create a new graph
    connected = false;
    %ensuring the graph is connected
    while connected == false
        [nodes,adjacencyMatrix,lengths,thicknesses] = initializationRoutine(n_cells,initial_degree);
        connected = checkIfConnectedDirected(adjacencyMatrix);
    end
    %plotGraph(nodes(:,1),nodes(:,2),adjacencyMatrix)
    node_distances = getDistances(nodes);
    %first look at the inefficiency in the graph
    %[average_travel_time, inefficiency_before,inefficiency_before_normalized] = calculate_inefficiency(nodes,adjacencyMatrix,lengths,thicknesses,units);

    %run the simulation main loop
    %disp("a")
    [nodes_a,adjacencyMatrix_a,lengths_a,thicknesses_a] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,gamma,new_vessel_probability,drop_probability,initial_degree,"a");
    %disp("b")
    [nodes_b,adjacencyMatrix_b,lengths_b,thicknesses_b] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,gamma,new_vessel_probability,drop_probability,initial_degree,"b");
    %disp("c")
    [nodes_c,adjacencyMatrix_c,lengths_c,thicknesses_c] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,gamma,new_vessel_probability,drop_probability,initial_degree,"c");
    % disp("a-")
    [nodes_am,adjacencyMatrix_am,lengths_am,thicknesses_am] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,gamma,new_vessel_probability,drop_probability,initial_degree,"a-");
    % disp("b-")
    [nodes_bm,adjacencyMatrix_bm,lengths_bm,thicknesses_bm] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,gamma,new_vessel_probability,drop_probability,initial_degree,"b-");
    % disp("c-")
    [nodes_cm,adjacencyMatrix_cm,lengths_cm,thicknesses_cm] = simulation_mainloop(nodes,adjacencyMatrix,node_distances,lengths,thicknesses,n_iterations,growing_probability,final_growing_probability,rewiring_probability,decay_rate,gamma,new_vessel_probability,drop_probability,initial_degree,"c-");
    % plotGraph(nodes_a(:,1),nodes_a(:,2),adjacencyMatrix_a)
    % title("VEGF A")
    % plotGraph(nodes_b(:,1),nodes_b(:,2),adjacencyMatrix_b)
    % title("VEGF B")
    % plotGraph(nodes_c(:,1),nodes_c(:,2),adjacencyMatrix_c)
    % title("VEGF C")
    % plotGraph(nodes_am(:,1),nodes_am(:,2),adjacencyMatrix_am)
    % title("VEGF A inhibitor")
    % plotGraph(nodes_bm(:,1),nodes_bm(:,2),adjacencyMatrix_bm)
    % title("VEGF B inhibitor")
    % plotGraph(nodes_cm(:,1),nodes_cm(:,2),adjacencyMatrix_cm)
    % title("VEGF C inhibitor")


    %now we have the new network, we need to look at the throughput
    %size(nodes_a)
    % disp("a")
    % if size(adjacencyMatrix_a,1)<2
    %     inefficiency_a_normalized = 1;
    % else
    %         [time_a,~,inefficiency_a_normalized] = calculate_inefficiency(nodes_a,adjacencyMatrix_a,lengths_a,thicknesses_a,units);
    % end
    % disp("b")
    % if size(adjacencyMatrix_b,1)<2
    %     inefficiency_b_normalized = 1;
    % else
    %     [time_b,~,inefficiency_b_normalized] = calculate_inefficiency(nodes_b,adjacencyMatrix_b,lengths_b,thicknesses_b,units);
    % end
    % disp("c")
    % if size(adjacencyMatrix_c,1)<2
    %     inefficiency_c_normalized = 1;
    % else
    %     [time_c,~,inefficiency_c_normalized] = calculate_inefficiency(nodes_c,adjacencyMatrix_c,lengths_c,thicknesses_c,units);
    % end
    % disp("a-")
    % if size(adjacencyMatrix_am,1)<2
    %     inefficiency_am_normalized = 1;
    % else
    %     [time_am,~,inefficiency_am_normalized] = calculate_inefficiency(nodes_am,adjacencyMatrix_am,lengths_am,thicknesses_am,units);
    % end
    % disp("b-")
    % if size(adjacencyMatrix_bm,1)<2
    %     inefficiency_bm_normalized = 1;
    % else
    %     [time_bm,~,inefficiency_bm_normalized] = calculate_inefficiency(nodes_bm,adjacencyMatrix_bm,lengths_bm,thicknesses_bm,units);
    % end
    % disp("c-")
    % if size(adjacencyMatrix_cm,1)<2
    %     inefficiency_cm_normalized = 1;
    % else
    %     [time_cm,~,inefficiency_cm_normalized] = calculate_inefficiency(nodes_cm,adjacencyMatrix_cm,lengths_cm,thicknesses_cm,units);
    % end
    % 
    % inefficiencies_a_norm(i) = inefficiency_a_normalized;
    % inefficiencies_b_norm(i) = inefficiency_b_normalized;
    % inefficiencies_c_norm(i) = inefficiency_c_normalized;
    % inefficiencies_am_norm(i) = inefficiency_am_normalized;
    % inefficiencies_bm_norm(i) = inefficiency_bm_normalized;
    % inefficiencies_cm_norm(i) = inefficiency_cm_normalized;

    sizes_a(i) = size(adjacencyMatrix_a,1);
    sizes_b(i) = size(adjacencyMatrix_b,1);
    sizes_c(i) = size(adjacencyMatrix_c,1);
    sizes_am(i) = size(adjacencyMatrix_am,1);
    sizes_bm(i) = size(adjacencyMatrix_bm,1);
    sizes_cm(i) = size(adjacencyMatrix_cm,1);

    % [cc_a(i),pl_a(i),sigmas_a(i)] = sigma_smallworld_dir(adjacencyMatrix_a);
    % [cc_b(i),pl_b(i),sigmas_b(i)] = sigma_smallworld_dir(adjacencyMatrix_b);
    % [cc_c(i),pl_c(i),sigmas_c(i)] = sigma_smallworld_dir(adjacencyMatrix_c);
    % [cc_am(i),pl_am(i),sigmas_am(i)] = sigma_smallworld_dir(adjacencyMatrix_am);
    % [cc_bm(i),pl_bm(i),sigmas_bm(i)] = sigma_smallworld_dir(adjacencyMatrix_bm);
    % [cc_cm(i),pl_cm(i),sigmas_cm(i)] = sigma_smallworld_dir(adjacencyMatrix_cm);



    avg_degree_a(i) = avg_degree_dir(adjacencyMatrix_a);
    avg_degree_b(i) = avg_degree_dir(adjacencyMatrix_b);
    avg_degree_c(i) = avg_degree_dir(adjacencyMatrix_c);
    avg_degree_am(i) = avg_degree_dir(adjacencyMatrix_am);
    avg_degree_bm(i) = avg_degree_dir(adjacencyMatrix_bm);
    avg_degree_cm(i) = avg_degree_dir(adjacencyMatrix_cm);


end
% data = {inefficiencies_a_norm,inefficiencies_b_norm,inefficiencies_c_norm,inefficiencies_am_norm,inefficiencies_bm_norm,inefficiencies_cm_norm};
groupNames = {'VEGF A','VEGF B','VEGF C','VEGF A blocker','VEGF B blocker','VEGF C blocker'};
% figure; plot_box_jitter(data, groupNames)
% ylabel('inefficiency')
% title('Rewiring Probability = 0.05')
% 
% 
% sigmas = [sigmas_a,sigmas_b,sigmas_c,sigmas_am,sigmas_bm,sigmas_cm];
% ccs = [cc_a,cc_b,cc_c,cc_am,cc_bm,cc_cm];
% pls = [pl_a,pl_b,pl_c,pl_am,pl_bm,pl_cm];
% inefficiencies_norm = [inefficiencies_a_norm,inefficiencies_b_norm,inefficiencies_c_norm,inefficiencies_am_norm,inefficiencies_bm_norm,inefficiencies_cm_norm];
% figure;
% scatter(sigmas, inefficiencies_norm, 'filled');
% xlabel('sigma');
% ylabel('Inefficiency Normalized');
% title('Rewiring Probability = 0.05')
datasizes = {sizes_a,sizes_b,sizes_c,sizes_am,sizes_bm,sizes_cm};
figure; plot_box_jitter(datasizes, groupNames)
ylabel('Number of cells when process terminates')

datasizes = {sizes_a, sizes_b, sizes_c, sizes_am, sizes_bm, sizes_cm};

meanValues = cellfun(@mean, datasizes);

figure;
bar(meanValues);

set(gca, 'XTickLabel', groupNames);
ylabel('Average number of cells when process terminates');

connectivity_a =  avg_degree_a./sizes_a;
connectivity_b =  avg_degree_b./sizes_b;
connectivity_c =  avg_degree_c./sizes_c;
connectivity_am =  avg_degree_am./sizes_am;
connectivity_bm =  avg_degree_bm./sizes_bm;
connectivity_cm =  avg_degree_cm./sizes_cm;
dataconnectivity = {connectivity_a,connectivity_b,connectivity_c,connectivity_am,connectivity_bm,connectivity_cm};
figure; plot_box_jitter(dataconnectivity, groupNames)
ylabel('Connectivity of cancer cell when process terminates')

meancon = cellfun(@mean, dataconnectivity);

figure;
bar(meancon);

set(gca, 'XTickLabel', groupNames);
ylabel('Average connectivity when process terminates');

% figure;
% scatter(ccs, inefficiencies_norm, 'filled');
% xlabel('Clustering Coefficient Scaled');
% ylabel('Inefficiency Normalized');
% title('Rewiring Probability = 0.05')
% 
% figure;
% scatter(pls, inefficiencies_norm, 'filled');
% xlabel('Path Length Scaled');
% ylabel('Inefficiency Normalized');
% title('Rewiring Probability = 0.05')
% grid on;
% 
% % Calculate Pearson correlation coefficient
% r = corr(sigmas', inefficiencies_norm');  % Transpose to ensure column vectors
% r_squared = r^2;
% 
% % Display results
% fprintf('Correlation coefficient (r): %.4f\n', r);
% fprintf('Coefficient of determination (r^2): %.4f\n', r_squared);

