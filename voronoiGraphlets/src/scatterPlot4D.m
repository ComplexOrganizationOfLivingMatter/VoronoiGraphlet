function [ ] = scatterPlot4D( gddsData, classesWeWantToShow, classesWeWantToShowOnlyMean, CVTn )
%SCATTERPLOT4D Summary of this function goes here
%   Detailed explanation goes here

    gdds = gddsData(:, [2:4 13]);
    gdds.Properties.VariableNames{4} = 'Hexagons';

    imgsName = cellfun(@(x) strsplit(x, {'_', '-', ' ','0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}), gddsData.Imagename, 'UniformOutput', false);

    imgClass = cell(size(imgsName, 1), 1);

    for numImg = 1:size(imgsName, 1)
        actualImg = imgsName{numImg};
        if any(cellfun(@(x) isempty(strfind(x, 'mean')) == 0, actualImg))
            if (any(ismember(actualImg, classesWeWantToShowOnlyMean)) || isempty(classesWeWantToShowOnlyMean))
                if isequal(actualImg{2}, 'disk')
                    
                elseif isequal(actualImg{1}, 'Case')
                    imgClass(numImg) = {[actualImg{1}, '-', actualImg{2}]};
                elseif isequal(actualImg{1}, 'Control')
                    if isempty(actualImg{4}) || isequal(actualImg{4}, 'mean')
                        %imgClass(numImg) = {strjoin(actualImg(1:3), '-')};
                    else
                        imgClass(numImg) = {strjoin(actualImg(1:4), '-')};
                    end
                elseif isempty(actualImg{1}) == 0
                    imgClass(numImg) = actualImg(1);
                    
                else
                    imgClass(numImg) = actualImg(2);
                end
            end
        else
            if (any(ismember(actualImg, classesWeWantToShow)) || isempty(classesWeWantToShow))
                if isequal(actualImg{2}, 'disk')
                    
                elseif isequal(actualImg{1}, 'Case')
                    imgClass(numImg) = {[actualImg{1}, '-', actualImg{2}]};
                elseif isequal(actualImg{1}, 'Control')
                    if isempty(actualImg{4})
                        imgClass(numImg) = {strjoin(actualImg(1:3), '-')};
                    else
                        imgClass(numImg) = {strjoin(actualImg(1:4), '-')};
                    end
                elseif isempty(actualImg{1}) == 0
                    imgClass(numImg) = actualImg(1);
                    
                else
                    imgClass(numImg) = actualImg(2);
                end
                
            end
        end
    end

    noMeanFiles = cellfun(@(x) isempty(x) == 0, imgClass) ;

    dataColours = horzcat(gddsData.R, gddsData.G, gddsData.B)/255;

    dataColours = dataColours(noMeanFiles, :);

    [C, ia, ic] = unique(imgClass(noMeanFiles), 'stable');

    figure;
    [h,ax,bigax] = gplotmatrix(table2array(gdds(noMeanFiles, :)), [], imgClass(noMeanFiles), dataColours(ia, :), [], 20, [], [], gdds.Properties.VariableNames);

    h;

end

