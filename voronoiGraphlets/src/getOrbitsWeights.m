function [orbitsWeights, typeOfGDD] = getOrbitsWeights(orbitsInfo)
%GETORBITSWEIGHTS Summary of this function goes here
%   Detailed explanation goes here

    for numRow = 1:size(orbitsInfo, 1)
        typeOfGDD(numRow) = orbitsInfo.TypeOfGDD(numRow);
        orbitsWeightsRaw = cellfun(@str2double, table2cell(orbitsInfo(numRow, 3:end)));
        orbitsWeights(numRow, 1:(length(orbitsWeightsRaw))) = orbitsWeightsRaw/sum(orbitsWeightsRaw);
    end

end

