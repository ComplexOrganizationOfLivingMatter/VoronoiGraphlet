function [ ] = compare3D( currentPath, kindOfGraphics )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    set(0,'DefaultAxesFontName', 'Helvetica-Narrow', 'DefaultAxesFontSize', 30, 'DefaultLineMarkerSize', 18)
    clearvars -except currentPath kindOfGraphics
    unifyDistances(currentPath);
    if isequal(kindOfGraphics, 'RV_V5')
        load(strrep(strcat(currentPath, 'allDifferences.mat'), 'AgainstVoronoi1', 'AgainstVoronoi5'))
    else
        load(strrep(strcat(currentPath, 'allDifferences.mat'), 'AgainstHexagons', 'AgainstVoronoi5'))
    end
    nameFiles = namesFinal;
    percentageOfHexagons = differenceWithRegularHexagon';
    load(strcat(currentPath, 'allDifferences.mat'))
    differenceWithRegularHexagon = differenceWithRegularHexagon';
    names = namesFinal;
    names = cellfun(@(x) strsplit(x, '/'), names, 'UniformOutput', false);
    names = cellfun(@(x) x{end}, names, 'UniformOutput', false);
    names = cellfun(@(x) strrep(x, '_', '-'), names, 'UniformOutput', false);
    names = cellfun(@(x) strrep(x, 'adjacencyMatrix', ''), names, 'UniformOutput', false);
    names = cellfun(@(x) strrep(x, '-data', ''), names, 'UniformOutput', false);
    names = cellfun(@(x) x(1:end), names, 'UniformOutput', false);
    namesToCompare = cellfun(@(x) strrep(x, '-OnlyWeightedCells', ''), names, 'UniformOutput', false);
    namesToCompare = cellfun(@(x) strrep(x, '-OnlyNeighboursOfWeightedCells', ''), namesToCompare, 'UniformOutput', false);
    

    nameFiles = cellfun(@(x) strsplit(x, '/'), nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) x{end}, nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) strrep(x, '_', '-'), nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) strrep(x, 'adjacencyMatrix', ''), nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) strrep(x, '-data', ''), nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) x(1:end), nameFiles, 'UniformOutput', false);
    
    rightPercentages = zeros(1, size(names, 2));
    for numName = 1:size(nameFiles, 2)
        numFound = find(cellfun(@(x) isequal(nameFiles{numName}, x ), names, 'UniformOutput', true) == 1);
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
    differenceRV = percentageOfHexagons;
    
    
    %% Loading percentage of hexagons and coupling with the previous results
    if isempty(strfind(currentPath, 'maxLength5'))
        load('results\comparisons\EveryFile\percentageOfHexagons-Weighted_maxLength4.mat')
    else
        load('results\comparisons\EveryFile\percentageOfHexagons-Weighted_maxLength5.mat')
    end
    nameFiles = cellfun(@(x) strsplit(x, '\'), nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) x{end}, nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) x(1:end-7), nameFiles, 'UniformOutput', false);
    nameFiles = cellfun(@(x) strrep(x, '_', '-'), nameFiles, 'UniformOutput', false);
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
    if sum(percentageOfHexagons == 0) > 0
        error('Wrong percentages');
    end

    h1 = figure('units','normalized','outerposition',[0 0 1 1], 'Color', [1 1 1]);
    classes = {'BC' 'BCA' [0 0.200000000000000 0];
    'omm' 'Eye' [1 0.400000000000000 0];
    'cNT' 'cNT' [0.200000000000000 0.800000000000000 1];
    'dWL' 'dWL' [0 0.600000000000000 0];
    'dWP' 'dWP' [1 0 0];
    'imagen' 'CVT' [0.800000000000000 0.800000000000000 0.800000000000000];
    'half' 'CVTw1' [0.200000000000000 0.600000000000000 0.600000000000000];
    'Case-II' 'Case II' [0 0 0.600000000000000];
    'Case-III' 'Case III' [1 0.800000000000000 1];
    'Case-IV' 'Case IV' [1 0.200000000000000 1];
    'dMWP' 'dMWP' [0.800000000000000 0 0.600000000000000];
    'Atrophy-Sim' 'Atrophy' [0.600000000000000 0 1];
    'Control-Sim-Prol' 'Control' [0.200000000000000 0.800000000000000 1];
    'Control-Sim-no-Prol' 'Control No Prol' [1 1 0];
    'BNA' 'BNA' [0 0 0];
    'half' 'CVTw2' [0.200000000000000 0.400000000000000 0.600000000000000];
    'neo' 'Neo' [0.200000000000000 0.400000000000000 0.600000000000000];
    'rosetta' 'Rosetta' [0.400000000000000 0 0];
    'voronoiNoise' 'CVTn' [1 0 0.315789473684211]};
    plottingInfo(currentPath, h1, differenceWithRegularHexagon, differenceRV, percentageOfHexagons, names);
    
end

