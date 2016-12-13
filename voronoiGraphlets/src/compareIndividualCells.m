function [ ] = compareIndividualCells( currentPath, numNeighbours, typeOfDistance )
%COMPAREINDIVIDUALCELLS Summary of this function goes here
%   Detailed explanation goes here
    if numNeighbours == 0
        fullPathGraphlet = strcat(currentPath, typeOfDistance, '.txt');
    else
        fullPathGraphlet = strcat(currentPath, num2str(numNeighbours), '\', typeOfDistance, '.txt');
    end
    
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
    colors(1, :) = [0.4 0.4 0.4]; %voronoi 01
    colors(2, :) = [1.0 0.0 0.0]; %dWP
    colors(3, :) = [0.0 0.0 1.0]; %Eye cone cells
    colors(4, :) = [0.0 1.0 0.0]; %Eye photoreceptor
    colors(5, :) = [0.4 0.4 0.4]; %Eye normal cells
    
    h = zeros(numberOfTypes);
    blueCells = 0;
    greenCells = 0;
    normalCells = 0;
    for i = 1:length(names)
        numType = 0;
        if isempty(strfind(names{i} ,'image')) == 0
            numType = 1;
        elseif isempty(strfind(names{i} ,'dWP')) == 0
            numType = 2;
        elseif isempty(strfind(names{i} ,'omm')) == 0
            if isempty(strfind(names{i} ,'azul')) == 0
                if points(i, 1) < 0 && points(i, 2) < 0
                    blueCells = blueCells + 1;
                end
                numType = 3;
            elseif isempty(strfind(names{i} ,'verdes')) == 0
                if points(i, 1) < 0 && points(i, 2) < 0
                    greenCells = greenCells + 1;
                    disp(names{i});
                end
                numType = 4;
            else
                if points(i, 1) < 0 && points(i, 2) < 0
                    normalCells = normalCells + 1;
                end
                numType = 5;
            end
        end
        
        if numType ~= 0
            h(numType, :) = plot(points(i, 1), points(i, 2), 'o', 'color', colors(numType, :));
        else
            disp(strcat('No display: ', names{i}));
        end
    end
    
    disp(strcat('Normal: ', num2str(normalCells), '. Photoreceptor: ', num2str(greenCells), '. Cone: ', num2str(blueCells)));
    currentPathSplitted = strsplit(currentPath, '\');
    
    title(strcat('individual cells ', currentPathSplitted{end-1}, ' num neighbours ', num2str(numNeighbours)));
    legendNames = {'Voronoi', 'dWP', 'Eye cone cells', 'Eye photoreceptors', 'Eye normal cells'};
    legend(h(h(:, 1) > 0, 1), legendNames(h(:, 1) > 0)', 'Location', 'best', 'EdgeColor', [1 1 1]);
    
    saveas(h1, strcat('individualCells_', currentPathSplitted{end-1}, '_numNeighbours_', num2str(numNeighbours)), 'fig');
end

