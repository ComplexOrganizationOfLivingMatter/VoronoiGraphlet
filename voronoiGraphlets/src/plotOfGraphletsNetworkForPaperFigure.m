%paths to load
voronoiPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\voronoiNoise\';
hexagonsPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\RegularHexagons\';
networkPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\results\networks\';
validCellsPath='D:\Pablo\VoronoiGraphlet\voronoiGraphlets\results\validCellsMaxPathLength\';

%% Voronoi 1
%loading images to plot
voronoi1Image=imread([voronoiPath 'images\Image_1_Voronoi_001_par_radio_noise_5_r1.png']);
%loading adjacency matrix
load([networkPath 'voronoiNoise\adjacencyMatrixvoronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'adjacencyMatrix')
adjMatrixV1=adjacencyMatrix;

%loading valid cells
load([validCellsPath, 'voronoiNoise\maxLength4\maxLength4_voronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'celulas_validas','finalValidCells')
validTotalCellsV1=celulas_validas;
validCells4V1=finalValidCells;
load([validCellsPath, 'voronoiNoise\maxLength5\maxLength5_voronoiNoise_Image_1_Voronoi_001_par_radio_noise_5_r1_data.mat'],'finalValidCells')
validCells5V1=finalValidCells;

plotGraphletsNetworkForPaper( image, validTotalCells, adjMatrix, validCells4, validCells5 )

%% Voronoi 5
%loading images to plot
voronoiNoise5Image=imread([voronoiPath 'images\Image_1_Voronoi_005_par_radio_noise_5_r1.png']);
%loading adjacency matrix
load([networkPath 'voronoiNoise\adjacencyMatrixvoronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'adjacencyMatrix')
adjMatrixV5=adjacencyMatrix;

load([validCellsPath, 'voronoiNoise\maxLength4\maxLength4_voronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'celulas_validas','finalValidCells')
validTotalCellsV5=celulas_validas;
validCells4V5=finalValidCells;
load([validCellsPath, 'voronoiNoise\maxLength5\maxLength5_voronoiNoise_Image_1_Voronoi_005_par_radio_noise_5_r1_data.mat'],'finalValidCells')
validCells5V5=finalValidCells;

plotGraphletsNetworkForPaper( image, validTotalCells, adjMatrix, validCells4, validCells5 )
%% Hexagon
%loading images to plot
hexagonsImage=imread([hexagonsPath 'image\Hexagons1Pixel.png']);
hexagonsImage=logical(hexagonsImage);
%loading adjacency matrix
load([networkPath 'regularHexagons\adjacencyMatrix_RegularHexagons_Hexagons1Pixel_data.mat'],'adjacencyMatrix')
adjMatrixHex=adjacencyMatrix;

load([validCellsPath, 'regularHexagons\maxLength4\maxLength4_RegularHexagons_Hexagons1Pixel_data.mat'],'celulas_validas','finalValidCells')
validTotalCellsHex=celulas_validas;
validCells4Hex=finalValidCells;
load([validCellsPath, 'regularHexagons\maxLength5\maxLength5_RegularHexagons_Hexagons1Pixel_data.mat'],'finalValidCells')
validCells5Hex=finalValidCells;

plotGraphletsNetworkForPaper( image, validTotalCells, adjMatrix, validCells4, validCells5 )

