%% Benchmark: findAllPaths vs MATLAB built-in allpaths (R2024b)
clear; clc; rng(42);

% ---- Setup random directed graph ----
n = 14;              % number of nodes
p = 0.7;           % probability of edge
A = rand(n) < p;
A(1:n+1:end) = 0;   % remove self-loops
A = double(A);

startNode = 1;
endNode = n;

% ---- Build digraph for built-in method ----
G = digraph(A);

% ---- Warm up both functions ----
% findAllPaths(A, startNode, endNode);
% allpaths(G, startNode, endNode);

% % ---- Time your function ----
% f1 = @() findAllPaths(A, startNode, endNode);
% time1 = timeit(f1);

% ---- Time MATLAB built-in allpaths ----
f2 = @() allpaths(G, startNode, endNode);
time2 = timeit(f2);

% ---- Compare ----
fprintf('\n===== Performance Comparison =====\n');
%fprintf('findAllPaths time: %.4f s\n', time1);
fprintf('allpaths (built-in) time: %.4f s\n', time2);
%fprintf('Speedup: %.2fx faster\n', time1 / time2);

% ---- Verify same number of paths ----
%paths1 = findAllPaths(A, startNode, endNode);
paths2 = allpaths(G, startNode, endNode);

%fprintf('Paths found (findAllPaths): %d\n', numel(paths1));
fprintf('Paths found (allpaths):     %d\n', numel(paths2));
