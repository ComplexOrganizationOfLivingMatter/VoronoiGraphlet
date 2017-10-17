function [ gradientVector ] = createGradient(startingColour, finalColour, numberOfSteps)
%CREATEGRADIENT Summary of this function goes here
%   Detailed explanation goes here
    stepsCVTw2 = (finalColour - startingColour) / (numberOfSteps-1);
    
    for numChannel = 1:3
        if finalColour(numChannel) == startingColour(numChannel)
            gradientVector(:, numChannel) = zeros(1, numberOfSteps);
        else
            gradientVector(:, numChannel) = startingColour(numChannel):stepsCVTw2(numChannel):finalColour(numChannel);
        end
    end

end

