
inputDir = 'D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\RobImages\MbsRNAi\FinalSegmentation\*.tif';
imgFiles = dir(inputDir);

for numFile = 1:length(imgFiles)
    img = imread(fullfile(imgFiles(numFile).folder, imgFiles(numFile).name));
    L_img = bwlabel(img == 0, 4);
    imgNeigbhours = calculate_neighbours(L_img);
    imgFiles(numFile).percentageOfFourFoldVertices = getFourFoldVertices(imgNeigbhours,L_img);
end