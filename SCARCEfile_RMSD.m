% Uses the results obtained from a SCARCE reconstruction 
% and compute RMSD
% This is the RMSD corresponding to Fig. 8 experiment

close all
clear all


SecondFolder = 'FOESamples[FVConGoing]/GoodProcessed/';

ThirdFolder = 'FOESamples[FVConGoing]/InterpFingPrints/';

FileName = '119'; % Loop SIngularity
% FileName = '113'; % Whorl singularity


% % % % % % % % % % %
% % % 40 GOOD DATAPOINTS (ARTICLE DATA)
DataFileNAME1 = 'SCARCE_RESULTS_2019-07-22-12_32_10_[SCARCE_[2019-07-18-16_52_08_Results_119_Order3-3]]_Order3-3';
DataFileNAME2 = 'SCARCE_[2019-07-18-16_52_08_Results_119_Order3-3]';


Repo = 'FOESamples[FVConGoing]/InterpFingPrints/';

%%%%
load([Repo,DataFileNAME1,'.mat'])
load([Repo,DataFileNAME2,'.mat'])
%%




% ============== %
%  STORAGE DATA
% ============= %

Ground_Truth = L_aff;


Indexes = ~isnan(M);
Ndata = sum(sum(Indexes));
% Ground_Truth(Indexes) = G_Truth(Indexes);
Distances = funct_dist(Ground_Truth,SCARCE_L_aff);
RMSD_OF = sqrt(sum(sum(Distances.^2))/Ndata);

disp(['RMSD_OF = ',num2str(RMSD_OF)]);

% % % % %     
% % % % %         TOTAL_RMSD (i,j) = RMSD_OF;
% % % % %     end
% % % % % end
% % % % % 
% % % % % Mean_RMSD= sum(TOTAL_RMSD,2)/Nfiles;
% % % % % 
% % % % % disp('DONE');
% % % % % 
% % % % % disp('TOTAL_RMSD :');
% % % % % disp(TOTAL_RMSD);
% % % % % 
% % % % % 
% % % % % 
% % % % % disp('Mean computation');
% % % % % disp(Mean_RMSD)

