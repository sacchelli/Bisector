clear all
close all
clc
clf

addpath('./Functions/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DataFileNAME = '2019-07-18-16_52_08_Results_119_Order3-3'; % Loop Experiment [ARTICLE GRAPH - Fig. 7]

% DataFileNAME = '2019-07-19-14_48_25_Results_113_Order3-3';  % Whorl Experiment [ARTICLE GRAPH - Fig. 6]

% DataFileNAME = '2020-03-11-16_39_57_Results_112_Order3-3' % Loop experimen [ARTICLE GRAPH - fig. 1]




%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Repo = 'FOESamples[FVConGoing]/InterpFingPrints/';

% PARAMETERS
n = 6; % Consider 1 data out of n
color = 'red';
m=3; % Starting index for graphs

% Line = 1; %0 means tha figures are placed following a square shape [NOT USED]

%%%%
load([Repo,DataFileNAME,'.mat'])

%traceWITHfig(L_aff,1,'red',X,Y,1,[SecondFolder,FileName],M,xmax,ymax)

preim=double(imread([[SecondFolder,FileName],'.png']));

Fig1 = figure(1)
colormap(Fig1,'gray');

% if Line
%    subplot(1,4,1);
% else
%    subplot(2,2,1);
%end


image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],preim,'CDataMapping','scaled')
axis equal
axis([-xmax,xmax,-ymax,ymax]);
%title('Original image');
set(gca,'visible','off')

%%
% if Line
%    subplot(1,4,2);
%else
%    subplot(2,2,2);
%end


Fig2 = figure(2)
colormap(Fig2,'gray');
image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],preim/2,'CDataMapping','scaled');


%colorbar

Modified_L = L_aff;
%Modified_L(isnan(M))=NaN;

hold on
q1=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(Modified_L(m:n:end,m:n:end)),sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',2);
q2=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(Modified_L(m:n:end,m:n:end)),-sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',2);


q3=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(Modified_L(m:n:end,m:n:end)),sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1);
q4=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(Modified_L(m:n:end,m:n:end)),-sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1);

hold off
q1.Color=color;
q2.Color=color;
q1.AutoScaleFactor=.3;
q2.AutoScaleFactor=.3;

q3.Color='white';
q4.Color='white';
q3.AutoScaleFactor=.3;
q4.AutoScaleFactor=.3;

axis equal
axis([-xmax,xmax,-ymax,ymax]);
%title({'Interpolated','Orientation Field'});
set(gca,'visible','off')



%
%%%
%if Line
%    subplot(1,4,3);
%else
%    subplot(2,2,3);
%end
Fig3 = figure(3)
colormap(Fig3,'gray');
image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],pi-M,'CDataMapping','scaled')
% colorbar
axis equal
axis([-xmax,xmax,-ymax,ymax]);
%title({'Targeted','field'});
set(gca,'visible','off')
%
%%%


%if Line
%    subplot(1,4,4);
%else
%    subplot(2,2,4);
%end

Fig4 = figure(4)
colormap(Fig4,'gray');
image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],pi-L_aff,'CDataMapping','scaled')
% colorbar
axis equal
axis([-xmax,xmax,-ymax,ymax]);
set(gca,'visible','off')              
%title({'Estimated','field'});