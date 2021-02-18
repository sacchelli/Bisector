function  trace(L,n,color,X,Y,xmax,ymax)
% trace(L,n,color,X,Y,xmax,ymax)
%
% This function traces an orientation field.
%
% L : an orientation filed phase angles expressed in a 2D meshgrid with
% nodes given by parameters X and Y
% n : spacing between data points that are *actually* used
% color : color of the plot

m=3;%floor(mod(length(X(1,:)),n)/2);

q1=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(L(m:n:end,m:n:end)),sin(L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1.5);
hold on
q2=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(L(m:n:end,m:n:end)),-sin(L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1.5);
hold off
q1.Color=color;
q2.Color=color;
q1.AutoScaleFactor=.3;
q2.AutoScaleFactor=.3;
axis equal
axis([-xmax,xmax,-ymax,ymax]); %; ,'style','equal')


% -- This reverses the axes and prevents using flipud command --
set(gca,'Ydir','reverse')
% ---   ---   ---   ---   ---
% axis square
end