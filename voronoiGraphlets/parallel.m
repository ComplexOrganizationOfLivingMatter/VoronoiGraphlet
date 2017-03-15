function [] = parallel(fullPathFile)
%PARALLEL Summary of this function goes here
%   Detailed explanation goes here
    img = imread(fullPathFile);
    L_img = watershed(1 - img, 8);
    c = regionprops(L_img, 'centroid');
    centroids = cat(1, c.Centroid);
    centroids=fliplr(round(centroids));
    [ vertices, neighbours_vertices ] = get_vertices( L_img );
    [ vertices_final, neighbours_vertices_final] = refine_vertices(vertices, neighbours_vertices);

    load(strcat(fullPathFile(1:end-4), '_data.mat'));
%     neighs_real = vecinos;
%     valid_cells = celulas_validas;

    save(strcat(fullPathFile(1:end-4), '_data.mat'), 'neighs_real', 'valid_cells', 'vertices_final', 'centroids', 'L_img', 'neighbours_vertices_final');
end