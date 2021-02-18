function out = gradJ(dL1,dL2,M,xmax,ymax)
% gradJ_nicolas(dL1,dL2,M)
% Computes the Gradient of the energy
% M : dataMatrix
%
% dL1 : list of parameters that defines vector fields X
% dL2 : list of parameters that defines vector fields Y
%
% The ouput is a *two fields structure* : grad.X and grad.Y

%% ETAPE 0 : CALCUL DE LA MATRICE L
N1 = size(M,1) ;  % Nbr de lignes de M 
N2 = size(M,2); % Nbr de colonnes de M 

%xmax=1; 
%ymax=1;

% ---   ---
% Discretisation
% ---   ---

dx=2*xmax/(N2-1);
x=-xmax:dx:xmax;

dy=2*ymax/(N1-1);
y=-ymax:dy:ymax;

[X,Y]=meshgrid(x,y);

% champs de vecteurs;
%
% u1 = f1(X,Y); % 1er composante du chp de vecteur X (note X1 dans le calcul du gradient)
% u2 = f2(X,Y); % 2nd composante du chp de vecteur X (note X2 dans le calcul du gradient)
%  
% v1=g1(X,Y); % 1er composante du chp de vecteur Y
% v2=g2(X,Y); % 2nd composante du chp de vecteur Y
%
u1 = 0;
u2 = 0;
degreeCounter = 0;

parametersCounter = 1; % Matlab counts starting from zero

parametersNumber1 = size(dL1,2);

while parametersCounter <= parametersNumber1
    for j = 0 : degreeCounter
       u1 = u1 + dL1(1,parametersCounter).*X.^(degreeCounter-j).*Y.^j;
       u2 = u2 + dL1(2,parametersCounter).*X.^(degreeCounter-j).*Y.^j;
       parametersCounter = parametersCounter + 1 ;
    end
    degreeCounter = degreeCounter+1;
end
     
%%%%%%%%
%%%%%%%%

v1 = 0;
v2 = 0;
degreeCounter = 0;

parametersCounter = 1; % Matlab counts starting from zero

parametersNumber2 = size(dL2,2);

while parametersCounter <= parametersNumber2
    for j = 0 : degreeCounter
       v1 = v1 + dL2(1,parametersCounter).*X.^(degreeCounter-j).*Y.^j;
       v2 = v2 + dL2(2,parametersCounter).*X.^(degreeCounter-j).*Y.^j;
       parametersCounter = parametersCounter + 1 ;
    end
    degreeCounter = degreeCounter+1;
end

%%%%%%%%
%%%%%%%%
%%%%%%%%

L=phase(u1,u2,v1,v2); % Calcul de L comme champ bissecteur de X et Y


%% ETAPE 1 : CALCUL de la MATRICE DISTANCE
%% Dist(i,j) = d(M_ij,L_ij) -- Dist est une matrice

% function  Dist = funct_dist(M,L) 
Dist=zeros(N1,N2);
for i=1:N1  
   for j=1:N2  
        if (abs(M(i,j)-L(i,j)) < (pi/2))
            Dist(i,j)=M(i,j)-L(i,j);
        else
            if (M(i,j)-L(i,j) > (pi/2))
               Dist(i,j)=M(i,j)-L(i,j)-pi;
            else
               Dist(i,j)=M(i,j)-L(i,j)+pi; 
            end            
        end
    end
end
Dist(isnan(Dist))=0;
% end

%% ETAPE 2 : CALCUL de MATRICES DE DERIVEES PARTIELLES (intermediaires)

dJdX1 = zeros(N1,N2); % Initialisation
dJdX2 = dJdX1;
dJdY1 = dJdX1;
dJdY2 = dJdX1;

NormX = 1./(u1.^2+u2.^2);
NormX(isnan(NormX)) = 0;
NormX(isinf(NormX)) = 0;

NormY = 1./(v1.^2+v2.^2);
NormY(isnan(NormY)) = 0;
NormY(isinf(NormY)) = 0;

% ----
dJdZ1 = zeros(2,N1,N2);
dJdZ2 = zeros(2,N1,N2);

dJdZ1(1,:,:) = (-Dist) .* (-u2.*NormX);
dJdZ1(2,:,:) = (-Dist) .* (u1.*NormX);

dJdZ2(1,:,:) = (-Dist) .* (-v2.*NormY);
dJdZ2(2,:,:) = (-Dist) .* (v1.*NormY);

% ----

dJda1 = zeros(2,parametersNumber1,N1,N2);
dJda2 = zeros(2,parametersNumber2,N1,N2);

% dJdX1 = .5*(-Dist).*(-u2.*NormX)
% dJdX2 = .5*(-Dist).*(u1.*NormX)
% dJdY1 = .5*(-Dist).*(-v2.*NormY)
% dJdY2 = .5*(-Dist).*(v1.*NormY)

%parametersNumber1 = size(dL1,2);

%while parametersCounter <= parametersNumber1
%    for j = 0 : degreeCounter
%       u1 = u1 + dL1(1,parametersCounter).*X.^j.*Y.^(degreeCounter+1-j)
%       u2 = u2 + dL1(2,parametersCounter).*X.^j.*Y.^(degreeCounter+1-j)
%    end    
%end

for i=1:2

    aux = squeeze(dJdZ1(i,:,:));
    
    degreeCounter = 0;
    parametersCounter = 1; % Matlab counts starting from zero
    
    while parametersCounter <= parametersNumber1
        for j = 0 : degreeCounter
           dJda1(i,parametersCounter,:,:) = aux.*ones(N1,N2).*X.^(degreeCounter-j).*Y.^j;
           parametersCounter = parametersCounter+1;
        end
        degreeCounter = degreeCounter+1;
    end    
end
    
for i=1:2
    aux = squeeze(dJdZ2(i,:,:));

    degreeCounter = 0;
    parametersCounter = 1; % Matlab counts starting from zero
    
    while parametersCounter <= parametersNumber2
        for j = 0 : degreeCounter
           dJda2(i,parametersCounter,:,:) = aux .*ones(N1,N2).*X.^(degreeCounter-j).*Y.^j;
           parametersCounter = parametersCounter+1;
        end
        degreeCounter = degreeCounter+1;
    end
end

%dJda(3:4,3:end,:,:)=0;
 
%% ETAPE 3 : CALCUL DU GRADIENT
% 6 is a param to change


TheGrad.X = zeros(2,parametersNumber1); % Initialisation
TheGrad.Y = zeros(2,parametersNumber2); % Initialisation

TheGrad.X=sum(dJda1,[3,4]);
TheGrad.Y=sum(dJda2,[3,4]);

out = TheGrad;

end