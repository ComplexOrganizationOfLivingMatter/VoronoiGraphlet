function [ ] = filterByNonValidCells( currentPath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    allFilesImages = getAllFiles(currentPath);
    allFilesData = getAllFiles('E:\Pablo\PhD-miscelanious\voronoiNetworks\data\');
    for numFile = 1:size(allFilesImages,1)
        fullPathImage = allFilesImages(numFile);
        fullPathImage = fullPathImage{:};
        fullPathImageSplitted = strsplit(fullPathImage, '\');
        imageName = fullPathImageSplitted{end};
        imageNameReal = imageName(16:end-7);
        
        
        dataFile = cellfun(@(x) size(strfind(x, imageNameReal), 1) > 0, allFilesData);
        matrixToFilter = csvread(fullPathImage);
        dataFileName = allFilesData(dataFile);
        load(dataFileName{1});
        finalMatrixFiltered = matrixToFilter(celulas_validas, :);
        outputFile = strcat(strjoin(fullPathImageSplitted(1:end-2), '\'), '\graphletResultsFiltered\', imageName);
        dlmwrite(outputFile, finalMatrixFiltered, ' ');
    end

end

