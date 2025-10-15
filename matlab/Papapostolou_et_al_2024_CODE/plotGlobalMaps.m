function plotGlobalMaps(sim,lat,lon)

% color palette for groups
newPalette={[21, 16, 240]/256,[0, 163, 136]/256,[240, 154, 15]/256,[240, 154, 15]/256,...
    [219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[116, 71, 145]/256};
%% --------------------------
%     Global simulation
%----------------------------
% p = setupNUMmodel(bParallel=true);
% p = parametersGlobal(sim.p);
% sim.p=p;
cmap=flip(cmocean('deep',100));
ccmap=cmap(2:end,:);
ylimSpectrum = [0.01 50];

% ----------------------------
%   Figure: Global biomasses
%------------------------------
% cd('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\Code for FIGURES')
%
sim.p.colGroup=newPalette;

sProjection='mollweid';
%-----------------------
% figure specifications
%-----------------------
x0=0;
y0=0;
width=8; %figure width in cm
height=15; %figure height in cm

fig=figure(6);
set(fig,'Renderer','Painters','Units','centimeters',...
    'Position',[x0 y0 width height],...
    'PaperPositionMode','auto','Name','Global Biomass');

clf
set(gcf,'color','w');
set(groot,'defaultAxesFontSize',10)
tiledlayout(3,1,'TileSpacing','Compact','Padding','Compact')
%
% Global:
%

% Generalists and diatoms:
for iGroup = 1:2
    nexttile%(1+3*(iGroup-1))
    ix = (sim.p.ixStart(iGroup):sim.p.ixEnd(iGroup)) -sim.p.idxB+1;
    B = calcIntegrateGlobal(sim, sim.B(:,:,:,:,ix), true);
    % Plot the group:
    if iGroup==1
        ttl='a. Generalists';
    else
        ttl='b. Diatoms';
    end
    sTitle.Fontweight = 'normal';
    cbar = panelGlobal(sim.x,sim.y, log10(B),[-1 2], ...
        sTitle = ttl,...
        sProjection=sProjection);
    cbar.Label.String  = 'log_{10} (g C m^{-2})';
    colormap(ccmap);
    set(colorbar,'visible','off')
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);
    sTitle.Units = 'Normalize';
    sTitle.Position(1) =0; % use negative values (ie, -0.1) to move further left ttl.HorizontalAlignment = 'left';
    sTitle.HorizontalAlignment = 'left';
    scatterm(lat,lon,25,'pentagram','filled','markerfacecolor','r','markeredgecolor','r')
end
% Copepods:
nexttile
B = 0*B;
for iGroup = 3:6
    ix = (sim.p.ixStart(iGroup):sim.p.ixEnd(iGroup)) -sim.p.idxB+1;
    B = B + calcIntegrateGlobal(sim, sim.B(:,:,:,:,ix), true);
end
cbar = panelGlobal(sim.x,sim.y, log10(B),[-1 2], ...
    sTitle = 'c. Copepods',sProjection=sProjection);
set(colorbar,'visible','off')
cbar=colorbar('horizontal');
colormap(ccmap);
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
sTitle.Fontweight = 'normal';
sTitle.Units = 'Normalize';
cbar.Ticks=[-1 0 1 2];
cbar.TickLabels={'10^{-1}','10^0','10^1','10^2'};
ylabel(cbar, 'Biomass (g C m^{-2})','FontSize',10)
scatterm(lat,lon,25,'pentagram','filled','markerfacecolor','r','markeredgecolor','r')
