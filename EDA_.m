disp("=== Summary Statistics of Features ===");
summary(SFeaturesByFault)

featureNames = SFeaturesByFault.Properties.VariableNames(3:end);  % skip 'FaultType' and 'Variable'

figure;
for i = 1:length(featureNames)
    subplot(4, 4, i);  % Adjust based on how many features (15 → 4x4)
    histogram(SFeaturesByFault.(featureNames{i}), 'Normalization', 'pdf');
    title(featureNames{i}, 'Interpreter', 'none');
    xlabel('Value');
    ylabel('Density');
end
sgtitle('Distribution of Statistical Features');

% Compute correlation matrix
featureData = table2array(SFeaturesByFault(:, 3:end));
corrMatrix = corrcoef(featureData, 'Rows', 'pairwise');

% Plot heatmap
figure;
heatmap(featureNames, featureNames, corrMatrix, ...
    'Colormap', parula, 'ColorbarVisible', 'on');
title('Feature Correlation Matrix');

faultTypes = unique(SFeaturesByFault.FaultType);
featureToPlot = 'Norm6thMoment';  % You can loop over others if needed
