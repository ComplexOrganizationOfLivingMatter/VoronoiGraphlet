function [percQuartets] = getFourFoldVertices(imgNeighbours, L_img)
%GETFOURFOLDVERTICES Summary of this function goes here
%   Detailed explanation goes here
    

totalCells=unique(L_img);
totalCells=totalCells(totalCells~=0);
invalidCells=unique([L_img(1,1),L_img(1,end),L_img(end,1),L_img(end,end)]);
noValidCells=vertcat(imgNeighbours{invalidCells});
validCells=setdiff(totalCells,unique([invalidCells';noValidCells]));
imgNeighbours(unique([invalidCells';noValidCells]))={[]};

try 
quartets=buildQuartetsOfNeighs2D(imgNeighbours);
% figure; imshow(ismember(L_img,quartets(:)))

catch
    quartets=[];
end
percQuartets=size(quartets,1)/length(validCells);


end

