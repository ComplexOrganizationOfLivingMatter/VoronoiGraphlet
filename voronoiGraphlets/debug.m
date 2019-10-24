
% differenceMean = distanceMatrix(42:end, 1);
% names = names(42:end, 1);
% % names = nameFiles;
% % differenceMean = percentageOfHexagons;
% indices = [1:20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500, 600, 700];
% meanCVTn = zeros(size(indices, 2), 1);
% stdCVTn = zeros(size(indices, 2), 1);
% for numIndex = 1:size(indices, 2)
%     actualDiagrams = cellfun(@(x) isempty(strfind(x, sprintf('Voronoi_%03d_', indices(numIndex)))) == 0, names);
%     
%     meanCVTn(numIndex) = mean(differenceMean(actualDiagrams));
%     stdCVTn(numIndex) = std(differenceMean(actualDiagrams));
% end

addpath(genpath('src'));

fourFoldVerticesMbs = [0.018
0.012
0.018
0.016
0.000
0.009
0.008
0.009
0.014];

fourFoldVerticesWT = [0.007
0.000
0.010
0.005
0.002
0.002
0.020
0.013
0.015
0.003
0.008
0.008
0.004
0.000
0.008
0.004
0.004
0.004];

violinPlotAndSignificance(fourFoldVerticesMbs, fourFoldVerticesWT);

t1sWT = [0.054096638
0.150826754
0.066666667
0.127272727
0.241666667];

t1sMbs = [0.016025641
0
0
0.02173913
0];

violinPlotAndSignificance(t1sMbs, t1sWT);