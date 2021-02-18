function  traceWITHfig(L,n,color,X,Y,FigNum,FileName,M,xmax,ymax)
% traceWITHfig(L,n,color,X,Y,FigNum,FileName,M,xmax,ymax)
% This function traces an orientation field.
%
% L : an orientation filed phase angles expressed in a 2D meshgrid with
% nodes given by parameters X and Y
% n : spacing between data points that are *actually* used
% color : color of the plot
%
% FigNum : figure number
% FileName : name of the file containing the picture (without extension .png is added afterwards)
%
% M : Original Data Matrix (may contain Nan)

m=3;%floor(mod(length(X(1,:)),n)/2);

preim=double(imread([FileName,'.png']));

Modified_L = L;
Modified_L(isnan(M))=NaN;

Titi = figure(FigNum);

colormap(Titi,'gray');

subplot(1,2,1);

image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],preim,'CDataMapping','scaled')


hold on
q1=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(L(m:n:end,m:n:end)),sin(L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1.5);
q2=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(L(m:n:end,m:n:end)),-sin(L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1.5);
hold off
q1.Color=color;
q2.Color=color;
q1.AutoScaleFactor=.3;
q2.AutoScaleFactor=.3;
axis([-xmax,xmax,-ymax,ymax])
% axis square


%%%%%%%%
% Second Image

subplot(1,2,2);

image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],preim,'CDataMapping','scaled')


n=1;
hold on
q1=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(Modified_L(m:n:end,m:n:end)),sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1.5);
q2=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(Modified_L(m:n:end,m:n:end)),-sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1.5);
hold off
q1.Color=color;
q2.Color=color;
q1.AutoScaleFactor=.3;
q2.AutoScaleFactor=.3;
axis([-xmax,xmax,-ymax,ymax])
% axis square

end
