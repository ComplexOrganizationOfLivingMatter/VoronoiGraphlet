function [ ] = plottingInfo3D(currentPath, differenceWithRegularHexagon, differenceRV, percentageOfHexagons, nameFiles )
%PLOTTINGINFO3D Summary of this function goes here
%   Detailed explanation goes here
       %% Colours of each point
    numberOfTypes = 19;
    colors = hsv(numberOfTypes);
    colors(1, :) = [0.0 0.2 0.0]; %BCA
    colors(2, :) = [1.0 0.4 0.0]; %Eye
    colors(3, :) = [0.2 0.8 1.0]; %cNT
    colors(4, :) = [0.0 0.6 0.0]; %dWL
    colors(5, :) = [1.0 0.0 0.0]; %dWP
    colors(6, :) = [0.8 0.8 0.8]; %voronoi
    colors(7, :) = [0.2 0.6 0.6]; %voronoiWeighted Cancer
    colors(8, :) = [0.0 0.0 0.6]; %voronoiWeighted Neighbours
    %colors(8, :) = [1.0 1.0 0.0]; %voronoiNoise
    colors(9, :) = [1.0 0.8 1.0]; %Case II
    colors(10, :) = [1.0 0.2 1.0]; %Case III
    colors(11, :) = [0.8 0.0 0.6]; %Case IV
    colors(12, :) = [0.6 0.0 1.0]; %dMWP
    colors(13, :) = [0.2 0.8 1.0]; %Atrophy Sim
    colors(15, :) = [0.0 0.0 0.0]; %Control Sim No Prol
    colors(14, :) = [1.0 1.0 0.0]; %Control Sim Prol
    colors(16, :) = [0.2 0.4 0.6]; %BNA
    colors(17, :) = [0.2 0.4 0.6]; %Neo or dWLm
    colors(18, :) = [0.4 0.0 0.0]; %rosetta
    h1 = figure('units','normalized','outerposition',[0 0 1 1], 'Color', [1 1 1]);
    h = zeros(numberOfTypes);
    indices = [1:20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500, 600, 700];
    offSetGraysFont = 10;
    graysFont = gray(length(indices) + offSetGraysFont);
    %graysFont = graysFont(end:-1:1, :);
    
    %% Plotting points
    for i = 1:size(nameFiles, 2)
        if isempty(strfind(nameFiles{i}, 'voronoiNoise')) == 0
            %             if isempty(strfind(names{i}, 'voronoiNoise-Image-10')) ~= 0
            nameDiagram = strsplit(nameFiles{i}, '-');
            h(8, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', graysFont (indices == str2num(nameDiagram{5}), :));
            hold on;
            
            %             end
%         elseif isempty(strfind(names{i}, 'imagen')) == 0
%             h(6, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(6, :));
%             hold on;
%             nameDiagram = strsplit(names{i}, '-');
%             t1 = text(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), nameDiagram(end));
%             t1.FontSize = 5;
%             t1.HorizontalAlignment = 'center';
%             t1.VerticalAlignment = 'middle';
%             t1.Color =  graysFont (find(indices == str2num(nameDiagram{end})) + offSetGraysFont, :);
        end
    end
    
    for i = 1:size(nameFiles, 2)
        if isempty(strfind(nameFiles{i}, 'omm')) == 0
            h(2, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(2, :));
%         elseif isempty(strfind(names{i}, 'BC')) == 0
%             h(1, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(1, :));
        elseif isempty(strfind(nameFiles{i}, 'cNT')) == 0
            h(3, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(3, :));
        elseif isempty(strfind(nameFiles{i}, 'dWL')) == 0
            h(4, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(4, :));
        elseif isempty(strfind(nameFiles{i}, 'dWP')) == 0
            h(5, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(5, :));
%         elseif isempty(strfind(names{i}, 'disk')) == 0 %voronoiWeighted
%             if isempty(strfind(names{i}, 'Neighbours'))
%                 h(7, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(7, :));
%             else
%                 h(17, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(7, :));
%             end
%             nameDiagram = strsplit(names{i}, '-');
%             t1 = text(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), nameDiagram(6));
%             t1.FontSize = 5;
%             t1.HorizontalAlignment = 'center';
%             t1.VerticalAlignment = 'middle';
%         elseif isempty(strfind(names{i}, 'Case-III')) == 0
%             h(10, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(10, :));
%         elseif isempty(strfind(names{i}, 'Case-II')) == 0
%             h(9, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(9, :));
%         elseif isempty(strfind(names{i}, 'Case-IV')) == 0
%             h(11, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(11, :));
%         elseif isempty(strfind(names{i}, 'dMWP')) == 0
%             h(12, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(12, :));
% %         elseif isempty(strfind(names{i}, 'Atrophy-Sim')) == 0
% %             h(13, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(13, :));
%         elseif isempty(strfind(names{i}, 'Control-Sim-Prol')) == 0
%             h(14, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(14, :));
%         elseif isempty(strfind(names{i}, 'Control-Sim-no-Prol')) == 0
%             h(15, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(15, :));
%         elseif isempty(strfind(names{i}, 'BNA')) == 0
%             h(16, :) = scatter3(differenceWithRegularHexagon(i), differenceRV(i) ,percentageOfHexagons(i), 'markerEdgeColor', colors(16, :));
%         else
%             names{i};
        end
    end
    
    %% Figure properties
    newNames = {'BCA', 'Eye', 'cNT', 'dWL', 'dWP', 'CVT', 'CVTw1', 'CVTn', 'Case II', 'Case III', 'Case IV', 'dMWP', 'Atrophy', 'Control', 'Control No Prol', 'BNA', 'CVTw2', 'Neo', 'Rosetta'};
    
    currentPathSplitted = strsplit(currentPath, '\');
    legend(h(h(:, 1) > 0, 1), newNames(h(:, 1) > 0)', 'Location', 'best', 'EdgeColor', [1 1 1]);
    
    xlabel('GDDRV', 'FontWeight', 'bold');
    ylabel('GDDH', 'FontWeight', 'bold');
    zlabel('Percentage of hexagons', 'FontWeight', 'bold');
    auxLim = xlim;
    xlim([0 auxLim(2)])
    auxLim = ylim;
    ylim([0 auxLim(2)])
    zlim([0 100]);
    
    saveas(h1, strcat(currentPathSplitted{4}, '_PercentageOfHexagons_GDDRV_GDDH', '-', strjoin(newNames(h(:, 1) > 0), '_'), '_', date), 'fig');

%     export_fig(h1, 'differenceGDDRV_GDDH', '-pdf', '-r300');
%     export_fig(h1, 'differenceGDDRV_GDDH----OpenGl', '-pdf', '-r300', '-opengl');
%     export_fig(h1, 'differenceGDDRV_GDDH----OpenGl2', '-pdf', '-r400', '-opengl');

end

