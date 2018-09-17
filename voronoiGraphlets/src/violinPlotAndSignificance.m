function [] = violinPlotAndSignificance(fourFoldVerticesMbs, fourFoldVerticesWT)
%VIOLINPLOTANDSIGNIFICANCE Summary of this function goes here
%   Detailed explanation goes here
allData = vertcat(fourFoldVerticesMbs, fourFoldVerticesWT);

groupingMbs = repmat({'Mbs-RNAi'}, size(fourFoldVerticesMbs, 1), 1);
groupingWT = repmat({'WT'}, size(fourFoldVerticesWT, 1), 1);

groupingAll = vertcat(groupingMbs, groupingWT);
figure;violinplot(allData, groupingAll);

[~, pValue] = kstest2(fourFoldVerticesMbs, fourFoldVerticesWT);

sigstar([1,2], pValue)
end

