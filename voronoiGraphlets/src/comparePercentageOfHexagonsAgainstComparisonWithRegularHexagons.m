function [ ] = comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( currentPath, kindOfGraphics )
%comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons Summary of this function goes here
%   Detailed explanation goes here
    set(0,'DefaultAxesFontName', 'Helvetica-Narrow', 'DefaultAxesFontSize', 30, 'DefaultLineMarkerSize', 18)
    clearvars -except currentPath kindOfGraphics
    unifyDistances(currentPath);
    
    %total graphlets
%     totalGraphletsPath = strrep(currentPath, 'EveryFile', 'Total');
%     unifyDistances(totalGraphletsPath);
%     load(strcat(totalGraphletsPath, 'allDifferences.mat'))
    
    %%GDDRV vs GDDRH
    if isequal(kindOfGraphics, 'GDDRV_GDDH')
        load(strrep(strcat(currentPath, 'allDifferences.mat'), 'AgainstVoronoi1', 'AgainstHexagons'))
    elseif isequal(kindOfGraphics, 'GDDV5_GDDH')
        load(strrep(strcat(currentPath, 'allDifferences.mat'), 'AgainstVoronoi5', 'AgainstHexagons'))
    elseif isequal(kindOfGraphics, 'GDDV5_GDDRV')
        load(strrep(strcat(currentPath, 'allDifferences.mat'), 'AgainstVoronoi5', 'AgainstVoronoi1'))
    elseif isequal(kindOfGraphics, 'GDDRV_GDDV5')
        load(strrep(strcat(currentPath, 'allDifferences.mat'), 'AgainstVoronoi1', 'AgainstVoronoi5'))
    end
        

    if isequal(kindOfGraphics, '') == 0
        nameFiles = namesFinal;
        percentageOfHexagons = differenceWithRegularHexagon';

        
        nameFiles = cellfun(@(x) strsplit(x, '/'), nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) x{end}, nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) strrep(x, '_', '-'), nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) strrep(x, 'adjacencyMatrix', ''), nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) strrep(x, '-data', ''), nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) x(1:end), nameFiles, 'UniformOutput', false);

        load(strcat('results\comparisons\Total\maxLength5WithoutJumps\AgainstHexagons\', 'allDifferences.mat'))
        names2 = cellfun(@(x) strsplit(x, '/'), namesFinal, 'UniformOutput', false);
        names2 = cellfun(@(x) x{end}, names2, 'UniformOutput', false);
        names2 = cellfun(@(x) strrep(x, '_', '-'), names2, 'UniformOutput', false);
        names2 = cellfun(@(x) strrep(x, 'adjacencyMatrix', ''), names2, 'UniformOutput', false);
        names2 = cellfun(@(x) strrep(x, '-data', ''), names2, 'UniformOutput', false);
        names2 = cellfun(@(x) x(1:end), names2, 'UniformOutput', false);
        for i = 1:length(names2)
            if isempty(strfind(names2{i}, 'totalGraphlets')) == 0
                nameDiagram = strsplit(names2{i}, '-');
                if length(nameDiagram) >= 7 && isequal(nameDiagram{7}, 'totalGraphlets')
                    meanImages = cellfun(@(x) isempty(strfind(x, nameDiagram{2})) == 0 & isempty(strfind(x, nameDiagram{3})) == 0 & isempty(strfind(x, nameDiagram{end-1})) == 0 & isempty(strfind(x, 'totalGraphlets')), nameFiles);
                elseif isempty(strfind(names2{i}, 'voronoiNoise')) == 0
                    meanImages = cellfun(@(x) isempty(strfind(x, nameDiagram{1})) == 0 & isempty(strfind(x, nameDiagram{2})) == 0 & isempty(strfind(x, 'totalGraphlets')), nameFiles);
                elseif isempty(strfind(names2{i}, 'imagen')) == 0
                    meanImages = cellfun(@(x) isempty(strfind(x, nameDiagram{1})) == 0 & isempty(strfind(x, nameDiagram{3})) == 0 & isempty(strfind(x, 'totalGraphlets')), nameFiles);
                else
                    meanImages = cellfun(@(x) isempty(strfind(x, strjoin(nameDiagram(1:end-1), '-'))) == 0 & isempty(strfind(x, 'totalGraphlets')), nameFiles);
                end
                nameFiles = {names2{i}, nameFiles{:}};
                percentageOfHexagons = [mean(percentageOfHexagons(meanImages)); percentageOfHexagons];
            end
        end
        load(strcat(currentPath, 'allDifferences.mat'))
        differenceWithRegularHexagonToAppend = differenceWithRegularHexagon';
        namesToAppend = namesFinal;
        
        
        %%%%% Not really used! CARE!!!!!!
        load(strcat('results\comparisons\Total\maxLength5WithoutJumps\AgainstHexagons\', 'allDifferences.mat'))
        notWanted = cellfun(@(x) isempty(strfind(x, 'imagen')) == 0 & isempty(strfind(x, '001')) == 0 & isempty(strfind(x, 'totalGraphlets')), namesFinal);
        differenceWithRegularHexagon = vertcat(differenceWithRegularHexagon(notWanted == 0)', differenceWithRegularHexagonToAppend);
        names = {namesFinal{notWanted == 0}, namesToAppend{:}};
        %%%%% END CARE!!!!
        
        names = cellfun(@(x) strsplit(x, '/'), names, 'UniformOutput', false);
        names = cellfun(@(x) x{end}, names, 'UniformOutput', false);
        names = cellfun(@(x) strrep(x, '_', '-'), names, 'UniformOutput', false);
        names = cellfun(@(x) strrep(x, 'adjacencyMatrix', ''), names, 'UniformOutput', false);
        names = cellfun(@(x) strrep(x, '-data', ''), names, 'UniformOutput', false);
        namesToCompare = cellfun(@(x) x(1:end), names, 'UniformOutput', false);
    else
        load(strcat(currentPath, 'allDifferences.mat'))
        differenceWithRegularHexagonToAppend = differenceWithRegularHexagon';
        namesToAppend = namesFinal;
        
        
        %%%%% Not really used! CARE!!!!!!
        load(strcat('results\comparisons\Total\maxLength5WithoutJumps\AgainstHexagons\', 'allDifferences.mat'))
        notWanted = cellfun(@(x) isempty(strfind(x, 'imagen')) == 0 & isempty(strfind(x, '001')) == 0 & isempty(strfind(x, 'totalGraphlets')), namesFinal);
        differenceWithRegularHexagon = vertcat(differenceWithRegularHexagon(notWanted == 0)', differenceWithRegularHexagonToAppend);
        names = {namesFinal{notWanted == 0}, namesToAppend{:}};
        %%%%% END CARE!!!!
        
        if isempty(strfind(currentPath, 'maxLength5'))
            load('results\comparisons\EveryFile\percentageOfHexagons-Weighted_maxLength4.mat')
        else
            load('results\comparisons\EveryFile\percentageOfHexagons-Weighted_maxLength5.mat')
        end
        
        names = cellfun(@(x) strsplit(x, '/'), names, 'UniformOutput', false);
        names = cellfun(@(x) x{end}, names, 'UniformOutput', false);
        names = cellfun(@(x) strrep(x, '_', '-'), names, 'UniformOutput', false);
        names = cellfun(@(x) strrep(x, 'adjacencyMatrix', ''), names, 'UniformOutput', false);
        names = cellfun(@(x) strrep(x, '-data', ''), names, 'UniformOutput', false);
        names = cellfun(@(x) x(1:end), names, 'UniformOutput', false);
        namesToCompare = cellfun(@(x) strrep(x, '-OnlyWeightedCells', ''), names, 'UniformOutput', false);
        namesToCompare = cellfun(@(x) strrep(x, '-OnlyNeighboursOfWeightedCells', ''), namesToCompare, 'UniformOutput', false);
        
        nameFiles = cellfun(@(x) strsplit(x, '\'), nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) x{end}, nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) x(1:end-7), nameFiles, 'UniformOutput', false);
        nameFiles = cellfun(@(x) strrep(x, '_', '-'), nameFiles, 'UniformOutput', false);
    end

    
    rightPercentages = zeros(1, size(names, 2));
    for numName = 1:size(nameFiles, 2)
        numFound = find(cellfun(@(x) isequal(nameFiles{numName}, x ), namesToCompare, 'UniformOutput', true) == 1);
        if size(numFound, 1) > 1
            error('MEEEEC');
        end
        if isempty(numFound) == 0
                rightPercentages(1, numFound) = percentageOfHexagons(numName);
%             rightPercentages(1, numFound) = points1Dimension(numName);
        else
            nameFiles{numName};
        end
    end
    percentageOfHexagons = rightPercentages;
    if size(percentageOfHexagons, 2) ~= size(differenceWithRegularHexagon, 1)
        error('No matrix coincidence on size');
    end
    
%     if sum(percentageOfHexagons == 0) > 0
%         error('Wrong percentages');
%     end

    
    h1 = figure('units','normalized','outerposition',[0 0 1 1], 'Color', [1 1 1], 'visible', 'off');
%     classes = {'BC' 'BCA' [0 0.200000000000000 0];
%     'omm' 'Eye' [1 0.400000000000000 0];
%     'cNT' 'cNT' [0.200000000000000 0.800000000000000 1];
%     'dWL' 'dWL' [0 0.600000000000000 0];
%     'dWP' 'dWP' [1 0 0];
%     'imagen' 'CVT' [0.800000000000000 0.800000000000000 0.800000000000000];
%     'disk' 'CVTw1' [0.200000000000000 0.600000000000000 0.600000000000000];
%     'Case-II' 'Case II' [0 0 0.600000000000000];
%     'Case-III' 'Case III' [1 0.800000000000000 1];
%     'Case-IV' 'Case IV' [1 0.200000000000000 1];
%     'dMWP' 'dMWP' [0.800000000000000 0 0.600000000000000];
%     'Atrophy-Sim' 'Atrophy' [0.600000000000000 0 1];
%     'Control-Sim-Prol' 'Control' [0.200000000000000 0.800000000000000 1];
%     'Control-Sim-no-Prol' 'Control No Prol' [1 1 0];
%     'BNA' 'BNA' [0 0 0];
%     'disk' 'CVTw2' [0.200000000000000 0.400000000000000 0.600000000000000];
%     'neo' 'Neo' [0.200000000000000 0.400000000000000 0.600000000000000];
%     'rosetta' 'Rosetta' [0.400000000000000 0 0];
%     'voronoiNoise' 'CVTn' [1 0 0.315789473684211]};
%     
%     indicesSelected = [7, 16, 19];
%     
%     meanIndices = cellfun(@(x) isempty(strfind(x, 'totalGraphlets')) == 0, names);
%     [~] = plottingInfo(currentPath, h1, differenceWithRegularHexagon(meanIndices == 0, :), percentageOfHexagons(:, meanIndices == 0), [], names(meanIndices == 0), classes(indicesSelected, :), 0);
%     [figureValues] = plottingInfo(currentPath, h1, differenceWithRegularHexagon(meanIndices, :), percentageOfHexagons(:, meanIndices), [], names(meanIndices), classes(indicesSelected, :), 1);
%     
    numberOfTypes = 19;
    colors = hsv(numberOfTypes);
    colors(1, :) = [0.0 0.2 0.0]; %BCA
    colors(2, :) = [1.0 0.4 0.0]; %Eye
    colors(3, :) = [0.2 0.8 1.0]; %cNT
    colors(4, :) = [0.0 0.6 0.0]; %dWL
    colors(5, :) = [1.0 0.0 0.0]; %dWP
    colors(6, :) = [0.8 0.8 0.8]; %voronoi
    colors(7, :) = [0.2 0.6 0.6]; %voronoiWeighted Cancer
    colors(8, :) = [0.0 0.0 0.6]; %voronoiWeighted Neighbours
    %colors(8, :) = [1.0 1.0 0.0]; %voronoiNoise
    colors(9, :) = [1.0 0.8 1.0]; %Case II
    colors(10, :) = [1.0 0.2 1.0]; %Case III
    colors(11, :) = [0.8 0.0 0.6]; %Case IV
    colors(12, :) = [0.6 0.0 1.0]; %dMWP
    colors(13, :) = [0.2 0.8 1.0]; %Atrophy Sim
    colors(15, :) = [0.0 0.0 0.0]; %Control Sim No Prol
    colors(14, :) = [1.0 1.0 0.0]; %Control Sim Prol
    colors(16, :) = [0.2 0.4 0.6]; %BNA
    colors(17, :) = [0.2 0.4 0.6]; %Neo or dWLm
    colors(18, :) = [0.4 0.0 0.0]; %rosetta
    h = zeros(numberOfTypes);
    hold on;
    indices = [1:20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500, 600, 700];
    indicesWeighted = [4 10:10:80];
    offSetGraysFont = 10;
    graysFont = gray(length(indices) + offSetGraysFont);
    
    coloursCVTw2 = createGradient([0 102 255] / 255, colors(8, :), length(indicesWeighted));
    coloursCVTw1 = createGradient([53 238 219] / 255, colors(7, :), length(indicesWeighted));
    
    
    %graysFont = graysFont(end:-1:1, :);
    pointColors = zeros(length(names), 3);
%     for i = 1:size(names, 2)
%         if isempty(strfind(names{i}, 'totalGraphlets'))
% %             if isempty(strfind(names{i}, 'voronoiNoise')) == 0
% %                 nameDiagram = strsplit(names{i}, '-');
% %                 h(7, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', graysFont (indices == str2num(nameDiagram{5}), :));
% %                 pointColors(i, :) = graysFont (indices == str2num(nameDiagram{5}));
%             if isempty(strfind(names{i}, 'imagen')) == 0
%                 nameDiagram = strsplit(names{i}, '-');
%                 h(6, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', graysFont (indices == str2num(nameDiagram{4}), :));
%                 pointColors(i, :) = graysFont (indices == str2num(nameDiagram{4}));
%             end
%         end
%     end

    for i = 1:size(names, 2)
        if isempty(strfind(names{i}, 'totalGraphlets'))
%             if isempty(strfind(names{i}, 'omm')) == 0
%                 h(2, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(2, :));
%                 pointColors(i, :) =  colors(2, :);
% %             elseif isempty(strfind(names{i}, 'BC')) == 0
% %                 h(1, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(1, :));
% %                 pointColors(i, :) =  colors(1, :);
%             elseif isempty(strfind(names{i}, 'cNT')) == 0
%                 h(3, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(3, :));
%                 pointColors(i, :) =  colors(3, :);
%             elseif isempty(strfind(names{i}, 'dWL')) == 0
%                 h(4, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(4, :));
%                 pointColors(i, :) =  colors(4, :);
%             elseif isempty(strfind(names{i}, 'dWP')) == 0
%                 h(5, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(5, :));
%                 pointColors(i, :) =  colors(5, :);
%             if isempty(strfind(names{i}, 'disk')) == 0 %voronoiWeighted
%                 nameDiagram = strsplit(names{i}, '-');
%                 if ismember(str2double(nameDiagram{6}), indicesWeighted)
%                     if isempty(strfind(names{i}, 'Neighbours'))
%                         h(8, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(7, :));
%                 pointColors(i, :) =  colors(7, :);
%                     else
%                         h(17, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(8, :));
%                 pointColors(i, :) =  colors(8, :);
%                     end
%                 end
            if isempty(strfind(names{i}, 'Case-III')) == 0
                h(10, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(10, :));
                pointColors(i, :) =  colors(10, :);
%             elseif isempty(strfind(names{i}, 'Case-II')) == 0
%                 h(9, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(9, :));
%                 pointColors(i, :) =  colors(9, :);
            elseif isempty(strfind(names{i}, 'Case-IV')) == 0
                h(11, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(11, :));
                pointColors(i, :) =  colors(11, :);
            elseif isempty(strfind(names{i}, 'dMWP')) == 0
                h(12, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(12, :));
                pointColors(i, :) =  colors(12, :);
% %             elseif isempty(strfind(names{i}, 'Atrophy-Sim')) == 0
% %                 h(13, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(13, :));
% %                 pointColors(i, :) =  colors(13, :);
            elseif isempty(strfind(names{i}, 'Control-Sim-Prol')) == 0
                h(14, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(14, :));
                pointColors(i, :) =  colors(14, :);
%             elseif isempty(strfind(names{i}, 'Control-Sim-no-Prol')) == 0
%                 h(15, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(15, :));
%                 pointColors(i, :) =  colors(15, :);
%             elseif isempty(strfind(names{i}, 'BNA')) == 0
%                 h(16, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(16, :));
%                 pointColors(i, :) =  colors(16, :);
%             elseif isempty(strfind(names{i}, 'neo')) == 0
%                 nameDiagram = strsplit(names{i}, '-');
%                 h(18, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(17, :));
%                 t1 = text(differenceWithRegularHexagon(i),percentageOfHexagons(i), nameDiagram{2});
%                 t1.FontSize = 5;
%                 t1.HorizontalAlignment = 'center';
%                 t1.VerticalAlignment = 'middle';
%                 pointColors(i, :) =  colors(17, :);
%             elseif isempty(strfind(names{i}, 'rosetta')) == 0
%                 nameDiagram = strsplit(names{i}, '-');
%                 pointColors(i, :) =  colors(18, :);
%                 h(19, :) = plot(differenceWithRegularHexagon(i), percentageOfHexagons(i), 'o', 'color', colors(18, :));
%                 numDiagram = nameDiagram{2};
%                 t1 = text(differenceWithRegularHexagon(i),percentageOfHexagons(i), num2str(str2num(numDiagram)));
%                 t1.FontSize = 10;
%                 t1.FontName = 'Helvetica-Narrow';
%                 t1.HorizontalAlignment = 'center';
%                 t1.VerticalAlignment = 'middle';
                    %         else
    %             names{i};
            end
        end
    end
    
    %%Total graphlets (or means)
    indicesTotalGraphlets = cellfun(@(x) isempty(strfind(x, 'totalGraphlets')) == 0, names);
    namesTotalGraphlets = names(indicesTotalGraphlets);
    percentageOfHexagonsTotalGraphlets = percentageOfHexagons(indicesTotalGraphlets);
    %differenceWithRegularHexagonTotalGraphlets = differenceWithRegularHexagon(indicesTotalGraphlets);
    for i = 1:size(namesTotalGraphlets, 2)
        if isempty(strfind(namesTotalGraphlets{i}, 'totalGraphlets')) == 0
            if isempty(strfind(namesTotalGraphlets{i}, 'voronoiNoise')) == 0
                nameDiagram = strsplit(namesTotalGraphlets{i}, '-');
                meanImages = cellfun(@(x) isempty(strfind(x, 'voronoiNoise')) == 0 & isempty(strfind(x, nameDiagram{2})) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(7, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', graysFont (indices == str2num(nameDiagram{2}), :), 'MarkerFaceColor', graysFont (indices == str2num(nameDiagram{2}), :));
%             if isempty(strfind(namesTotalGraphlets{i}, 'imagen')) == 0
%                 nameDiagram = strsplit(namesTotalGraphlets{i}, '-');
%                 meanImages = cellfun(@(x) isempty(strfind(x, 'imagen')) == 0 & isempty(strfind(x, nameDiagram{3})) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
%                 h(6, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', graysFont (indices == str2num(nameDiagram{3}), :), 'MarkerFaceColor', graysFont (indices == str2num(nameDiagram{3}), :));
            end
        end
    end
    
    for i = 1:size(namesTotalGraphlets, 2)
        meanImages = 0;
        if isempty(strfind(namesTotalGraphlets{i}, 'totalGraphlets')) == 0
            if isempty(strfind(namesTotalGraphlets{i}, 'omm')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'omm')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(2, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(2, :), 'MarkerFaceColor', colors(2, :));
                %h(2, :) = plot(mean(differenceWithRegularHexagon(meanImages)), 28.12, 'o', 'color', colors(2, :), 'MarkerFaceColor', colors(2, :));
                %         elseif isempty(strfind(names{i}, 'BC')) == 0
                %             h(1, :) = plot(differenceWithRegularHexagonTotalGraphlets, percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(1, :));
            elseif isempty(strfind(namesTotalGraphlets{i}, 'cNT')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'cNT')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(3, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(3, :), 'MarkerFaceColor', colors(3, :));
                %h(3, :) = plot(mean(differenceWithRegularHexagon(meanImages)), 28.30, 'o', 'color', colors(3, :), 'MarkerFaceColor', colors(3, :));
            elseif isempty(strfind(namesTotalGraphlets{i}, 'dWL')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'dWL')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(4, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(4, :), 'MarkerFaceColor', colors(4, :));
                %h(4, :) = plot(mean(differenceWithRegularHexagon(meanImages)), 44.37, 'o', 'color', colors(4, :), 'MarkerFaceColor', colors(4, :));
            elseif isempty(strfind(namesTotalGraphlets{i}, 'dWP')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'dWP')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(5, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(5, :), 'MarkerFaceColor', colors(5, :));
                %h(5, :) = plot(mean(differenceWithRegularHexagon(meanImages)), 48.10, 'o', 'color', colors(5, :), 'MarkerFaceColor', colors(5, :));
%             elseif isempty(strfind(namesTotalGraphlets{i}, 'disk')) == 0 %voronoiWeighted
%                 nameDiagram = strsplit(namesTotalGraphlets{i}, '-');
%                 [inIndices, colourIndex] = ismember(str2double(nameDiagram{3}), indicesWeighted);
%                 if inIndices
%                     if isempty(strfind(namesTotalGraphlets{i}, 'Neighbours'))
%                         nameDiagram{3};
%                         meanImages = cellfun(@(x) isempty(strfind(x, 'disk')) == 0 & isempty(strfind(x, strcat('-', nameDiagram{3}, '-'))) == 0 & isempty(strfind(x, 'Neighbours')) & isempty(strfind(x, 'totalGraphlets')), names);
%                         h(8, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(7, :), 'MarkerFaceColor', coloursCVTw1(colourIndex, :));
% %                         t1 = text(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), num2str(str2num(nameDiagram{3})));
% %                         t1.FontSize = 10;
% %                         t1.HorizontalAlignment = 'center';
% %                         t1.VerticalAlignment = 'middle';
% %                         t1.Color = 'red';
%                     else
%                         meanImages = cellfun(@(x) isempty(strfind(x, 'disk')) == 0 & isempty(strfind(x, strcat('-', nameDiagram{3}, '-'))) == 0 & isempty(strfind(x, 'Neighbours')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
%                         h(17, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(8, :), 'MarkerFaceColor', coloursCVTw2(colourIndex, :));
% %                         t1 = text(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), num2str(str2num(nameDiagram{3})));
% %                         t1.FontSize = 10;
% %                         t1.HorizontalAlignment = 'center';
% %                         t1.VerticalAlignment = 'middle';
% %                         t1.Color = 'red';
%                     end
%                 end
            elseif isempty(strfind(namesTotalGraphlets{i}, 'Case-III')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'Case-III')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(10, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(10, :), 'MarkerFaceColor', colors(10, :));
%             elseif isempty(strfind(namesTotalGraphlets{i}, 'Case-II')) == 0 && isempty(strfind(namesTotalGraphlets{i}, 'Case-III'))
%                 meanImages = cellfun(@(x) isempty(strfind(x, 'Case-II')) == 0 & isempty(strfind(x, 'Case-III')) & isempty(strfind(x, 'totalGraphlets')), names);
%                 h(9, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(9, :), 'MarkerFaceColor', colors(9, :));
            elseif isempty(strfind(namesTotalGraphlets{i}, 'Case-IV')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'Case-IV')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(11, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(11, :), 'MarkerFaceColor', colors(11, :));
            elseif isempty(strfind(namesTotalGraphlets{i}, 'dMWP')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'dMWP')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(12, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(12, :), 'MarkerFaceColor', colors(12, :));
                %h(12, :) = plot(mean(differenceWithRegularHexagon(meanImages)), 35.77, 'o', 'color', colors(12, :), 'MarkerFaceColor', colors(12, :));
    %             elseif isempty(strfind(namesTotalGraphlets{i}, 'Atrophy-Sim')) == 0
    %                 h(13, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(13, :), 'MarkerFaceColor', colors(13, :));
            elseif isempty(strfind(namesTotalGraphlets{i}, 'Control-Sim-Prol')) == 0
                meanImages = cellfun(@(x) isempty(strfind(x, 'Control-Sim-Prol')) == 0 & isempty(strfind(x, 'totalGraphlets')), names);
                h(14, :) = plot(mean(differenceWithRegularHexagon(meanImages)), percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(14, :), 'MarkerFaceColor', colors(14, :));
%     %             elseif isempty(strfind(namesTotalGraphlets{i}, 'Control-Sim-no-Prol')) == 0
%     %                 h(15, :) = plot(differenceWithRegularHexagonTotalGraphlets, percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(15, :), 'MarkerFaceColor', colors(15, :));
%     %             elseif isempty(strfind(namesTotalGraphlets{i}, 'BNA')) == 0
%     %                 h(16, :) = plot(differenceWithRegularHexagonTotalGraphlets, percentageOfHexagonsTotalGraphlets(i), 'o', 'color', colors(16, :), 'MarkerFaceColor', colors(16, :));
%     %         else
%     %             names{i};
            end
        end
    end
    
    newNames = {'BCA', 'Eye', 'cNT', 'dWL', 'dWP', 'CVT', 'CVTn', 'CVTw1', 'Case II', 'Case III', 'Case IV', 'dMWP', 'Atrophy', 'Control', 'Control No Prol', 'BNA', 'CVTw2', 'Neo', 'Rosetta'};
    
    newOrder = [7 2 3 4 5 6 12 14 10 11 8 17];
    newNames = newNames(newOrder);
    h = h(newOrder, :);
    auxLim = xlim;
    xlim([0 auxLim(2)])
    auxLim = ylim;
    currentPathSplitted = strsplit(currentPath, '\');
    set(gca, 'TickDir', 'out')
    set(gca,'FontSize', 50)
    
    %%GDDRV vs GDDRH
    if isequal(kindOfGraphics, '') == 0
        classesUsed = strsplit(kindOfGraphics, '_');
        ylim([0 auxLim(2)])
        
        legend(h(h(:, 1) > 0, 1), newNames(h(:, 1) > 0)', 'Location', 'best', 'EdgeColor', [1 1 1], 'FontSize', 30);
        
        xlabel(classesUsed{1}, 'FontWeight', 'bold', 'FontSize', 30);
        ylabel(classesUsed{2}, 'FontWeight', 'bold', 'FontSize', 30);
        %export_fig(strcat('GDDRV_GDDH', '-', strjoin(newNames(h(:, 1) > 0), '_')), '-pdf', '-r300', '-opengl');
        saveas(h1, strcat(currentPathSplitted{4}, '_', kindOfGraphics, '-', strjoin(newNames(h(:, 1) > 0), '_'), '_', date), 'fig');
    else
        ylim([0 100])
        
        legend(h(h(:, 1) > 0, 1), newNames(h(:, 1) > 0)', 'Location', 'best', 'EdgeColor', [1 1 1], 'FontSize', 30);
        
        ylabel('Percentage of hexagons', 'FontWeight', 'bold', 'FontSize', 30);
        
        if isempty(strfind(currentPath, 'Voronoi1')) == 0
            xlabel('Graphlet degree distance random voronoi (GDDRV)', 'FontWeight', 'bold', 'FontSize', 30);
            saveas(h1, strcat(currentPathSplitted{4}, '_GDDRV_PercentageOfHexagons', '-', strjoin(newNames(h(:, 1) > 0), '_'), '_', date), 'fig');
            %print(h1, strcat('GDDRV_PercentageOfHexagons', '-', strjoin(newNames(h(:, 1) > 0), '_')), '-djpeg', '-r300', '-painters');
        elseif isempty(strfind(currentPath, 'Voronoi5')) == 0
            xlabel('Graphlet degree distance voronoi 5 (GDDV5)', 'FontWeight', 'bold', 'FontSize', 30);
            saveas(h1, strcat(currentPathSplitted{4}, '_GDDV5_PercentageOfHexagons', '-', strjoin(newNames(h(:, 1) > 0), '_'), '_', date), 'fig');
            %print(h1, strcat('GDDV5_PercentageOfHexagons', '-', strjoin(newNames(h(:, 1) > 0), '_')), '-djpeg', '-r300', '-painters');
        else
            xlabel('Graphlet degree distance-hexagons (GDDH)', 'FontWeight', 'bold', 'FontSize', 30);
            saveas(h1, strcat(currentPathSplitted{4}, '_GDDH_PercentageOfHexagons', '-', strjoin(newNames(h(:, 1) > 0), '_'), '_', date), 'fig');
            %set(findall(0,'Type','Line'), 'MarkerSize', 20)
            %print(h1, strcat('GDDH_PercentageOfHexagons', '-', strjoin(newNames(h(:, 1) > 0), '_')), '-djpeg', '-r300', '-painters');
        end
    end
end

