function plotGraph(x, y, adjacencyMatrix)

    % Number of nodes
    numNodes = length(x);

    % Create figure
    figure;
    hold on;
    axis equal;

    % Plot edges
    for i = 1:numNodes
        for j = 1:numNodes  % Avoid duplicate edges
            if adjacencyMatrix(i, j) == 1
                plot([x(i), x(j)], [y(i), y(j)], 'k-', 'LineWidth', 1.5); % Black edges
            end
        end
    end

    % Plot nodes
    scatter(x, y, 100, 'ro', 'filled'); % Red filled circles

    % Label nodes
    text(x + 0.1, y + 0.1, arrayfun(@num2str, 1:numNodes, 'UniformOutput', false), 'FontSize', 12, 'Color', 'b');

    title('Graph Visualization');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');

    hold off;
end
