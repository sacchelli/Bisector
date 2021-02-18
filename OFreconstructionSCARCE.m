% This script is used to perform the experiment of Figure 8.

%%%%%%%%%%%%%%%%%%%%
%%%%  ctrl+F : INTERPOLATION DEGREE
%%%%%%%%%%%%%%%%%%%%

clear
close all
clc
clf

addpath('./Functions/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FileName = '119'; % Loop SIngularity
% FileName = '113'; % Whorl singularity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select the file containing the scarce data

% SCARCE_FileName = 'SCARCE_[2019-07-18-16_52_08_Results_119_Order3-3]'; %
% 40 'GOOD' DATAPOINTS
% This is the file used in the article (Fig.8)


% SCARCE_FileName = 'SCARCE3_[2019-07-18-16_52_08_Results_119_Order3-3]';
% 40 POORLY CHOSEN DATAPOINTS
% File used for comparison purposes (data not presented in the article)


% SCARCE_FileName = 'SCARCE2_[2019-07-18-16_52_08_Results_119_Order3-3]'; %
% POOR DATA (3 datapoints)
% File used for comparison purposes (data not presented in the article)


SCARCE_FileName = 'SCARCE4_[2019-07-18-16_52_08_Results_119_Order3-3]';
% 20 DATAPOINTS
% File used for comparison purposes (data not presented in the article)

% Format of the output file :
% <SCARCE_RESULTS_yyyy-mm-dd-HH_MM_SS_[>*SCARCE_FileName*<]_Order>*x*<->*y*<.mat>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FVConGOING DATABASE
SecondFolder = 'FOESamples[FVConGoing]/GoodProcessed/';

ThirdFolder = 'FOESamples[FVConGoing]/InterpFingPrints/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load([ThirdFolder,SCARCE_FileName,'.mat']);


M_original = M;
M = L_SCARCE; % The TARGET IS A MORE PRECISE, BUT LESS RICH VERSION OF M.


[N1,N2]=size(M); %nombre de points de discretisation de la grille


% xmax is given by the SCARCE FILE
% ymax is given by the SCARCE FILE

% Discretisation
% % % % %
% NOT NEEDED
% % % % %
% dx=2*xmax/(N2-1); % Num of Cols correspond to X 
% x=-xmax:dx:xmax;

% dy=2*ymax/(N1-1);
% y=-ymax:dy:ymax; % Num of rows correspond to Y

% [X,Y]=meshgrid(x,y); % Given by the SCARCE FILE
% % % % % %

% n=5;
% trace(M,n,'red',X,Y)
% imshow(M,[0,pi])

% parametres de modélisation des champs de vecteurs 
% Notation X = (u1,u2) et Y =(v1,v2)
%%%%%%%%%%%%%%%%%%%%
%%%%  INTERPOLATION DEGREE
d1 = 3;   % degree du champ de vecteur X
d2 = 3;  % degree du champ de vecteur Y
%%%%%%%%%%%%%%%%%%%%

% d -> omega should be of length (n+1)*(n+2)/2

%%% ---   --- 
% parametres de descente
%%% ---   ---
% % %
% INITIAL VALUE OF OMEGA_1

if d1 <1
    omega_01 = [1;0];
else
    omega_01 = eye(2,(d1+1)*(d1+2)/2); % Should be Constructed With respect to d1 [6 should be replaced by appropriate dim]
end

%%%   
%
omega_old1=omega_01;
omega_aux1=omega_old1;
omega_new1=omega_old1;

% % %
% INITIAL VALUE OF OMEGA_2
if d2 <1
    omega_02 = [1;0];
else
     omega_02=[zeros(2,1),eye(2,2),zeros(2,(d2+1)*(d2+2)/2-3)];  % Should be Constructed With respect to d2 [6 should be replaced by appropriate dim]
end
%%%%
%

omega_old2=omega_02 ;              
omega_aux2=omega_old2;
omega_new2=omega_old2;

epsilon=0.01; %precision
iter_max=8000;

dis=@(omega1,omega2) (funct_dist(M,dL2L(omega1,omega2,X,Y))).^2;
E = @(omega1,omega2) sum(sum(dis(omega1,omega2)).^2);

grad = @(omega1,omega2) gradJ(omega1,omega2,M,xmax,ymax);

erreur=E(omega_old1,omega_old2);
erreur0=erreur;
k=0;

preGrad = grad(omega_old1,omega_old2);
GradiX = preGrad.X;
GradGrec = preGrad.Y;

rho=.005*norm([omega_01,omega_02])/norm([GradiX,GradGrec]); % pas de la descente


% Elements d'affichage
figure(1)

erreur_old=2*erreur;

% boucle 

while((k<=iter_max) && (erreur>=epsilon*E(omega_old1,omega_old2))) %&& (erreur/erreur_old<=.999999)
    
    preGrad = grad(omega_old1,omega_old2);
    GradiX = preGrad.X;
    GradGrec = preGrad.Y;
    
    erreur_old=erreur;
        
    omega_aux1 = omega_old1-rho*GradiX;
    omega_aux2 = omega_old2-rho*GradGrec;
    
    norm_aux1 = sqrt(sum(omega_aux1.^2,[1,2]));
    norm_aux2 = sqrt(sum(omega_aux2.^2,[1,2]));
    
    omega_new1 = omega_aux1/norm_aux1;
    omega_new2 = omega_aux2/norm_aux2;
    
    erreur = E(omega_old1,omega_old2);
    
    omega_old1 = omega_new1;
    omega_old2 = omega_new2;
    
    k=k+1;
  
    % affichage
    
    if mod(k,10)==0 
        SCARCE_L_aff=dL2L(omega_new1,omega_new2,X,Y);

        subplot(1,2,1)
        n=1;
        trace(M,n,'blue',X,Y,xmax,ymax);
        title(['Champ cible'])

        subplot(1,2,2)
        
        n = 3;
        trace(SCARCE_L_aff,n,'red',X,Y,xmax,ymax);
        
        title(['iteration ',num2str(k), ', erreur = ',num2str(erreur/erreur0*100),' % de l''erreur initiale'])
        % axis square
        drawnow
    end
end

figure(1)

    SCARCE_L_aff=dL2L(omega_new1,omega_new2,X,Y);


    subplot(1,2,1);
    n = 1;
    trace(M,n,'blue',X,Y,xmax,ymax);
    title(['Champ cible'])

    subplot(1,2,2)
    n = 3;
    trace(SCARCE_L_aff,n,'red',X,Y,xmax,ymax);

    title(['iteration ',num2str(k), ', erreur = ',num2str(erreur/erreur0*100),' % de l''erreur initiale'])
    % axis square
    drawnow
%%
  disp(['Erreur initiale : ',num2str(erreur0)]);
 
 figure(2)
    subplot(2,2,1)
    % imshow(flipud(M),[0,pi])
    imshow(M,[0,pi])
    subplot(2,2,2)
    % imshow(flipud(SCARCE_L_aff),[0,pi])
    imshow(SCARCE_L_aff,[0,pi])
  

    subplot(2,2,3)
    preim=double(imread([SecondFolder,FileName,'.png']))/256;
    % imshow(flipud(preim))
    imshow(preim)
    subplot(2,2,4)

    n=10;
    trace(SCARCE_L_aff,n,'red',X,Y,xmax,ymax);       
    
%%%%%  This will be in a new FIGURE 
%%
%  n = 1;
traceWITHfigSCARCE(SCARCE_L_aff,n,'red',X,Y,3,[SecondFolder,FileName],M,xmax,ymax)
   
datestr(clock);
    
save([ThirdFolder,'SCARCE_RESULTS_',datestr(clock,'yyyy-mm-dd-HH_MM_SS'),'_[',SCARCE_FileName,']_Order',num2str(d1),'-',num2str(d2),'.mat'],'omega_new1',...
                       'omega_new2','X','Y','SCARCE_L_aff','xmax','ymax','L_SCARCE','FileName','SecondFolder'); 