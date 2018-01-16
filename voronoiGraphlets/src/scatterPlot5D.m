

    T = readtable('D:\Pablo\VoronoiGraphlet\fijiPlugins\Epigraph\docs\Tables\GDDs_shapeIndex_LManning(OrangeGreen_colorCode)_9-Jan-2018.xlsx');

    gdds = T(:, 2:6);
    gdds.Properties.VariableNames{4} = 'ShapeIndex';
    gdds.Properties.VariableNames{5} = 'Hexagons';
    
    imgsName = cellfun(@(x) strsplit(x, {'_'}), T.Imagename, 'UniformOutput', false);

    imgsName2 = cellfun(@(x) strjoin(x{1,1} , imgsName, 'UniformOutput', false);
    
    dataColours = horzcat(T.R, T.G, T.B)/255;
   
    [C, ia, ic] = unique(imgsName2, 'stable');

    [h,ax,bigax] = gplotmatrix(table2array(gdds), [], imgsName2, dataColours(ia, :), [], 20, [], [], gdds.Properties.VariableNames);


