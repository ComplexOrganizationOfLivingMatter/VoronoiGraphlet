
directories = dir('D:\Pablo\VoronoiGraphlet\fijiPlugins\Epigraph\results\GraphletsHistogram_MO29\**\*.csv');

addpath(genpath('src'));
close all


%directoryNames = {'dwp', 'dwl', 'eye', 'mbs_disc1', 'mbs_disc2', 'mbs_disc3', 'wildtype'};
%directoryNames = {'mbs_1_t01', 'mbs_1_t16', 'mbs_1_t31', 'mbs_2_t01', 'mbs_2_t16', 'mbs_2_t31'};%, 'mbs_3_t01', 'mbs_3_t16', 'mbs_3_t31'};%, 'neo0', 'neo1', 'neo2'};%, 'mbs_disc2', 'mbs_disc3', 'hexagons', 'squares2', 'squaresoctogons', 'rosseta_001', 'rosseta_035', 'rosseta_070', 'rosseta_100', 'rosseta_135', 'rosseta_170', 'rosseta_200', 'rosseta_235'};
numSampleNeo = '2';
directoryNames = {strcat('neo', numSampleNeo, '_t1'), strcat('neo', numSampleNeo, '_t2'), strcat('neo', numSampleNeo, '_t3'), strcat('neo', numSampleNeo, '_t4'), strcat('neo', numSampleNeo, '_t5'), strcat('neo', numSampleNeo, '_t6')};
%directoryNames = {'eye_1', 'eye_2', 'eye_3', 'mbs_3_t01', 'mbs_3_t16', 'mbs_3_t31'};

infoPerImageKind = cell(length(directoryNames), 1);

%graphletsNames = cellfun(@(x) strcat('G', num2str(x)), graphletsOrbitsRelation(:, 1), 'UniformOutput', false);
figure;
for numKindOfGDD = 1:3
    for numFile = 1:size(directories, 1)
        csvFile = readtable(fullfile(directories(numFile).folder, directories(numFile).name));
        %[graphletsOrbitsRelation] = getGraphletsHistogram(csvFile);
        if isequal(directories(numFile).name, 'orbitWeight.csv')
            [orbitsWeights, typeOfGDD] = getOrbitsWeights(csvFile);
            actualDir = cellfun(@(x) contains(lower(directories(numFile).folder), x), directoryNames);
            [graphletsOrbitsRelation] = getGraphletsHistogram(orbitsWeights(numKindOfGDD, :));
            infoPerImageKind(actualDir) = {vertcat(infoPerImageKind{actualDir}, [graphletsOrbitsRelation{:, 3}])};
        end
    end


    
    [~, orderG] = unique(graphletsNames);
    graphletsNamesCat = categorical(graphletsNames);

    %maxY = max(max(vertcat(infoPerImageKind{:}))+10);
    maxY = 0.16;


    for numKind = 1:length(directoryNames)
        y = mean(infoPerImageKind{numKind}, 1);
        x = graphletsNamesCat;
       subplot(length(directoryNames), 3, ((numKind-1)*3)+numKindOfGDD);
       bar(x,y);
       set(gca, 'FontSize', 4)
       %hold on;
       labels = arrayfun(@(value) num2str(value,'%2.1f'),y,'UniformOutput',false);
    %    text(x,y*100,labels,...
    %        'HorizontalAlignment','center',...
    %        'VerticalAlignment','bottom')
       title(strcat(directoryNames{numKind}, '_', typeOfGDD{numKindOfGDD}));
       %ylim([-5 5]);
       ylim([0 maxY]);
    end
end

print(strcat('orbitsWeights_Neo_', numSampleNeo,'.pdf'), '-dpdf', '-fillpage');