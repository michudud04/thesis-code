function plot_box_jitter(data, groupNames)
    % Plot boxplots with overlaid jittered data points

    nGroups = numel(data);
    boxplot(cell2mat(data'), repelem(1:nGroups, cellfun(@numel, data)), 'Labels', groupNames);
end