%sDataset = '~/Downloads/cmems_obs-oc_glo_bgc-plankton_my_l4-multi-4km_P1M_CHL-DIATO_179.98W-179.98E_89.98S-89.98N_1997-09-01-2024-01-01.nc';
%nc = ncinfo(sDataset);

%time = ncread(sDataset,'time');
%lat = ncread(sDataset,'latitude');
%lon = ncread(sDataset,'longitude');

%%
% Load and process data:
%
%ratiomean = zeros(8640,4320);
%count = ratiomean;
%iYears = 0;
%for day = 98*365:365:123*365
%     iStart = find(time>day,1)
%     chl = ncread(sDataset,'CHL',[1,1,iStart],[ inf,inf,12]);%[ inf,inf,12]);
%     diatoms = ncread(sDataset,'DIATO',[1,1,iStart],[ inf,inf,12]);
%     tmp = mean(diatoms./chl,3,'omitnan');
%     tmp(isnan(tmp)) = 0;
%     count = count + ~isnan(tmp);
%     ratiomean = ratiomean + tmp;
% end
% ratiomean = ratiomean./count;
% save('diatom_chl ratio','ratiomean','lat','lon','-v7.3')
%
% Raw hi-res plot:
%
function plot_diatoms_vs_data(sim)

if exist('../../data/diatom_chl ratio processed.mat')
    load('../../data/diatom_chl ratio processed.mat');
    show_data = true;
    %clf
    %surface(lon,lat,ratiomean');
    %shading flat
    %caxis([0 1])
    %colorbar
    %title('Mean surface diatom:total chl')
    %%
    % Interpolate the data:
    %

    %[latI, lonI] = meshgrid(sim.y, sim.x);
    %ratioI = interp2(lon+180,lat,ratiomean',lonI,latI);
else
    show_data = false;
end
%%
% Simulation to compare with:
%
%p = setupNUMmodel(bParallel=true);
%p = parametersGlobal(p);
sim = plotGlobalPhytoplankton(sim, bPlot=false, bOnlySurface=true);
%%
% Plot
%
figure
width=8; %figure width in cm
heightf=14; %figure height in cm
set(gcf,'Renderer','Painters','Units','centimeters',...
'Position',[0 0 width heightf],...
'PaperPositionMode','auto','Name','Functional groups');

cmap=flip(cmocean('deep',100));
ccmap=cmap(2:end,:);      

tiledlayout(3,1,"TileSpacing","tight")
%setFigWidth(8)
%setFigHeight(12)

if show_data
    tile = nexttile
    panelGlobal(sim.x, sim.y, ratioI, [0 1],sProjection='mollweid',sUnits='');
    plotlabel('a',false);
    colormap(tile,ccmap)
end

tile = nexttile;
ixTime = sim.t>(sim.t(end)-365);
meanDiatom = mean(sim.Diatomratio(ixTime,:,:),1);
panelGlobal(sim.x, sim.y, meanDiatom,[0 1],sProjection='mollweid',sUnits='');
plotlabel('b',false);
colormap(tile,ccmap)

if show_data
    tile = nexttile
    colors = abs(ones(length(sim.x),1)*sim.y');
    scatter(ratioI(:), meanDiatom(:),8,colors(:),'filled')
    h = colorbar;
    h.Label.String='Latitude';
    xlabel('Observed ratio')
    ylabel('Simulated ratio')
    xlim([0 1])
    ylim([0 1])
    hold on
    plot([0,1],[0,1],'k-')
    plotlabel('c');
    colormap(tile,ccmap)
end

%exportgraphics(gcf,'diatoms_vs_data.pdf')