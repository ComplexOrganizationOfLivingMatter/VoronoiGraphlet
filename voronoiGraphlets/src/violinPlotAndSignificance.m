function [] = violinPlotAndSignificance(fourFoldVerticesMbs, fourFoldVerticesWT)
%VIOLINPLOTANDSIGNIFICANCE Summary of this function goes here
%   Detailed explanation goes here
% allData = vertcat(fourFoldVerticesMbs, fourFoldVerticesWT);
% 
% groupingMbs = repmat({'Mbs-RNAi'}, size(fourFoldVerticesMbs, 1), 1);
% groupingWT = repmat({'WT'}, size(fourFoldVerticesWT, 1), 1);
% 
% groupingAll = vertcat(groupingMbs, groupingWT);

%figure;violinplot(allData, groupingAll, [255 111 70; 20 182 255]/255);
figure; 
% figure; boxplot(allData, groupingAll);
% hold on;
% scatter(fourFoldVerticesMbs(:, 1), ones(size(groupingMbs)))

notBoxPlot(fourFoldVerticesMbs, 2, 'style','sdline', 'markMedian', true)
hold on; notBoxPlot(fourFoldVerticesWT, 1, 'style','sdline', 'markMedian', true)
set(gca, 'xtick', 1:2, 'xticklabels', {'WT', 'Mbs-RNAi'});

[~, pValue] = kstest2(fourFoldVerticesMbs, fourFoldVerticesWT);
sigstar([1,2], pValue);

%ylimBig = ylim;
%ylim([0, ylimBig(2)])


end

