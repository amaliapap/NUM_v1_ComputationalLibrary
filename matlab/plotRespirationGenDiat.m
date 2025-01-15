% p=parametersChemostat(p);
% simC=simulateChemostat(p,100);

%% figure
height=13; %figure height in cm
width=10;
fig=figure('Renderer','Painters','Units','centimeters',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');

clf
set(gcf,'color','w');
set(groot,'defaultAxesFontSize',12)
tiledlayout(2,3,'TileSpacing','compact','Padding','compact')
nexttile([1 2])
iGroup=1; % generalists
panelRespirationA(p,simC.rates,iGroup,true)
nexttile([1 2])
iGroup=2; % diatoms
panelRespirationA(p,simC.rates,iGroup,true)

legend.Location='south';