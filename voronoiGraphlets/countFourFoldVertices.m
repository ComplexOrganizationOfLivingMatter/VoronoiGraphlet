
inputDir = 'D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\RobImages\MbsRNAi\FinalSegmentation\*.tif';
imgFilesInit = dir(inputDir);
inputDir = 'D:\Pablo\VoronoiGraphlet\voronoiGraphlets\data\Neo\FinalUsed\*.tif';
imgFiles2 = dir(inputDir);

imgFiles = [imgFilesInit; imgFiles2];

for numFile = 1:length(imgFiles)
    img = imread(fullfile(imgFiles(numFile).folder, imgFiles(numFile).name));
    if size(imgFilesInit, 1) >= numFile
        L_img = bwlabel(img == 0, 4);
    else
        L_img = bwlabel(img == 255);
    end
    imgNeigbhours = calculate_neighbours(L_img);
    imgFiles(numFile).percentageOfFourFoldVertices = getFourFoldVertices(imgNeigbhours,L_img);
end