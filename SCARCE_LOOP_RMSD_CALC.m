% Computes the RMSD results that are presented in Table 1.
% Uses the data that are contained in the
% '2019-07-18-16_52_08_Results_119_Order3-3' folder

close all
clear all



addpath('./Functions/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SecondFolder = 'FOESamples[FVConGoing]/GoodProcessed/';
ThirdFolder = 'FOESamples[FVConGoing]/InterpFingPrints/';

FileName = '119'; % Loop SIngularity
% FileName = '113'; % Whorl singularity


SCARCE_Folder = '2019-07-18-16_52_08_Results_119_Order3-3';


TheFolder = [ThirdFolder filesep SCARCE_Folder];

MyFolderInfo=dir(TheFolder);
%%%  The first 3 data are useless to me..

ActualInfo = MyFolderInfo(4:end);

Nfolders = size(ActualInfo,1);

% ============== %
%  STORAGE DATA
% ============= %
TOTAL_RMSD = [];

i = 1;

for i = 1 : Nfolders  

    TheFolder2 = [TheFolder filesep ActualInfo(i).name  filesep 'INTERPOLATED' ];

    fileList = dir(fullfile(TheFolder2, '*.mat'));

    Nfiles = size(fileList,1);

    TOTAL_RMSD = [TOTAL_RMSD ; zeros(1,Nfiles)];
    
    for j = 1 : Nfiles
        
        load([TheFolder2 filesep fileList(j).name]);
        Ground_Truth = nan(size(G_Truth));
        Indexes = ~isnan(M_original);
        Ndata = sum(sum(Indexes));
        Ground_Truth(Indexes) = G_Truth(Indexes);
        Distances = funct_dist(Ground_Truth,SCARCE_L_aff);
        RMSD_OF = sqrt(sum(sum(Distances.^2))/Ndata);
    
        TOTAL_RMSD (i,j) = RMSD_OF;
    end
end

Mean_RMSD= sum(TOTAL_RMSD,2)/Nfiles;

disp('DONE');

disp('TOTAL_RMSD :');
disp(TOTAL_RMSD);



disp('Mean computation');
disp(Mean_RMSD)


Interm  = (TOTAL_RMSD - Mean_RMSD*ones(1,Nfiles)).^2;

Var = sum(Interm,2)/Nfiles;

Etype =sqrt(Var);

disp('-------')
disp('Variance');
disp(num2str(Var,'%.12f'))


disp('-------')
disp('E-type');
disp(num2str(Etype,'%.12f'))



disp('-------')
disp('Mean RMSD');
disp(num2str(Mean_RMSD,'%.12f'))
