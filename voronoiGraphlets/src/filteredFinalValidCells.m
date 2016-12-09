function [ finalValidCells ] = filteredFinalValidCells(validCells, neighbours, maxPathLength, fullPathFile, differenciatedCells, filterFiles )
%FILTEREDFINALVALIDCELLS Summary of this function goes here
%   Detailed explanation goes here
    neighboursEmpty = cellfun(@(x) isempty(x), neighbours);
    maxCellLabel = max(cellfun(@(x) max(x), neighbours(neighboursEmpty == 0)));
    noValidCells = setxor(1:maxCellLabel, validCells);

    if length(neighbours) ~= (length(noValidCells) + length(validCells))
        error('Incorrect number of no valid cells');
    end

    finalValidCells = [];
    
    for numCell = 1:length(neighbours)
        neighboursInMaxPathLength = [];
        antNeighbours = [neighbours{numCell}];
        noValidCellsInPath = intersect(noValidCells, antNeighbours);
        neighboursInMaxPathLength = unique(horzcat(neighboursInMaxPathLength, antNeighbours'));

        if isempty(noValidCellsInPath) == 0
            continue %it is a no valid cell
        end
        pathLengthActual = 3;
        while pathLengthActual <= maxPathLength
            actualNeighbours = vertcat(neighbours{antNeighbours});
            neighboursInMaxPathLength = unique(horzcat(neighboursInMaxPathLength, actualNeighbours'));
            antNeighbours = actualNeighbours;
            pathLengthActual = pathLengthActual + 1;
        end

        noValidCellsInPath = intersect(noValidCells, neighboursInMaxPathLength);

        if isempty(noValidCellsInPath)
            %Only wants the cells that intervine (i.e. the weighted cells and their neighbours)
            if isempty(strfind(fullPathFile, filterFiles)) == 0
                if sum(ismember(neighboursInMaxPathLength, differenciatedCells)) > 0
                    finalValidCells(end+1) = numCell;
                end
            else
                finalValidCells(end+1) = numCell;
            end
        end
    end
end

