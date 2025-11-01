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

width=8; %figure width in cm
heightf=14; %figure height in cm
set(gcf,'Renderer','Painters','Units','centimeters',...
'Position',[0 0 width heightf],...
'PaperPositionMode','auto','Name','Functional groups');
% 
% % % 1.000000040918479e+35
% % data_Recenter(data_Recenter==1.000000040918479e+35)=NaN;
% x0=0; %positions (no need to change)
% y0=0;
% width=15; %figure width in cm
% heightf=6; %figure height in cm
% fig=figure(10);
% set(fig,'Renderer','Painters','Units','centimeters',...
%     'Position',[x0 y0 width heightf],...
%     'PaperPositionMode','auto','Name','Meso-copepods');

clf
set(gcf,'color','w');
tiledlayout(3,1,'TileSpacing','compact','padding','compact')
nexttile(1)
cbar=panelGlobal(sim.x, sim.y,log10(mean(Bmeso_intTop170,1)),linspace(-3,1,20)  , sTitle="a) Macrozooplankton model", sUnits="log_{10}(gC/m^2)", sProjection=options.sProjection);
%cbar.Label.String = '(log_{10}(g C  m^{-2}))';
%cbar.Visible='off';
colormap(ccmap)
%set(colorbar,'visible','off')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
%h = colorbar;
%h.Ticks=[-2 0 2];
%h.TickLabels={'10^{-2}','10^0','10^2'};
%ylabel(h,'g C m^{-2}','FontSize',10)
%h.Position(1)=.9;
%h.Label.Position(1)=2.2;


vContourLevels=[-3 1];
colorLand = "#f5eef8";

% Adjust to global plot (close gap at lat 0)
if showData
    lon_wrapped=wrapTo360(lon);
    z = log10(mesoZPannualTop150int_Recenter/1000); %convert to gC/m2

    sTitle='b. Macrozooplankton data ';
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

    cbar = colorbar('eastoutside', 'FontSize',10);
    cbar.Label.String  = 'log_{10}(g C m^{-2})';


    %cbar = colorbar('eastoutside', 'FontSize',14);
    %cbar.Label.String  = ' log_{10}(g C m^{-2})';
    %cbar.FontSize = 10;
    %box off
    title(sTitle,'fontweight','normal','FontSize',10)
    caxis(vContourLevels([1,end]))
    %cbar.Visible='off';

    tile = nexttile(3);
    obs = zeros(1,sum(mesoZPannualTop150int_Recenter(:)>0));
    pred = obs;
    latitude = obs;
    index = 1;
    for i = 1:size(mesoZPannualTop150int_Recenter,1)
        for j = 1:size(mesoZPannualTop150int_Recenter,2)
            if mesoZPannualTop150int_Recenter(i,j) > 0
                % find corresponding NUM model value:
                dist=(sim.x*ones(1,length(sim.y))-x(i)).^2 + ((sim.y*ones(1,length(sim.x)))'-y(j)).^2;
                shortest = min(dist(:));
                ix = find(dist==shortest);
                ix = ix(1);
                idx.x = mod(ix, length(sim.x))+1;
                idx.y = floor(ix/length(sim.x))+1;

                obs(index) = mesoZPannualTop150int_Recenter(i,j)/1000;
                pred(index) = mean(Bmeso_intTop170(:,idx.x, idx.y),1);
                latitude(index) = y(j);
                index = index + 1;
                %loglog(mesoZPannualTop150int_Recenter(i,j)/1000, mean(Bmeso_intTop170(:,idx.x, idx.y),1),'o','MarkerSize',1,'MarkerEdgeColor','b','MarkerFaceColor','b')
                %hold on
            end
        end
    end

    cmap=flip(cmocean('deep',100));
    ccmap=cmap(2:end,:);
    colormap(tile,ccmap)
    colors = abs(ones(length(sim.x),1)*sim.y');

    scatter(obs,pred,8,floor(latitude+90)/2,'filled')

    h = colorbar;
    h.Label.String='Latitude';
    xlabel('Observed (gC/m^2)')
    ylabel('Simulated (gC/m^2)')
    set(gca,'xscale','log','yscale','log')
    xlim([1e-03 10])
    ylim([1e-3 10])
    hold on
    plot([1e-3,100],[1e-3,100],'k-')
    plotlabel('c');
    colormap(tile,ccmap)



end

