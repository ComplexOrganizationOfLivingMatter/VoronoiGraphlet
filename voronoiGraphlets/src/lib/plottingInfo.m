function [ figureValues ] = plottingInfo(currentPath, hFigure, xValues, yValues, zValues, nameFiles, classes, onlyMeans )
%PLOTTINGINFO Summary of this function goes here
%   Detailed explanation goes here
%% Colours of each point
    figureValues = zeros(size(classes, 1));
    indices = [1:20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500, 600, 700];
    offSetGraysFont = 10;
    graysFont = gray(length(indices) + offSetGraysFont);
    
    if onlyMeans
        voronoiNoiseDiagramPosition = 2;
    else
        voronoiNoiseDiagramPosition = 5;
    end

    for numFile = 1:size(nameFiles, 2)
        for numClass = 1:size(classes, 1)
            if isempty(strfind(nameFiles{numFile}, classes{numClass, 1})) == 0
                if isequal(classes{numClass, 1}, 'voronoiNoise')
                    nameDiagram = strsplit(nameFiles{numFile}, '-');
                    colours = graysFont (indices == str2num(nameDiagram{voronoiNoiseDiagramPosition}), :);
                else
                    if isempty(strfind(classes{numClass, 2}, 'CVTw')) == 0
                        if isempty(strfind(nameFiles{numFile}, 'Neighbours'))
                            [numClass, ~] = find(cellfun(@(x) isequal(x, 'CVTw1'), classes));
                        else
                            [numClass, ~] = find(cellfun(@(x) isequal(x, 'CVTw2'), classes));
                        end
                    end
                    colours = classes{numClass, 3};
                end
                if isempty(zValues)
                    if onlyMeans
                        figureValues(numClass, :) = plot(xValues(numFile), yValues(numFile), 'o', 'color', colours, 'MarkerFaceColor', colours);
                    else
                        figureValues(numClass, :) = plot(xValues(numFile), yValues(numFile), 'o', 'color', colours);
                    end
                else
                    if onlyMeans
                        figureValues(numClass, :) = scatter3(xValues(numFile), yValues(numFile) ,zValues(numFile), 'markerEdgeColor', colours, 'MarkerFaceColor', colours);
                    else
                        figureValues(numClass, :) = scatter3(xValues(numFile), yValues(numFile) ,zValues(numFile), 'markerEdgeColor', colours);
                    end
                end
                hold on;
                
                if isempty(strfind(classes{numClass, 2}, 'CVTw')) == 0 && onlyMeans
                    nameDiagram = strsplit(nameFiles{numFile}, '-');
                    if isempty(zValues)
                        t1 = text(xValues(numFile), yValues(numFile), nameDiagram{3});
                    else
                        t1 = text(xValues(numFile), yValues(numFile), zValues(numFile), nameDiagram{3});
                    end
                    t1.FontSize = 5;
                    t1.HorizontalAlignment = 'center';
                    t1.VerticalAlignment = 'middle';
                    t1.Color = 'red';
                end
                break
            end
        end
    end

    %% Figure properties
    newNames = classes(:, 2);
    currentPathSplitted = strsplit(currentPath, '\');
    legend(figureValues(figureValues(:, 1) > 0, 1), newNames(figureValues(:, 1) > 0)', 'Location', 'best', 'EdgeColor', [1 1 1]);

    xlabel('GDDRV', 'FontWeight', 'bold');
    ylabel('GDDH', 'FontWeight', 'bold');
    if isempty(zValues) == 0
        zlabel('Percentage of hexagons', 'FontWeight', 'bold');
    end
    auxLim = xlim;
    xlim([0 auxLim(2)])
    auxLim = ylim;
    ylim([0 auxLim(2)])
    zlim([0 100]);

    saveas(hFigure, strcat(currentPathSplitted{4}, '_PercentageOfHexagons_GDDRV_GDDH', '-', strjoin(newNames(figureValues(:, 1) > 0), '_'), '_', date), 'fig');
end

