function plotGlobalPhyto(sim)
options.sProjection='mollweid';


fig = figure(12);
clf

p = setupNUMmodel(bParallel=true);
sim = plotGlobalPhytoplankton(sim,bPlot=false);
ixTime = find(sim.t>(max(sim.t)-365)); % Just do the last year
Bac_mean = mean(sim.Bbacteria(ixTime,:,:),1)/1000;
Bphyto_mean = mean(sim.Bphyto(ixTime,:,:),1)/1000;
Bphyto_mean(Bphyto_mean<0) = 0.001;
Bzoo_mean = mean(sim.Bzoo(ixTime,:,:),1)/1000;



%% ----------------------------------
%           F I G U R E S (2)
%....................................
% Figure 1: Bacteria, Phytoplankton, 
%           Zooplankton
%------------------------------------
%
cmap=flip(cmocean('deep',10));
ccmap=cmap(2:end,:);      

% cmap2=cmocean('delta',10);
%cmap=flip(cmocean('deep',6));
%cmap3=cmap(2:end,:);
%cmap4=(cmocean('matter',6));
%ccmap2=[cmap3(1:end,:);cmap4(2:end-1,:)];

cmap2=cmocean('balance',11);
% cmap=flip(cmocean('deep',6));
% cmap3=cmap(2:end,:);
% cmap4=(cmocean('matter',6));
% ccmap2=[cmap3(1:end,:);cmap4(2:end-1,:)];
ccmap2=cmap2(2:end-1,:);



x0=0; 
y0=0;
width=16; %figure width in cm
heightf=8; %figure height in cm
set(fig,'Renderer','Painters','Units','centimeters',...
'Position',[x0 y0 width heightf],...
'PaperPositionMode','auto','Name','Functional groups');

clf
set(gcf,'color','w');
set(groot,'defaultAxesFontSize',10)
tiledlayout(1,3,'TileSpacing','compact','padding','tight')

%%
t1=nexttile(1);
cbar=panelGlobal(sim.x, sim.y,log10(Bac_mean),[-1 2]  , sTitle="a. Bacteria", sUnits="mg C/m^2", sProjection=options.sProjection);
cbar.Visible='off';
        % caxis([0,3000])
        colormap(t1,ccmap)
        cbar = colorbar('horizontal');
        cbar.Visible='off';
        set(gca,'YTickLabel',[]);
        set(gca,'XTickLabel',[]);
%
t2=nexttile(2);
cbar=panelGlobal(sim.x, sim.y,  log10(Bphyto_mean),[-1 2] ,sTitle="b. Phytoplankton", sUnits="mg C/m^2", sProjection=options.sProjection);
cbar.Visible='off';
        % caxis([0,3000])
        colormap(t2,ccmap)
        cbar = colorbar('horizontal');
        cbar.Visible='off';
        set(gca,'YTickLabel',[]);
        set(gca,'XTickLabel',[]);
%
t3=nexttile(3);
cbar=panelGlobal(sim.x, sim.y,  log10(Bzoo_mean),[-1 2], sTitle="c. Zooplankton", sUnits="mg C/m^2", sProjection=options.sProjection);
cbar.Label.String = '(mg C m^{-2})';
cbar.Visible='off';
% caxis([0,3000])
colormap(t3,ccmap)
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(colorbar,'visible','off')
cbar=colorbar;
ylabel(cbar,'g C m^{-2}','FontSize',10)
cbar.Ticks=[-2 0 2];
cbar.TickLabels={'10^{-2}','10^0','10^2'};

%% --------------------------------------
%           Figure 2: Group ratios
% ---------------------------------------
fig=figure(13);

[Bactive, Bpassive] = plotGlobalCopepods(sim, bPlot = false);

set(fig,'Renderer','Painters','Units','centimeters',...
'Position',[x0 y0 8 8],...
'PaperPositionMode','auto','Name','Group ratios');

clf
%tiledlayout(1,2,'TileSpacing','compact','padding','tight')

% t5=nexttile(1);
% cbar=panelGlobal(sim.x, sim.y, mean(sim.Diatomratio(ixTime,:,:),1), sTitle="a. Diatom ratio", sUnits="", sProjection=options.sProjection);
%         cbar.Visible='off';
%         clim([0 1])
%         colormap(t5,ccmap2)
%         cbar=colorbar('horizontal');
%         cbar.Visible='off';
%         set(gca,'YTickLabel',[]);
%         set(gca,'XTickLabel',[]);
%         % cbar=colorbar('horizontal');
%         % set(gcf,'color','w');
%         % post5=t5.Position(2);
        

%  t6=nexttile();
% cbar=panelGlobal(sim.x, sim.y, mean(sim.Diatomratio(ixTime,:,:),1), sTitle="a. Diatom:phytoplankton ratio", sUnits="", sProjection=options.sProjection);
%         cbar.Visible='off';
%         clim([0 1])
%         colormap(t6,ccmap2)
%         cbar=colorbar('horizontal');
%         cbar.Visible='off';
%         set(gca,'YTickLabel',[]);
%         set(gca,'XTickLabel',[]);
% 
% t7=nexttile();
cbar=panelGlobal(sim.x, sim.y, Bactive./(Bactive+Bpassive), sTitle="b. Active:total copepod ratio", sUnits="", sProjection=options.sProjection);
        cbar.Visible='off';
        clim([0 1])
        colormap(gca,ccmap2);
        set(gca,'YTickLabel',[]);
        set(gca,'XTickLabel',[]);
        cbar=colorbar;
        set(gcf,'color','w');
        ylabel(cbar,'(g C m^{-2})','FontSize',10)
        cbar.Ticks=[.2 .4  .6 .8 1];
        % cbar.TickLabels={'10^{-2}','10^0','10^2'};
        ylabel(cbar,'[-]','FontSize',10)
