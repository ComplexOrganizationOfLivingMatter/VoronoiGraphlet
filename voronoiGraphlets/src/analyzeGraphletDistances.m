function [ ] = analyzeGraphletDistances(currentPath, typeOfDistance)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    fullPathGraphlet = strcat(currentPath, typeOfDistance ,'.txt');
    graphletNameSplitted = strsplit(fullPathGraphlet, '\');
    graphletName = graphletNameSplitted(end);
    graphletName = graphletName{1};
    distanceMatrixInit = dlmread(fullPathGraphlet, '\t', 1, 1);
    names = importfileNames(fullPathGraphlet);
    [names, it] = sort(names);
    distanceMatrix = distanceMatrixInit(it, it);

%     %% Against Hexagons
%     
%     save(strcat(currentPath, 'distanceMatrix', upper(typeOfDistance) ,'.mat'), 'distanceMatrix', 'names');
%     
% %     dis = distanceMatrix(22:end, 22:end);
% %     n = names(22:end);
% %     p = cmdscale(dis);
% %     
% %     figure;
% %     hold on;
% %     for i = 1:length(p)
% %         if isempty(strfind(n{i}, 'azules')) == 0
% %             plot(p(i, 1), plot(i, 2), '-' ,'Color', [1 0 1]);
% %         else
% %             plot(p(i, 1), plot(i, 2), 'o', 'Color', [1 0 1]);
% %         end
% %     end
%     
%     %% Against Voronoi 1
%     voronoiDiagram1 = cellfun(@(x) isempty(strfind(x, 'Diagrama_001')) == 0 & isempty(strfind(x, 'weight')), names);
%     distanceMatrix = distanceMatrix(:, voronoiDiagram1);
%     distanceMatrix = distanceMatrix(2:end, :);
%     differenceMean = mean(distanceMatrix, 2);
%     %names = names(voronoiDiagram1 == 0);
%     names = names(2:end);
%     
%     save(strcat(currentPath, 'distanceMatrixVoronoi1', upper(typeOfDistance) ,'.mat'), 'distanceMatrix', 'names', 'differenceMean');
    
    %% Against Voronoi 5
    
    voronoiDiagram5 = cellfun(@(x) isempty(strfind(x, 'Diagrama_005')) == 0 & isempty(strfind(x, 'weight')), names);
    distanceMatrix = distanceMatrix(:, voronoiDiagram5);
    distanceMatrix = distanceMatrix(2:end, :);
    differenceMean = mean(distanceMatrix, 2);
    %names = names(voronoiDiagram1 == 0);
    names = names(2:end);
    
    save(strcat(currentPath, 'distanceMatrixVoronoi5', upper(typeOfDistance) ,'.mat'), 'distanceMatrix', 'names', 'differenceMean');
end

