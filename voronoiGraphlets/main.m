%Developed by Pablo Vicente-Munuera

%% --------- generate again voronoi diagrams ----------%

for numName = 1:20
    fileName = strcat('E:\Pablo\PhD-miscelanious\voronoiGraphlets\data\voronoiDiagrams\imagen_', num2str(numName));
    generateVoronoi( 20, 1024, 500, fileName );
end

createNetworksFromVoronoiDiagrams('E:\Pablo\PhD-miscelanious\voronoiGraphlets\data\voronoiDiagrams\data');
calculateLEDAFilesFromDirectory('E:\Pablo\PhD-miscelanious\voronoiGraphlets\results\networks\Original\');

filterByNonValidCells( 'E:\Pablo\PhD-miscelanious\voronoiGraphlets\results\graphletResults\test\' );

%% Pipelines of different tissues

pipelineGraphletsVoronoi('SickEpitheliums\');
pipelineGraphletsVoronoi('voronoiNoise\');
pipelineGraphletsVoronoi('voronoiWeighted\');
pipelineGraphletsVoronoi('biologicalImagesAndVoronoi\');
pipelineGraphletsVoronoi('Neo\');

%% 8 initial graphics
getPercentageOfHexagons('results\graphletResultsFiltered\allOriginal\', '', 'maxLength5');
getPercentageOfHexagons('results\graphletResultsFiltered\allOriginal\', '', 'maxLength4');
getPercentageOfHexagons('results\graphletResultsFiltered\allOriginal\', '', 'Total');

%Basica parcial
analyzeGraphletDistances(strcat('results\distanceMatrix\biologicalImagesAndVoronoi\', 'BasicaParcial\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiNoise\', 'BasicaParcial\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\SickEpitheliums\', 'BasicaParcial\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'BasicaParcial\NeighboursOfCancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'BasicaParcial\CancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\Neo\', 'BasicaParcial\'), 'gdda');


%Basica
analyzeGraphletDistances(strcat('results\distanceMatrix\biologicalImagesAndVoronoi\', 'Basica\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiNoise\', 'Basica\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\SickEpitheliums\', 'Basica\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'Basica\NeighboursOfCancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'Basica\CancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\Neo\', 'Basica\'), 'gdda');

%Total Parcial
analyzeGraphletDistances(strcat('results\distanceMatrix\biologicalImagesAndVoronoi\', 'TotalParcial\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiNoise\', 'TotalParcial\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\SickEpitheliums\', 'TotalParcial\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'TotalParcial\NeighboursOfCancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'TotalParcial\CancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\Neo\', 'TotalParcial\'), 'gdda');


%Total
analyzeGraphletDistances(strcat('results\distanceMatrix\biologicalImagesAndVoronoi\', 'Total\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiNoise\', 'Total\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\SickEpitheliums\', 'Total\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'Total\NeighboursOfCancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\voronoiWeighted\', 'Total\CancerCells\'), 'gdda');
analyzeGraphletDistances(strcat('results\distanceMatrix\Neo\', 'Total\'), 'gdda');

%Total
%analyzeGraphletDistances(strcat('results\comparisons\Total\', 'maxLength5\'), 'gdda');

%comparisons
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\BasicaParcial\AgainstHexagons\', '' )
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\BasicaParcial\AgainstVoronoi1\', '' )
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\BasicaParcial\AgainstVoronoi1\', 'GDDRV_GDDRH')

%comparisons
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\Basica\AgainstHexagons\' , '')
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\Basica\AgainstVoronoi1\' , '')
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\Basica\AgainstVoronoi1\', 'GDDRV_GDDRH')

%comparisons
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\TotalParcial\AgainstHexagons\', '' )
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\TotalParcial\AgainstVoronoi1\', '' )
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\TotalParcial\AgainstVoronoi1\', 'GDDRV_GDDRH')

%comparisons
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\Total\AgainstHexagons\', '' )
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\Total\AgainstVoronoi1\', '')
comparePercentageOfHexagonsAgainstComparisonWithRegularHexagons( 'results\comparisons\EveryFile\Total\AgainstVoronoi1\', 'GDDRV_GDDRH')

%% INDIVIDUAL CELL COMPARISON

analyzeGraphletDistances(strcat('results\comparisons\IndividualCells\', ''), 'gdda');
figure;
hold on;
for i = 1:length(names)
    if isempty(strfind(names{i}, 'azules')) == 0
        plot(differenceMean(i), distanceMatrix(i), 'o', 'color', [0.2 0.8 1.0]);
    elseif isempty(strfind(names{i}, 'verdes')) == 0
        plot(differenceMean(i), distanceMatrix(i), 'o', 'color', [0.0 0.6 0.0]);
    end
end
