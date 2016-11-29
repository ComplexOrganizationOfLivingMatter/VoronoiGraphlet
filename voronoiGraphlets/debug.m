image = imagen_4_Diagrama_001;
%image = image == 0;
image = im2bw(image(:,:,1), 0.2);
% [zerosXs, zerosYs] = find(image == 0);
% image(min(zerosXs), min(zerosYs):max(zerosYs)) = 0;
% image(min(zerosXs):max(zerosXs), min(zerosYs)) = 0;
% image(max(zerosXs), min(zerosYs):max(zerosYs)) = 0;
% image(min(zerosXs):max(zerosXs), max(zerosYs)) = 0;
matrix = dlmread('E:\Pablo\PhD-miscelanious\voronoiGraphlets\results\graphletResultsFiltered\allOriginal\imagen_4_Diagrama_001.ndump2');

Img_L = watershed(1 - image, 8);
figure;
imshow(double(Img_L) .* ismember(Img_L, celulas_validas(matrix(:, 69) > 0)))
figure;
imshow(double(Img_L) .* ismember(Img_L, celulas_validas(cellfun(@(x) size(x, 1) == 6, vecinos(celulas_validas)))))
figure;
imshow(double(Img_L) .* ismember(Img_L, setxor(weightedCells, neighbours)))
atrophicCells = [114 199 220 247 223 186 145 100 206];
figure;
imshow(double(Img_L) .* ismember(Img_L, atrophicCells))
save('results\validCellsMaxPathLength\SickEpitheliums\maxLength4\maxLength4_Atrophy Sim 20_data_temp.mat', 'celulas_validas', 'atrophicCells', 'vecinos', 'finalValidCells');
clear
close all