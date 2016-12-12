function [ ] = compareIndividualCells( currentPath, numNeighbours, typeOfDistance )
%COMPAREINDIVIDUALCELLS Summary of this function goes here
%   Detailed explanation goes here
    fullPathGraphlet = strcat(currentPath, num2str(numNeighbours), '\', typeOfDistance, '.txt');
    
    %Sorting distanceMatrix and names
    distanceMatrixInit = dlmread(fullPathGraphlet, '\t', 1, 1);
    names = importfileNames(fullPathGraphlet);
    [names, it] = sort(names);
    distanceMatrix = distanceMatrixInit(it, it);
    
    names = cellfun(@(x) strsplit(x, '/'), names, 'UniformOutput', false);
    names = cellfun(@(x) x{end}, names, 'UniformOutput', false);
    
    [points] = cmdscale(distanceMatrix);
    
    %Figure output
    set(0,'DefaultAxesFontName', 'Helvetica-Narrow', 'DefaultAxesFontSize', 30, 'DefaultLineMarkerSize', 18)
    h1 = figure('units', 'normalized', 'outerposition',[0 0 1 1], 'Color', [1 1 1]);
    hold on;
    
    numberOfTypes = 4;
    colors = hsv(numberOfTypes);
    colors(1, :) = [0.0 0.0 0.0]; %voronoi 01
    colors(2, :) = [1.0 0.0 0.0]; %dWP
    colors(3, :) = [1.0 0.4 0.0]; %Eye
    colors(4, :) = [1.0 0.8 0.0]; %Eye
    
    h = zeros(numberOfTypes);
    for i = 1:length(names)
        numType = 0;
        if isempty(strfind(names{i} ,'image')) == 0
            numType = 1;
        elseif isempty(strfind(names{i} ,'dWP')) == 0
            numType = 2;
        elseif isempty(strfind(names{i} ,'omm')) == 0
            if isempty(strfind(names{i} ,'azul')) == 0
                numType = 3;
            elseif isempty(strfind(names{i} ,'verdes')) == 0
                numType = 4;
            end
        end
        
        if numType ~= 0
            h(numType, :) = plot(points(i, 1), points(i, 2), 'o', 'color', colors(numType, :));
        else
            disp(strcat('No display: ', names{i}));
        end
    end
    
    currentPathSplitted = strsplit(currentPath, '\');
    saveas(h1, strcat('individualCells_', currentPathSplitted{end-1}, '_numNeighbours_', num2str(numNeighbours)), 'fig');
end

