%paths to load
voronoiPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\voronoiNoise\';
hexagonsPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\RegularHexagons\';
networkPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\results\networks\';
validCellsPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\results\validCellsMaxPathLength\';

%loading images to plot
voronoi1Image=imread([voronoiPath 'images\Image_1_Voronoi_001_par_radio_noise_5_r1.png']);
voronoiNoise5Image=imread([voronoiPath 'images\Image_1_Voronoi_005_par_radio_noise_5_r1.png']);
hexagonsImage=imread([hexagonsPath 'image\Hexagons1Pixel.png']);
hexagonsImage=logical(hexagonsImage);
%loading adjacency matrix
load([networkPath 'voronoiNoise\adjacencyMatrixvoronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'adjacencyMatrix')
adjMatrixV1=adjacencyMatrix;
load([networkPath 'voronoiNoise\adjacencyMatrixvoronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'adjacencyMatrix')
adjMatrixV5=adjacencyMatrix;
load([networkPath 'regularHexagons\adjacencyMatrix_RegularHexagons_Hexagons1Pixel_data.mat'],'adjacencyMatrix')
adjMatrixHex=adjacencyMatrix;

%loading valid cells
load([validCellsPath, 'voronoiNoise\maxLength4\maxLength4_voronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'celulas_validas','finalValidCells')
validTotalCellsV1=celulas_validas;
validCells4V1=finalValidCells;
load([validCellsPath, 'voronoiNoise\maxLength5\maxLength5_voronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'finalValidCells')
validCells5V1=finalValidCells;

load([validCellsPath, 'voronoiNoise\maxLength4\maxLength4_voronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'celulas_validas','finalValidCells')
validTotalCellsV5=celulas_validas;
validCells4V5=finalValidCells;
load([validCellsPath, 'voronoiNoise\maxLength5\maxLength5_voronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'finalValidCells')
validCells5V5=finalValidCells;

load([validCellsPath, 'regularHexagons\maxLength4\maxLength4_RegularHexagons_Hexagons1Pixel_data.mat'],'celulas_validas','finalValidCells')
validTotalCellsHex=celulas_validas;
validCells4Hex=finalValidCells;
load([validCellsPath, 'regularHexagons\maxLength5\maxLength5_RegularHexagons_Hexagons1Pixel_data.mat'],'finalValidCells')
validCells5Hex=finalValidCells;


%calculate centroids location
centroidsV1=regionprops(voronoi1Image,'Centroid');
centroidsV1=cat(1,centroidsV1.Centroid);
centroidsV5=regionprops(voronoiNoise5Image,'Centroid');
centroidsV5=cat(1,centroidsV5.Centroid);
centroidsHex=regionprops(hexagonsImage,'Centroid');
centroidsHex=cat(1,centroidsHex.Centroid);


%% Plot of network, plot centroids and plot of image

%VORONOI 1
imshow(ones(size(voronoi1Image)))
hold on
for i=1:length(validTotalCellsV1)
    labelNeighs=find(adjMatrixV1(:,validTotalCellsV1(i))==1);
    for j=1:sum(adjMatrixV1(:,validTotalCellsV1(i))==1)
        plot([round(centroidsV1(validTotalCellsV1(i),1));round(centroidsV1(labelNeighs(j),1))]...
            ,[round(centroidsV1(validTotalCellsV1(i),2));round(centroidsV1(labelNeighs(j),2))],'Color','black');
    end
end
close

imshow(ones(size(voronoi1Image)))
hold on
for i=1:length(validTotalCellsV1)
        plot(round(centroidsV1(validTotalCellsV1(i),1))...
            ,round(centroidsV1(validTotalCellsV1(i),2)),'.r','MarkerSize',15);
end
for i=1:length(validCells4V1)
        plot(round(centroidsV1(validCells4V1(i),1))...
            ,round(centroidsV1(validCells4V1(i),2)),'.b','MarkerSize',15);
end
for i=1:length(validCells5V1)
        plot(round(centroidsV1(validCells5V1(i),1))...
            ,round(centroidsV1(validCells5V1(i),2)),'.g','MarkerSize',15);
end
close 

imshow(voronoi1Image)
close

%VORONOI NOISE 5

imshow(ones(size(voronoiNoise5Image)))
hold on
for i=1:length(validTotalCellsV5)
    labelNeighs=find(adjMatrixV5(:,validTotalCellsV5(i))==1);
    for j=1:sum(adjMatrixV5(:,validTotalCellsV5(i))==1)
        plot([round(centroidsV5(validTotalCellsV5(i),1));round(centroidsV5(labelNeighs(j),1))]...
            ,[round(centroidsV5(validTotalCellsV5(i),2));round(centroidsV5(labelNeighs(j),2))],'Color','black');
    end
end
close

imshow(ones(size(voronoiNoise5Image)))
hold on
for i=1:length(validTotalCellsV5)
        plot(round(centroidsV5(validTotalCellsV5(i),1))...
            ,round(centroidsV5(validTotalCellsV5(i),2)),'.r','MarkerSize',15);
end
for i=1:length(validCells4V5)
        plot(round(centroidsV5(validCells4V5(i),1))...
            ,round(centroidsV5(validCells4V5(i),2)),'.b','MarkerSize',15);
end
for i=1:length(validCells5V5)
        plot(round(centroidsV5(validCells5V5(i),1))...
            ,round(centroidsV5(validCells5V5(i),2)),'.g','MarkerSize',15);
end
close 

imshow(voronoiNoise5Image)
close


%HEXAGONS

imshow(ones(size(hexagonsImage)))
hold on
for i=1:length(validTotalCellsHex)
    labelNeighs=find(adjMatrixHex(:,validTotalCellsHex(i))==1);
    for j=1:sum(adjMatrixHex(:,validTotalCellsHex(i))==1)
        plot([round(centroidsHex(validTotalCellsHex(i),1));round(centroidsHex(labelNeighs(j),1))]...
            ,[round(centroidsHex(validTotalCellsHex(i),2));round(centroidsHex(labelNeighs(j),2))],'Color','black');
    end
end
close

imshow(ones(size(hexagonsImage)))
hold on
for i=1:length(validTotalCellsHex)
        plot(round(centroidsHex(validTotalCellsHex(i),1))...
            ,round(centroidsHex(validTotalCellsHex(i),2)),'.r','MarkerSize',15);
end
for i=1:length(validCells4Hex)
        plot(round(centroidsHex(validCells4Hex(i),1))...
            ,round(centroidsHex(validCells4Hex(i),2)),'.b','MarkerSize',15);
end
for i=1:length(validCells5Hex)
        plot(round(centroidsHex(validCells5Hex(i),1))...
            ,round(centroidsHex(validCells5Hex(i),2)),'.g','MarkerSize',15);
end
close 

imshow(hexagonsImage)
close