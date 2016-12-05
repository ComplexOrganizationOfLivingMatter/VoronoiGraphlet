function [ ] = getSpecialIndividualCells( infoPath, outputPath, additionalDataPath, validCellsPath, removingGraphlets)
%GETSPECIALINDIVIDUALCELLS Summary of this function goes here
%   Detailed explanation goes here

    allFilesInfo = getAllFiles(infoPath);
    allFilesData = getAllFiles(additionalDataPath);
    allFilesValidCells = getAllFiles(validCellsPath);
    pathSplitted = strsplit(additionalDataPath, '\');
    typeOfData = pathSplitted{end-1};
    for numFile = 1:size(allFilesData,1)
        fullPathFile = allFilesData{numFile};
        fullPathFileSplitted = strsplit(fullPathFile, '\');
        fileName = fullPathFileSplitted{end};
        
        if isempty(strfind(fileName, '_data.mat')) && isempty(strfind(fileName, '.mat')) == 0 %Only analyze additional information
            fileNameSplitted = strsplit(fileName, '_');
            
            cellValidsFile = cellfun(@(x) isempty(strfind(x, strcat(strjoin(fileNameSplitted(1:2), '_'), '_data.mat'))) == 0, allFilesValidCells);
            cellValidsFileName = allFilesValidCells{cellValidsFile};
            load(cellValidsFileName);
            
            cells = load(fullPathFile);
            nameVars = fieldnames(cells);
            cells = struct2cell(cells);
            fileNameSplitted = strsplit(fileName, '_');
            graphletFile = cellfun(@(x) isempty(strfind(x, strjoin(fileNameSplitted(1:2), '_'))) == 0, allFilesInfo);
            
            matrixGraphlets = dlmread(allFilesInfo{graphletFile});
            matrixGraphlets(:, removingGraphlets) = 0;
            for i = 1:length(nameVars)
                especialCells = intersect(cells{i}, finalValidCells);
                for numCell = 1:size(especialCells)
                    
                    finalOutputFile = strcat(outputPath, strjoin(fileNameSplitted(1:2), '_'), '_', nameVars{i}, '_' ,num2str(especialCells(numCell)), '_numNeighbours_', num2str(matrixGraphlets(especialCells(numCell), 1)),'.ndump2');
                    if exist(finalOutputFile, 'file') ~= 2
                        dlmwrite(finalOutputFile, matrixGraphlets(especialCells(numCell), :), ' ');
                    end
                end
            end
        end
    end
end

