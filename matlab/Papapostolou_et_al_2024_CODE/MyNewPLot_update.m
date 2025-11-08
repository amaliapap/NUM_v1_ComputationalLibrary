function [simWC,simC] = MyNewPLot_update(sim,lat,lon)

% color palette for groups
newPalette={[21, 16, 240]/256,[0, 163, 136]/256,[240, 154, 15]/256,[240, 154, 15]/256,...
    [219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[116, 71, 145]/256};
cmap=flip(cmocean('deep',100));
ccmap=cmap(2:end,:);
ylimSpectrum = [0.01 50];

x0=0;
y0=0;
height=15; %figure height in cm
width=16;

fig=figure(14);
set(fig,'Renderer','Painters','Units','centimeters',...
    'Position',[x0 y0 width height],...
    'PaperPositionMode','auto','Name','Watercolumn and spectra');

clf
set(gcf,'color','w');
set(groot,'defaultAxesFontSize',12)
tiledlayout(3,5,'TileSpacing','tight','Padding','compact')
t1=nexttile([1 2]);
sim.p.colGroup=newPalette;
idx = calcGlobalWatercolumn(lat,lon,sim);
plotWC(squeeze(sim.B(:,idx.x, idx.y, idx.z,:)),sim,sim.z(idx.z));
colormap(ccmap);
set(colorbar,'visible','off')
xlabel('')
set(gca,'XTickLabel',{''})

maxDepth=max(sim.z(idx.z));
axis square
axis tight
ylim([-300 0])
alabel=plotlabel('a',false);
% alabel.Position(2)=1.13;

%
%   Tile spectrum
%.....................

t2=nexttile([1 3]);
box on
iDepth=1; iTime=3400;
set(gca,'XTickLabel','');
plotPanelSpectrum(sim,iTime,iDepth,lat,lon);
xlabel('')
ylim(ylimSpectrum)
legend('')
plotlabel('b',false);
text(5000, .8,"Global simulation", 'Rotation',-90,'color',[0,0,0],'HorizontalAlignment','center','FontWeight','bold')

%% -------------------------
%  Watercolumn simulation
%---------------------------
%
p = setupNUMmodel();
p = parametersWatercolumn(p,2);
p.tEnd = 10*365;
simWC = simulateWatercolumn(p, lat,lon);
simWC.p.colGroup=newPalette;

%% -------------------------------
%  Figure (c.tile): Watercolumn:
%---------------------------------
t3=nexttile([1 2]);

plotWC(simWC.B, simWC, simWC.z);
axis square
cbar=colorbar;
colormap(ccmap);
cbar.Location="south";
cbar.Position=[0.102258950225578,0.297015610371739,0.206948212633974,0.026446280991736];
ylabel(cbar, '\mug C l^{-1}','FontSize',10,'Color',[1,1,1],FontWeight='bold')
cbar.Label.Position=[0.9,1.2,0];
cbar.TickLabels={'10^{-2}','10^0','10^2'};
plotlabel('c',false);

%% ------------------------------------
% Figure(d.tile): WC spectrum at iDeph
%--------------------------------------
%
t4=nexttile([1 3]);
% cd(path_to_NUMmodel)
box on
s = simWC;
s.t = 1;
s.B = mean(squeeze(s.B(:,iDepth,:)),1);

set(gca,'XTickLabel','');
% xlabel('')
legend('')
plotPanelSpectrum(simWC,iTime,iDepth,lat,lon);
ylim(ylimSpectrum)
xlabel('')
legend('')
plotlabel('d',false);
text(5000, .8,"Watercolumn simulation", 'Rotation',-90,'color',[0,0,0],'HorizontalAlignment','center','FontWeight','bold')


%% --------------------------
%  Chemostat simulation
%----------------------------
p = setupNUMmodel(bParallel=true);
p = parametersChemostat(p,lat_lon=[lat,lon]);
p.tEnd = 10*365;
simC = simulateChemostat(p, bUnicellularloss=false);
simC.p.colGroup=newPalette;
%% ----------------------------------
%  Figure(e.tile): Chemostat spectrum
%------------------------------------
t5=nexttile([1 2]);
t6=nexttile([1 3]);

box on
s = simC;
s.t = 1;
s.B = mean(s.B,1);
plotPanelSpectrum(simC,iTime,1,lat,lon)
ylim(ylimSpectrum)
xlabel('Mass (\mug C)')
plotlabel('e',false);
text(5000, .8,"Chemostat simulation", 'Rotation',-90,'color',[0,0,0],'HorizontalAlignment','center','FontWeight','bold')


ax=gca;
ax.XTick=[10^-8 10^-6 10^-4 10^-2 1 100];
%
hleg=findobj(gcf,'Type','Legend');
hleg(1).NumColumns=1;
hleg(1).Position=[0.04,0.05,0.34,0.2];
hleg(1).ItemTokenSize(1)=15;
cbar.Position(2)=.3;
cbar.Position(1)=.09;
cbar.Position(4)=.03;
cbar.Position(3)=.22;

delete(t5);



    function plotWC(B,sim,z)
        ylimit = [-300 0];
        xlimit = [sim.t(end)-365 sim.t(end)];

        z = [0; z];

        B = squeeze(double(sum(B,3))); % summing all plankton groups
        B(:,2:length(z)) = B; %because now length(z)=length(z)+1
        % B(:,1) = B(:,1);

        B(B < 0.01) = 0.01; % Set low biomasses to the lower limit to avoid white space in plot
        % contourf(sim.t,-z,log10(B'),[linspace(-2,3,10)],'LineStyle','none')

        contourf(sim.t,-z,log10(B'),'LineStyle','none')
        ylabel('Depth (m)')
        %set(gca,'ColorScale','log')
        %shading interp
        axis tight
        colorbar
        %caxis([0.1 100])
        colorbar('ticks',-2:3,'limits',[-2 3])

        ylim(ylimit)
        xlim(xlimit)
        clim([-2,3])
        %xlabel('Time (days)')

        set(gca,'XTick',1:30:10*365,'XTickLabel',{'Jan','','Mar','','Maj','','Jul','','Sep','','Nov',''})
    end

end