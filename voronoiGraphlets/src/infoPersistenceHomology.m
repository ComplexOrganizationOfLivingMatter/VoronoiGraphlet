
function infoPersistenceHomology(currentPath)
%Info for Persistence homology
allFiles = getAllFiles(currentPath);
for numFile = 1:size(allFiles, 1)
    fullPathFile = allFiles{numFile};
    fullPathFileSplitted = strsplit(fullPathFile, '\');
    nameFile = fullPathFileSplitted{end};
    correct = 0; %If it is a voronoi diagrama, we select which diagrams we want to do
    
    diagramNameToCompare = strrep(nameFile, 'Voronoi_', 'Diagrama_');
    if isempty(strfind(diagramNameToCompare, 'Diagrama_')) == 0
        for i = 1:9
            if isempty(strfind(diagramNameToCompare, strcat('Diagrama_00', num2str(i)))) == 0
                correct = 1;
                break
            end
        end
        if correct == 0
            for i = 10:19
                if isempty(strfind(diagramNameToCompare, strcat('Diagrama_0', num2str(i)))) == 0
                    correct = 1;
                    break
                end
            end
        end
        if correct == 0
            for i = 20:10:99
                if isempty(strfind(diagramNameToCompare, strcat('Diagrama_0', num2str(i)))) == 0
                    correct = 1;
                    break
                end
            end
        end
        if correct == 0
            for j = 100:100:700
                if isempty(strfind(diagramNameToCompare, strcat('Diagrama_', num2str(j), '_'))) == 0
                    correct = 1;
                    break
                end
            end
        end
    else %Not a voronoi diagram
        correct = 1;
    end
    if correct
        image = imread(fullPathFile);
        image = im2bw(image(:,:,1), 0.2);
        if sum(image(:) == 255) > sum(image(:) == 0) || sum(image(:) == 1) > sum(image(:) == 0)
            l_img = watershed(1 - image, 8);
        else
            image = image == 0;
            l_img = watershed(1 - image, 8);
        end
        
        areas = regionprops(l_img, 'Area');
        areas = [areas.Area];
        areasMean = mean(areas);
        incorrectAreas = areas > areasMean*50;
        if sum(incorrectAreas)> 0
            [zerosXs, zerosYs] = find(image == 0);
            image(min(zerosXs), min(zerosYs):max(zerosYs)) = 0;
            image(min(zerosXs):max(zerosXs), min(zerosYs)) = 0;
            image(max(zerosXs), min(zerosYs):max(zerosYs)) = 0;
            image(min(zerosXs):max(zerosXs), max(zerosYs)) = 0;
            l_img = watershed(1 - image, 8);
            areas = regionprops(l_img, 'Area');
            areas = [areas.Area];
            areasMean = mean(areas);
            incorrectAreas = areas > areasMean*50;
            numIncorrectAreas = find(incorrectAreas);
            if sum(incorrectAreas)> 0
                borderIncorrect = 1;
            end
        end
        cellInfo = regionprops(l_img, 'all');
        fullPathFileSplitted{end - 1} = 'data';
        nameFileSplitted = strsplit(nameFile, '.');
        load(strcat(strjoin(fullPathFileSplitted(1:end-1), '\'), '\' ,nameFileSplitted{1}, '_data.mat'));
        valid_cells = celulas_validas;
        neighs_real = vecinos;
        save(strcat('E:\Pablo\HaveToSend\Ephitelia organization\', nameFileSplitted{1}, '_data.mat'), 'l_img' ,'cellInfo', 'valid_cells', 'neighs_real');
    end
end