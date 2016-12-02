function [ vertices,neighbours_vertices ] = get_vertices( L_img )
% With a labelled image as input, the objective is get all vertex for each
% cell

countVertexs=1;
maxCell=max(max(L_img))+1;
ratio=4;
se=strel('square',ratio);

[H,W,c]=size(L_img);

for row=1:size(L_img,1)
    for col=1:size(L_img,2)
    
        if L_img(row,col)==0 %border of cell
            aux=zeros(H,W);
            aux(row,col)=1;
            aux_dilate=imdilate(aux==1,se);
            pixels_neigh=aux_dilate==1;
            
            neighbours = unique(L_img(pixels_neigh));
            neighbours = neighbours(neighbours ~= 0);
            
            if size(neighbours, 1) > 2 || row==1 || col==1 || row==H || col==W %vertex or touch the limit
                    
                        vertices{countVertexs} = [row, col];
                        neighbours_vertices{countVertexs} = neighbours;
                        countVertexs = countVertexs + 1;
            end
        
        end
    end

end

imshow(L_img)
hold on
for i=1:size(vertices,2), a=vertices{1,i}; plot(a(2),a(1),'*r'), end

hold off
end

