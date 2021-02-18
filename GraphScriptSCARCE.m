clear all
close all
clc
clf

addpath('./Functions/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % %
% % % 40 GOOD DATAPOINTS (Article - Fig. 8) 
DataFileNAME1 = 'SCARCE_RESULTS_2019-07-22-12_32_10_[SCARCE_[2019-07-18-16_52_08_Results_119_Order3-3]]_Order3-3'
DataFileNAME2 = 'SCARCE_[2019-07-18-16_52_08_Results_119_Order3-3]';


% % % % % % % % % % %
% % % 40 BAD DATAPOINTS
% DataFileNAME1 = 'SCARCE_RESULTS_2019-07-22-14_24_40_[SCARCE3_[2019-07-18-16_52_08_Results_119_Order3-3]]_Order3-3';
% DataFileNAME2 = 'SCARCE3_[2019-07-18-16_52_08_Results_119_Order3-3]';



% % % % % % % % % % %
% % % 20 BAD DATAPOINTS
% DataFileNAME1 ='SCARCE_RESULTS_2019-07-22-15_55_43_[SCARCE4_[2019-07-18-16_52_08_Results_119_Order3-3]]_Order3-3';
% DataFileNAME2 = 'SCARCE4_[2019-07-18-16_52_08_Results_119_Order3-3]';



% % % % % % % % % % %
% % % BAD RESULT (3 data Points)
% DataFileNAME1 = 'SCARCE_RESULTS_2019-07-22-12_09_47_[SCARCE2_[2019-07-18-16_52_08_Results_119_Order3-3]]_Order3-3'
%DataFileNAME2 = 'SCARCE2_[2019-07-18-16_52_08_Results_119_Order3-3]';



% % % % % % % % % % %
% % % Graphs Corresponding to Fig. 10 and Table 1 experiments.
% 10 POINTS CASE
% DataFileNAME1 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE10/INTERPOLATED/INTERPOLATED_Order3_3__SCARCE10_SAMPLE09_[2019-07-18-16_52_08_Results_119_Order3-3]';
% DataFileNAME2 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE10/SCARCE10_SAMPLE09_[2019-07-18-16_52_08_Results_119_Order3-3]';

% 20 POINTS CASE

% DataFileNAME1 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE20/INTERPOLATED/INTERPOLATED_Order3_3__SCARCE20_SAMPLE09_[2019-07-18-16_52_08_Results_119_Order3-3]';
% DataFileNAME2 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE20/SCARCE20_SAMPLE09_[2019-07-18-16_52_08_Results_119_Order3-3]';

% 40 POINTS CASE
% DataFileNAME1 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE40/INTERPOLATED/INTERPOLATED_Order3_3__SCARCE40_SAMPLE04_[2019-07-18-16_52_08_Results_119_Order3-3]';
% DataFileNAME2 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE40/SCARCE40_SAMPLE04_[2019-07-18-16_52_08_Results_119_Order3-3]';

% 80 POINTS CASE
% DataFileNAME1 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE80/INTERPOLATED/INTERPOLATED_Order3_3__SCARCE80_SAMPLE01_[2019-07-18-16_52_08_Results_119_Order3-3]';
% DataFileNAME2 = '2019-07-18-16_52_08_Results_119_Order3-3/SCARCE80/SCARCE80_SAMPLE01_[2019-07-18-16_52_08_Results_119_Order3-3]';

Repo = 'FOESamples[FVConGoing]/InterpFingPrints/';

% PARAMETERS
n = 6; % Consider 1 data out of n
color = 'red';
m=3; % Starting index for graphs

Line = 1; %0 means square (Figures placements)

%%%%
load([Repo,DataFileNAME1,'.mat'])
load([Repo,DataFileNAME2,'.mat'])

%traceWITHfig(SCARCE_L_aff,1,'red',X,Y,1,[SecondFolder,FileName],M,xmax,ymax)

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


Fig2 = figure(2)
colormap(Fig2,'gray');
image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],preim/2,'CDataMapping','scaled');

%colorbar

hold on
q1=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(SCARCE_L_aff(m:n:end,m:n:end)),sin(SCARCE_L_aff(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',2);
q2=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(SCARCE_L_aff(m:n:end,m:n:end)),-sin(SCARCE_L_aff(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',2);


q3=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(SCARCE_L_aff(m:n:end,m:n:end)),sin(SCARCE_L_aff(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1);
q4=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(SCARCE_L_aff(m:n:end,m:n:end)),-sin(SCARCE_L_aff(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1);

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

%%%
% % % %
%%%


Fig3 = figure(3)
colormap(Fig2,'gray');
% image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],preim/2,'CDataMapping','scaled');

% colorbar

Modified_L = L_SCARCE;
%Modified_L(isnan(M))=NaN;

n = 1;
hold on
q1=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(Modified_L(m:n:end,m:n:end)),sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',2);
q2=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(Modified_L(m:n:end,m:n:end)),-sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',2);


%q3=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),cos(Modified_L(m:n:end,m:n:end)),sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1);
%q4=quiver(X(m:n:end,m:n:end),Y(m:n:end,m:n:end),-cos(Modified_L(m:n:end,m:n:end)),-sin(Modified_L(m:n:end,m:n:end)),'ShowArrowHead','off','LineWidth',1);

hold off
q1.Color='black';
q2.Color='black';
q1.AutoScaleFactor=5;
q2.AutoScaleFactor=5;
q1.Marker = 'o';



%q3.Color='white';
%q4.Color='white';
%q3.AutoScaleFactor=2;
%q4.AutoScaleFactor=2;

axis equal
axis([-xmax,xmax,-ymax,ymax]);
%  title({'Interpolated','Orientation Field'});
% set(gca,'visible','off')

ax = gca;
ax.YDir = 'reverse';
ax.YTick = {};
ax.XTick = {};



Fig4 = figure(4)
colormap(Fig4,'gray');
image([X(1,1),X(1,end)],[Y(1,1),Y(end,1)],pi-SCARCE_L_aff,'CDataMapping','scaled')
% colorbar
axis equal
axis([-xmax,xmax,-ymax,ymax]);
set(gca,'visible','off')              
%title({'Estimated','field'});