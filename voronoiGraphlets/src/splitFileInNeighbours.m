function [ ] = splitFileInNeighbours( fileName )
%SPLITFILEINNEIGHBOURS Summary of this function goes here
%   Detailed explanation goes here
    graphletsByNodes = dlmread(fileName);
    fileNameSplitted = strsplit(fileName, '\');
    for i = 1:size(graphletsByNodes, 1)
        onlyFileName = fileNameSplitted{end};
        onlyFileNameSplitted = strsplit(onlyFileName, '.');
        outputFile = strcat(strjoin(fileNameSplitted(1:end-1), '\'), '\' ,onlyFileNameSplitted{1}, '_row_', num2str(i) ,'_numNeighbours_', num2str(graphletsByNodes(i, 1)),'.ndump2');
        dlmwrite(outputFile, graphletsByNodes(i, :), ' ');
    end
end

