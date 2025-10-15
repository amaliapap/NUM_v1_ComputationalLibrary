%% Uncomment when run for the first time to load the data
% Compares simulated copepod biomass by NUM to global copepod biomass data
% Global copepod biomass data from Moriarty et al., 2013
% data downloaded from https://doi.pangaea.de/10.1594/PANGAEA.785501
% saved to the folder 'PANGAEA' and processed based on
% import_netcdfPANGAEA.m
%
% INPUT: PANGAEA\Data_mesoZPannualTop150int_Recentered.mat
%        PANGAEA\lat_nc.mat
%        PANGAEA\lon_nc.mat
%
% Need to run PlotMicroMesoCopepods first
% load('dataMesoZP_recentered.mat')
%
function plotMesoZP_NUMxMoriarty_top150int(sim)

Bmeso_intTop170=calcMesoCopepods(sim);

if exist('../../data/Data_mesoZPannualTop150int_Recentered.mat')
    showData = true;
    load('../../data/Data_mesoZPannualTop150int_Recentered.mat')
    load('../../data/lat_nc.mat')
    load('../../data/lon_nc.mat')
else
    showData = false;
end

%
% nc=netcdf('MarEDat20120524Mesozooplankton.nc');
%%
options.sProjection='mollweid';

cmap=flip(cmocean('deep',100));
ccmap=cmap(2:end,:);
% % 1.000000040918479e+35
% data_Recenter(data_Recenter==1.000000040918479e+35)=NaN;
x0=0; %positions (no need to change)
y0=0;
width=15; %figure width in cm
heightf=6; %figure height in cm
fig=figure(10);
set(fig,'Renderer','Painters','Units','centimeters',...
    'Position',[x0 y0 width heightf],...
    'PaperPositionMode','auto','Name','Meso-copepods');

clf
set(gcf,'color','w');
tiledlayout(1,2,'TileSpacing','compact','padding','compact')
nexttile(1)
cbar=panelGlobal(sim.x, sim.y,log10(mean(Bmeso_intTop170,1)),linspace(-2,2,20)  , sTitle="a. Meso-copepods model", sUnits="mg C m^{-3}", sProjection=options.sProjection);
cbar.Label.String = '(log_{10}(g C  m^{-2}))';
cbar.Visible='off';
colormap(ccmap)
set(colorbar,'visible','off')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
h = colorbar;
h.Ticks=[-2 0 2];
h.TickLabels={'10^{-2}','10^0','10^2'};
ylabel(h,'g C m^{-2}','FontSize',10)
h.Position(1)=.9;
h.Label.Position(1)=2.2;


vContourLevels=[-2 2];
colorLand = "#f5eef8";

% Adjust to global plot (close gap at lat 0)
if showData
    lon_wrapped=wrapTo360(lon);
    z = log10(mesoZPannualTop150int_Recenter/1000); %convert to gC/m2

    sTitle='b. Mesozooplankton data ';
    x=lon_wrapped; y=lat;
    z = [z;z(1,:)];
    x = [x-x(1);360];

    % Determine contour level if only min and max are given
    if length(vContourLevels)==2
        vContourLevels = linspace(vContourLevels(1), vContourLevels(2),20);
    end

    z = double(squeeze( min(max(z,vContourLevels(1)),vContourLevels(end))));
    nexttile(2)
    ax = axesm ( 'Origin',  [0 -90 0], 'MapProjection','mollweid', 'Frame', 'on',...
        'ScaleFactor', 1, 'labelrotation', 'off', 'FLineWidth', 2);
    ax.XColor = 'white';
    ax.YColor = 'white';
    axis tight manual
    z(z==-2)=NaN; % make minimum value NaN so it appears white
    contourfm(y,x,z', vContourLevels,'LineStyle','none');
    framem('FlineWidth',0.7,'FEdgeColor','k')
    % Draw the land:
    load coastlines
    h=patchm(coastlat,coastlon, colorLand);
    set(h,'linestyle','-','linewidth',0.01)
    gridm('off'); % Remove grid lines


    cbar = colorbar('eastoutside', 'FontSize',14);
    cbar.Label.String  = ' log_{10}(g C m^{-2})';
    cbar.FontSize = 10;
    box off
    title(sTitle,'fontweight','normal','FontSize',10)
    caxis(vContourLevels([1,end]))
    cbar.Visible='off';
end

