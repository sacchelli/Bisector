function  Dist = funct_dist(M,L) 
% Dist = funct_dist(M,L) 
% Implements the distance d [equ. 1 of version 1 of the article]
%
% It is assumed that M and L have the same dimensions
N1 = size(M,1);
N2 = size(M,2);
Dist=zeros(N1,N2);

for i=1:N1  %taille(1)
   for j=1:N2  %taille(2)
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
Dist(isnan(Dist))=0;
end

