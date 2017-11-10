function [ ] = plotGraphletsNetworkForPaper( image, validTotalCells, neighbours, validCells4, validCells5 )
%PLOTGRAPHLETSNETWORKFORPAPER Summary of this function goes here
%   Detailed explanation goes here

    centroids=regionprops(image,'Centroid');
    centroids=cat(1,centroids.Centroid);

    figure; imshow(ones(size(image)))
    hold on
    for i=1:length(validTotalCells)
        labelNeighs=neighbours{validTotalCells(i)};
        for j=1:size(labelNeighs)
            if ismember(labelNeighs(j), validTotalCells)
                plot([round(centroids(validTotalCells(i),1));round(centroids(labelNeighs(j),1))]...
                    ,[round(centroids(validTotalCells(i),2));round(centroids(labelNeighs(j),2))],'Color','black');
            end
        end
    end
    %close

    figure; imshow(ones(size(image)))
    hold on
    for i=1:length(validTotalCells)
            plot(round(centroids(validTotalCells(i),1))...
                ,round(centroids(validTotalCells(i),2)),'.r','MarkerSize',15);
    end
    for i=1:length(validCells4)
            plot(round(centroids(validCells4(i),1))...
                ,round(centroids(validCells4(i),2)),'.b','MarkerSize',15);
    end
    for i=1:length(validCells5)
            plot(round(centroids(validCells5(i),1))...
                ,round(centroids(validCells5(i),2)),'.g','MarkerSize',15);
    end
    %close 

    figure; imshow(image)


end

