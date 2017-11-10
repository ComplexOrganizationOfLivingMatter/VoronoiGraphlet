%paths to load
voronoiPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\voronoiNoise\';
hexagonsPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\RegularHexagons\';
networkPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\results\networks\';
validCellsPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\results\validCellsMaxPathLength\';

% %% Voronoi 1
% %loading images to plot
% voronoi1Image=imread([voronoiPath 'images\Image_1_Voronoi_001_par_radio_noise_5_r1.png']);
% %loading adjacency matrix
% load([networkPath 'voronoiNoise\adjacencyMatrixvoronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'adjacencyMatrix')
% adjMatrixV1=adjacencyMatrix;
%
% %loading valid cells
% load([validCellsPath, 'voronoiNoise\maxLength4\maxLength4_voronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'celulas_validas','finalValidCells')
% validTotalCellsV1=celulas_validas;
% validCells4V1=finalValidCells;
% load([validCellsPath, 'voronoiNoise\maxLength5\maxLength5_voronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'finalValidCells')
% validCells5V1=finalValidCells;
%
% plotGraphletsNetworkForPaper( image, validTotalCells, adjMatrix, validCells4, validCells5 )
%
% %% Voronoi 5
% %loading images to plot
% voronoiNoise5Image=imread([voronoiPath 'images\Image_1_Voronoi_005_par_radio_noise_5_r1.png']);
% %loading adjacency matrix
% load([networkPath 'voronoiNoise\adjacencyMatrixvoronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'adjacencyMatrix')
% adjMatrixV5=adjacencyMatrix;
%
% load([validCellsPath, 'voronoiNoise\maxLength4\maxLength4_voronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'celulas_validas','finalValidCells')
% validTotalCellsV5=celulas_validas;
% validCells4V5=finalValidCells;
% load([validCellsPath, 'voronoiNoise\maxLength5\maxLength5_voronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'finalValidCells')
% validCells5V5=finalValidCells;
%
% plotGraphletsNetworkForPaper( image, validTotalCells, adjMatrix, validCells4, validCells5 )
% %% Hexagon
% %loading images to plot
% hexagonsImage=imread([hexagonsPath 'image\Hexagons1Pixel.png']);
% hexagonsImage=logical(hexagonsImage);
% %loading adjacency matrix
% load([networkPath 'regularHexagons\adjacencyMatrix_RegularHexagons_Hexagons1Pixel_data.mat'],'adjacencyMatrix')
% adjMatrixHex=adjacencyMatrix;
%
% load([validCellsPath, 'regularHexagons\maxLength4\maxLength4_RegularHexagons_Hexagons1Pixel_data.mat'],'celulas_validas','finalValidCells')
% validTotalCellsHex=celulas_validas;
% validCells4Hex=finalValidCells;
% load([validCellsPath, 'regularHexagons\maxLength5\maxLength5_RegularHexagons_Hexagons1Pixel_data.mat'],'finalValidCells')
% validCells5Hex=finalValidCells;
%
% plotGraphletsNetworkForPaper( image, validTotalCells, adjMatrix, validCells4, validCells5 )

%% dirs

imgFiles = {'temp/eye_cropped.png', 'temp/voronoi1_cropped.png'};
for numImage = 1:size(imgFiles, 2)
    %loading images to plot
    image=imread(imgFiles{numImage});
    borderIncorrect = 0;
    image = im2bw(image(:,:,1), 0.2);
    if sum(image(:) == 255) > sum(image(:) == 0) || sum(image(:) == 1) > sum(image(:) == 0)
        L_img = watershed(1 - image, 8);
    else
        image = image == 0;
        L_img = watershed(1 - image, 8);
    end
    
    areas = regionprops(L_img, 'Area');
    areas = [areas.Area];
    areasMean = mean(areas);
    incorrectAreas = areas > areasMean*50;
    if sum(incorrectAreas)> 0
        disp('There are some incorrect cell areas. Trying to autofix it...')
        [zerosXs, zerosYs] = find(image == 0);
        image(min(zerosXs), min(zerosYs):max(zerosYs)) = 0;
        image(min(zerosXs):max(zerosXs), min(zerosYs)) = 0;
        image(max(zerosXs), min(zerosYs):max(zerosYs)) = 0;
        image(min(zerosXs):max(zerosXs), max(zerosYs)) = 0;
        L_img = watershed(1 - image, 8);
        areas = regionprops(L_img, 'Area');
        areas = [areas.Area];
        areasMean = mean(areas);
        incorrectAreas = areas > areasMean*50;
        numIncorrectAreas = find(incorrectAreas);
        if sum(incorrectAreas)> 0
            borderIncorrect = 1;
        end
    end
    
    ratio=4;
    se = strel('disk',ratio);
    cells=sort(unique(L_img));
    cells=cells(2:end);                  %% Deleting cell 0 from range
    neighbours = {};
    for cel = 1:max(L_img(:))
        BW = bwperim(L_img==cel);
        [pi,pj]=find(BW==1);
        
        BW_dilate = imdilate(BW,se);
        pixels_neighs = BW_dilate==1;
        neighs = unique(L_img(pixels_neighs));
        neighbours{cel} = neighs(neighs ~= 0 & neighs ~= cel);
    end
    
    %Removing borderCells
    Img_det_bord=watershed(1 - image,8);
    [zerosXs, zerosYs] = find(Img_det_bord == 0);
    Img_det_bord(min(zerosXs), min(zerosYs):max(zerosYs))=1;
    Img_det_bord(max(zerosXs), min(zerosYs):max(zerosYs))=1;
    Img_det_bord(min(zerosXs):max(zerosXs), min(zerosYs))=1;
    Img_det_bord(min(zerosXs):max(zerosXs), max(zerosYs))=1;
    Img_det_bord = watershed(1-Img_det_bord,8);
    borderCells=[];
    noBorderCells=[];
    
    %-- files with a white frame (not cells at that frame) --%
    if borderIncorrect
        borderCells = [numIncorrectAreas, cat(1, neighbours{numIncorrectAreas})'];
        allCells = 1:max(L_img(:));
        noBorderCells = ismember(allCells, borderCells);
        noBorderCells = allCells(noBorderCells == 0);
    else
        %-- files with cells partial images at boundaries --%
        for cell=2:max(L_img(:))
            if unique(Img_det_bord(L_img == cell))~=1
                noBorderCells = [noBorderCells, cell];
            else
                borderCells = [borderCells, cell];
            end
        end
    end
    
    % Removing cells isolated from the valid cells
    noValidCells = unique(borderCells);
    validCells = unique(noBorderCells);
    vecinos_real = neighbours;
    
    celulas_validas_previa = validCells;
    celulas_no_validas_previa = noValidCells;
    flag = 0;
    for j=1:length(celulas_validas_previa) % Bucle que recorre todas celulas validas para comprobar
        j;
        vec_cel_ind_j=vecinos_real{celulas_validas_previa(j)};
        no_coincidencia=[];
        for x=1:length(vec_cel_ind_j)% Bucle que recorre todos los vecinos de la celula bajo estudio
            no_coincidencia(x)=isempty(find(vec_cel_ind_j(x)==celulas_no_validas_previa)); %Variable que vale 1 si no existe coincidencia de la celula j con alguna de las celulas no validas
        end
        if sum(no_coincidencia)==0
            validCells=validCells(validCells~=celulas_validas_previa(j));
            noValidCells=sort([celulas_validas_previa(j),celulas_no_validas_previa]);
            flag=1;
        end
    end
    if (flag==0)
        validCells=celulas_validas_previa;                                        %%VARIABLE A GUARDAR
        noValidCells=celulas_no_validas_previa;
    end
    validTotalCells = validCells;
    
    maxPathLength = 4;
    neighboursEmpty = cellfun(@(x) isempty(x), neighbours);
    maxCellLabel = max(cellfun(@(x) max(x), neighbours(neighboursEmpty == 0)));
    noValidCells = setxor(1:maxCellLabel, validCells);
    
    if size(neighbours, 2) ~= (size(noValidCells, 2) + size(validCells, 2))
        error('Incorrect number of no valid cells');
    end
    
    finalValidCells = [];
    
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
            finalValidCells(end+1) = numCell;
        end
    end
    
    validCells4 = finalValidCells;
    
    maxPathLength = 5;
    neighboursEmpty = cellfun(@(x) isempty(x), neighbours);
    maxCellLabel = max(cellfun(@(x) max(x), neighbours(neighboursEmpty == 0)));
    noValidCells = setxor(1:maxCellLabel, validCells);
    
    if size(neighbours, 2) ~= (size(noValidCells, 2) + size(validCells, 2))
        error('Incorrect number of no valid cells');
    end
    
    finalValidCells = [];
    
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
            finalValidCells(end+1) = numCell;
        end
    end
    
    validCells5 = finalValidCells;
    
    plotGraphletsNetworkForPaper( image, validTotalCells, neighbours, validCells4, validCells5 )
    
end


