function [ finalValidCells ] = getValidCellsFromROI(currentPath, maxPathLength, outputPath)
%GETVALIDCELLSFROMROI Get valid cells' in a given range (4 or 5)
%   We get the valid cells with no valid cells in all the paths 
%   of a max length (maxPathLength)
%
%   currentPath: actual path
%   maxPathLenth: the max length of the path where you won't find
%   no valid cells.
%   outputPath: path of the output
%
%   Developed by Pablo Vicente-Munuera

    dataFiles = getAllFiles(currentPath);
    for numFile = 1:size(dataFiles,1)
        fullPathFile = dataFiles(numFile);
        fullPathFile = fullPathFile{:};
        diagramNameSplitted = strsplit(fullPathFile, '\');
        diagramName = diagramNameSplitted(end);
        diagramName = diagramName{1};

        typeName = diagramNameSplitted(end - 2);
        typeName = typeName{1};
        if isempty(strfind(diagramName, typeName)) && isempty(strfind(currentPath, 'biological'))
            outputFile = strcat(outputPath, 'maxLength', num2str(maxPathLength), '\', 'maxLength', num2str(maxPathLength), '_', typeName ,'_', diagramName);
        else
            outputFile = strcat(outputPath, 'maxLength', num2str(maxPathLength), '\', 'maxLength', num2str(maxPathLength) ,'_', diagramName);
        end
        %Check which files we want.
        if isempty(strfind(lower(diagramName), '_data.mat')) == 0 && exist(outputFile, 'file') ~= 2
            clear vecinos Vecinos celulas_validas
            if isempty(strfind(outputFile, 'neo')) == 0 %NEO files
                load(fullPathFile);
                if maxPathLength == 4
                    finalValidCells = valid_cells_4;
                elseif maxPathLength == 5
                    finalValidCells = valid_cells_5;
                end
                celulas_validas = valid_cells;
                vecinos = neighs_real;
                save(outputFile, 'finalValidCells', 'celulas_validas', 'vecinos');
            elseif isempty(strfind(outputFile, 'rosetta')) == 0 %rosetta
                load(fullPathFile);
                if maxPathLength == 4
                    finalTargetCells = valid_neighbors_ring_4;
                    finalValidCells_temp = valid_cells_4;
                elseif maxPathLength == 5
                    finalTargetCells = valid_neighbors_ring_5;
                    finalValidCells_temp = valid_cells_5;
                end
                
                %finalValidCells = filteredFinalValidCells(finalValidCells_temp, neighs_real, maxPathLength, fullPathFile, finalTargetCells, 'rosetta' );
                adj_matrix=zeros(size(neighs_real,2));

                for i=1:size(neighs_real,2) 
                    neighs=neighs_real{1,i}; 
                    adj_matrix(i,neighs)=1;
                end

                %Distance matrix since adjacency matrix
                [dist_matrix] = graphallshortestpaths(sparse(adj_matrix));

                dist_valid_to_no_valid=dist_matrix(valid_cells, finalTargetCells);

                closest_no_valid_cell=min(dist_valid_to_no_valid');
                
                finalValidCells=valid_cells(closest_no_valid_cell<=maxPathLength);

                celulas_validas = valid_cells;
                vecinos = neighs_real;
                
                %final valid cells
                numNeighbours = cellfun(@(x) length(x), neighs_real(finalValidCells));
                polygonDistributionFinalValidCells = [sum(numNeighbours == 3), sum(numNeighbours == 4), sum(numNeighbours == 5), sum(numNeighbours == 6), sum(numNeighbours == 7), sum(numNeighbours == 8), sum(numNeighbours == 9), sum(numNeighbours == 10)] / length(numNeighbours); 
                %All valid cells
                numNeighbours = cellfun(@(x) length(x), neighs_real(valid_cells));
                polygonDistributionValidCells = [sum(numNeighbours == 3), sum(numNeighbours == 4), sum(numNeighbours == 5), sum(numNeighbours == 6), sum(numNeighbours == 7), sum(numNeighbours == 8), sum(numNeighbours == 9), sum(numNeighbours == 10)] / length(numNeighbours);
                save(outputFile, 'finalValidCells', 'celulas_validas', 'vecinos', 'finalTargetCells', 'polygonDistributionFinalValidCells', 'polygonDistributionValidCells');
            else
                fullPathFile
                load(fullPathFile);%load valid cells and neighbours
    
                if exist('neighs_real', 'var') == 1
                    neighbours = neighs_real;
                    validCells = valid_cells;
                else
                    if exist('vecinos', 'var') == 1
                        neighbours = vecinos;
                        clear vecinos
                    elseif exist('Vecinos', 'var') == 1
                        neighbours = Vecinos;
                        clear Vecinos
                    else
                        error('No neighbours variable');
                    end
                    validCells = celulas_validas;
                    clear celulas_validas
                end
                neighboursEmpty = cellfun(@(x) isempty(x), neighbours);
                maxCellLabel = max(cellfun(@(x) max(x), neighbours(neighboursEmpty == 0)));
                noValidCells = setxor(1:maxCellLabel, validCells);

                if size(neighbours, 2) ~= (size(noValidCells, 2) + size(validCells, 2))
                    error('Incorrect number of no valid cells'); 
                end

                finalValidCells = [];
                if isempty(strfind(fullPathFile, 'Weighted')) == 0 
                    weightedCellsAndNeigbhours = union(vertcat(neighbours{wts > 0}), find(wts > 0));
                end
                
                for numCell = 1:size(neighbours, 2)
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
                        if isempty(strfind(fullPathFile, 'Weighted')) == 0 
                            if sum(ismember(neighboursInMaxPathLength, weightedCellsAndNeigbhours)) > 0
                                finalValidCells(end+1) = numCell;
                            end
                        else
                            finalValidCells(end+1) = numCell;
                        end
                    end
                end

                vecinos = neighbours;
                celulas_validas = validCells;
                save(outputFile, 'finalValidCells', 'celulas_validas', 'vecinos');
                clear vecinos celulas_validas
                
                %finalValidCells = filteredFinalValidCells(validCells, neighbours, maxPathLength, fullPathFile, weightedCellsAndNeigbhours, 'weighted' );
            end
        end
    end
end

