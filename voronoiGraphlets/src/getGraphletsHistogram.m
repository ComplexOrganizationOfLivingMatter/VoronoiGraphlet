function [graphletsOrbitsRelation] = getGraphletsHistogram(excelFile)
%GETGRAPHLETSHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
    graphletsOrbitsRelation = {0, 0;
     1, [1, 2];
     2, [3];
     3, [4, 5];
     4, [6, 7];
     5, 8;
     6, [9, 10, 11];
     7, [12, 13];
     8, [14];
     9, [15,16,17];
     10, [18, 19, 20, 21];
     11, 22:23;
     12, [24, 25, 26];
     13, 27:30;
     14, 31:33;
     15, 34;
     16, 35:38;
     17, 39:42;
     18, 43:44;
     19, 45:48;
     20, 49:50;
     21, 51:53;
     22, 54:55;
     23, 56:58;
     24, 59:61;
     25, 62:64;
     26, 65:67;
     27, 68:69;
     28, 70:71;
     29, 72};


    %Mean orbits count per graphlet
    for numGraphlet = 1:size(graphletsOrbitsRelation, 1)
        actualGraphletInfo = excelFile(:, graphletsOrbitsRelation{numGraphlet, 2}+1);
        %orbitsInfo = cellfun(@str2double, actualGraphletInfo);
        graphletsOrbitsRelation(numGraphlet, 3) = {sum(actualGraphletInfo)};
    end
end

