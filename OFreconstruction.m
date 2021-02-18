% This script is used to perform the experiments of Figures 6 and 7.

%%%%%%%%%%%%%%%%%%%%
%%%%  ctrl+F : INTERPOLATION DEGREE (in order to change the degree of the interpolation functions)
%%%%%%%%%%%%%%%%%%%%

clear
close all
clc
clf

addpath('./Functions/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FileName = '119'; % Loop Singularity (section 5)
% FileName = '113'; % Whorl singularity (section 5)

% FileName = '112'; % This the example displayed in section 2

% SCARCE_FileName = '2019-07-18-16_52_08_Results_119_Order3-3SCARCE';


% Format of the the output file where data are saved :
%
% <yyyy-mm-dd-HH_MM_SS_Results_>*FileName*<_Order>*x*<->*y*<.mat>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FVConGOING DATABASE

SecondFolder = 'FOESamples[FVConGoing]/GoodProcessed/';
ThirdFolder = 'FOESamples[FVConGoing]/InterpFingPrints/';

% ================= %
% Load Target File 
% ================= %
cible=load([SecondFolder,FileName,'.mat']);
M=cible.M;

[N1,N2]=size(M); %nombre de points de discretisation de la grille

xmax=1;
ymax=xmax*N1/N2; % ymax that respects the ratio of the original fingerprint

% ================= %
% Discretisation
% ================= %

dx=2*xmax/(N2-1); % the Num of Cols correspond to X 
x=-xmax:dx:xmax;

dy=2*ymax/(N1-1);
y=-ymax:dy:ymax; % the Num of rows correspond to Y

[X,Y]=meshgrid(x,y);

% n=5;
% trace(M,n,'red',X,Y)
% imshow(M,[0,pi])

% ======================================================= %
% parametres de modélisation des champs de vecteurs 
% Notation X = (u1,u2) et Y =(v1,v2)
% ======================================================= %

% ======================== %
%  INTERPOLATION DEGREE    %
% ======================== %
d1 = 3;   % degree du champ de vecteur X
d2 = 3;  % degree du champ de vecteur Y
%%%%%%%%%%%%%%%%%%%%

% d -> omega should be of length (n+1)*(n+2)/2 (where n denotes the degree)

% ===================================== %
% parameters of the gradient descent
% ===================================== %
if d1 <1
    omega_01 = [1;0];
else  % Automatic construction of Vfield X
    % Initial values of omega_01 parameters is 
    % [1, 0, 0, 0,...;
    %  0, 1, 0, 0,...]
    omega_01 = eye(2,(d1+1)*(d1+2)/2); % Should be Constructed With respect to d1
end

%%%
%
if d2 <1
    omega_02 = [1;0];
else
    % Initial values of omega_01 parameters is 
    % [0, 1, 0, 0,...;
    %  0, 0, 1, 0,...]
    omega_02=[zeros(2,1),eye(2,2),zeros(2,(d2+1)*(d2+2)/2-3)];  % Should be Constructed With respect to d2 [6 should be replaced by appropriate dim]

end
%%%%


% ======================== %
% Functionals definitions  %
% ======================== %
dis=@(omega1,omega2) (funct_dist(M,dL2L(omega1,omega2,X,Y))).^2;
E = @(omega1,omega2) sum(sum(dis(omega1,omega2)).^2);

grad = @(omega1,omega2) gradJ(omega1,omega2,M,xmax,ymax);
% ======================== %

% ===================================== %
% Initialisation of Descent parameters  %
% ===================================== %
% Omega_01
omega_old1=omega_01;
omega_aux1=omega_old1;
omega_new1=omega_old1;

% Omega_01
omega_old2=omega_02 ;              
omega_aux2=omega_old2;
omega_new2=omega_old2;

% precision parameters
epsilon=0.01; %precision
iter_max=8000; %2*8000;

% Initial error
erreur=E(omega_old1,omega_old2);
erreur0=erreur;
k=0;


preGrad = grad(omega_old1,omega_old2);
GradiX = preGrad.X;
GradGrec = preGrad.Y;

rho=.005*norm([omega_01,omega_02])/norm([GradiX,GradGrec]); % pas de la descente


% Elements d'affichage
figure(1)

% dx_int=2/(n-1);
% dy_int=2/(n-1);
% x_int=-n/2*dx_int+dx/2:dx_int:n/2*dx_int-dx/2;
% y_int=-n/2*dy_int+dy/2:dy_int:n/2*dy_int-dy/2;

%[X_int,Y_int]=meshgrid(x_int,y_int);

erreur_old=2*erreur;

% boucle 
n=2; % Parameter used for display pruposes
while((k<=iter_max) && (erreur>=epsilon*E(omega_old1,omega_old2))) %&& (erreur/erreur_old<=.999999)
    
    preGrad = grad(omega_old1,omega_old2);
    GradiX = preGrad.X;
    GradGrec = preGrad.Y;
    
    erreur_old=erreur;
    
%    omega_old1=omega_01;
%    omega_aux1=omega_old1;
%    omega_new1=omega_old1;
        
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
    % ===============
    % affichage Graphique
% %     
    if mod(k,10)==0
        L_aff=dL2L(omega_new1,omega_new2,X,Y);

        subplot(1,2,1)
        trace(M,n,'blue',X,Y,xmax,ymax);
        title(['Champ cible'])

        subplot(1,2,2)

        trace(L_aff,n,'red',X,Y,xmax,ymax);
        
        title(['iteration ',num2str(k), ', erreur = ',num2str(erreur/erreur0*100),' % de l''erreur initiale'])
        % axis square
        drawnow
    end
end

figure(1)

    L_aff=dL2L(omega_new1,omega_new2,X,Y);


    subplot(1,2,1)
    trace(M,n,'blue',X,Y,xmax,ymax);
    title(['Champ cible'])

    subplot(1,2,2)

    trace(L_aff,n,'red',X,Y,xmax,ymax);

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
    % imshow(flipud(L_aff),[0,pi])
    imshow(L_aff,[0,pi])
  

    subplot(2,2,3)
    preim=double(imread([SecondFolder,FileName,'.png']))/256;
    % imshow(flipud(preim))
    imshow(preim)
    subplot(2,2,4)
%%
    
    n=3;
    trace(L_aff,n,'red',X,Y,xmax,ymax);       
    
%%%%%  This will be in a new FIGURE 
%%
  traceWITHfig(L_aff,n,'red',X,Y,3,[SecondFolder,FileName],M,xmax,ymax)
   
   
   
 save([ThirdFolder,datestr(clock,'yyyy-mm-dd-HH_MM_SS'),'_Results_',FileName,'_Order',num2str(d1),'-',num2str(d2),'.mat'],'omega_new1',...
                       'omega_new2','X','Y','L_aff','xmax','ymax','M','FileName','SecondFolder'); 