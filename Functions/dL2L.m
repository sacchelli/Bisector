function [L] = dL2L(dL1,dL2,X,Y)
% dL2L(dL1,dL2,X,Y,M) reconstructs the two components of the two vector fields
% X(dL), Y(dL)
%
%

% u1 = dL1(1,1) + dL1(1,2).*X + dL1(1,3).*Y + dL1(1,4).*X.*X + dL1(1,5).*X.*Y + dL1(1,6).*Y.*Y;
% u2 = dL1(2,1) + dL1(2,2).*X + dL1(2,3).*Y + dL1(2,4).*X.*X + dL1(2,5).*X.*Y + dL1(2,6).*Y.*Y;
% 
% v1 = dL2(1,1) + dL2(1,2).*X + dL2(1,3).*Y + dL2(1,4).*X.*X + dL2(1,5).*X.*Y + dL2(1,6).*Y.*Y;
% v2 = dL2(2,1) + dL2(2,2).*X + dL2(2,3).*Y + dL2(2,4).*X.*X + dL2(2,5).*X.*Y + dL2(2,6).*Y.*Y;

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

% %%%%%%%%
% %%%%%%%%
% %%%%%%%%
% 
L=phase(u1,u2,v1,v2);     % Calcul de L comme champ bissecteur de X et Y
end

