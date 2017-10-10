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

    plottingInfo3D(currentPath, differenceWithRegularHexagon, differenceRV, percentageOfHexagons, names )
end

