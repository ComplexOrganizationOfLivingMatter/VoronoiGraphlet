function [ vertices_3, neighbours_vertices_3 ] = refine_vertices( vertices,neighbours_vertices )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
vertices_2={};
neighbours_vertices_2={};
a=1;b=1;
vertices_no_discar=[];

%We get only the second vertex in case of repetition in neighbourhood
for i=1:length(vertices)
    
    pos=find(cellfun(@(x) isequal(x, neighbours_vertices{1,i}), neighbours_vertices)==1);
    
    if length(pos)>1
        
        vertices_rep{a}=pos;
        vertices_no_discar(b)=pos(2);
        a=a+1;
        b=b+1;
    else
        
        vertices_no_discar(b)=pos;
        b=b+1;
    end
end

vertices_uniq=unique(vertices_no_discar);
    
neighbours_vertices_2={neighbours_vertices{vertices_uniq}};
vertices_2={vertices{vertices_uniq}};

%refine errors (vertices with 4 neighbours who are surrounded by others vertices)
pos_dudes=find(cellfun(@(x) size(x,1)>3, neighbours_vertices_2)==1);

neigh_pos_dudes=[];
for i=1:length(pos_dudes)

    %get  [x,y] position
    XY=cat(1,vertices_2{pos_dudes(i)});
    x=XY(1);y=XY(2);
    
    %neigh pixels
    pixels_neigh={[x+1,y+1];[x+1,y];[x+1,y-1];[x,y+1];[x,y+1];[x,y-1];[x-1,y+1];[x-1,y];[x-1,y-1]};
        
    %find neigh vertices of vertex in dude
    for j=1:length(vertices_2)
        if sum(cellfun(@(coord) isequal(vertices_2{1,j},coord), pixels_neigh))==1;
            neigh_pos_dudes=[neigh_pos_dudes,j];
        end
    end
end

vert_valid=1:length(vertices_2);
vert_valid(neigh_pos_dudes)=[];

vertices_3={vertices_2{1,vert_valid}};
neighbours_vertices_3={neighbours_vertices_2{1,vert_valid}};

end

