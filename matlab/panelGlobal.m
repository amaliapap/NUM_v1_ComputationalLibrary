%
% Make a panel of a global field given in gridded coordinates.
%
% Input:
%  x,y: x and y coordinates (from sim.x and sim.y)
%  z: field to show (typically from sim)
%  vContourLevels: levels of contours, or just min, max values
% Optional:
%  sTitle: title on panel
%  sProjection: projection to use. Defaults to 'fast'. Other projections 
%               requires that the mapping toolbox is installed. 
%               Good projection is 'eckert4'.
%  sUnits : The unit to show on the colorbar
%
% Out:
%  cbar: the color bar object
%
function cbar = panelGlobal(x,y,z, vContourLevels, options)

arguments
    x,y (:,1);
    z (:,:);
    vContourLevels = double([min(z(:)), max(z(:))]);
    options.sTitle string = '';
    options.sProjection string = 'fast';
    options.sUnits = '\mug C l^{-1}';
end
%
% Check that mapping toolbox is installed
%
if ~strcmp(options.sProjection,'fast')
    v = ver;
    if ~any(strcmp('Mapping Toolbox', {v.Name}))
        error('Fancy projections require that the mapping toolbox is installed.\n');
    end
end

colorLand = "#f5eef8";

% Adjust to global plot (close gap at lat 0)
z = [z;z(1,:)];
x = [x-x(1);360];

% Determine contour level if only min and max are given

if length(vContourLevels)==2
    vContourLevels = linspace(vContourLevels(1), vContourLevels(2),10);
end

z = double(squeeze( min(max(z,vContourLevels(1)),vContourLevels(end)))');

if (strcmp(options.sProjection,'fast'))
    contourf(x,y, z, vContourLevels, 'LineStyle','none');
    shading flat
    axis tight
else
    if exist('axesm') ~= 2
        error('Using projections requires that the mapping toolbox is installed.')
    end

    ax = axesm ( 'Origin',  [0 -90 0], 'MapProjection',options.sProjection, 'Frame', 'on',...
            'ScaleFactor', 1, 'labelrotation', 'off', 'FLineWidth', 2);    
    ax.XColor = 'white';
    ax.YColor = 'white';
  % ax.XColor = get(gcf,'color'); % Remove lines around the figure
  %  ax.YColor = get(gcf,'color');
    axis tight manual
    %plabel('PlabelLocation',20, 'PLabelMeridian', 91)
    % z(z==-2)=NaN;
    contourfm(y,x,z, vContourLevels,'LineStyle','none');
    framem('FlineWidth',0.7,'FEdgeColor','k')
    shading flat
    % Draw the land:
    load coastlines
    h=patchm(coastlat,coastlon, colorLand); 
    set(h,'linestyle','-','linewidth',0.01)
    gridm('off'); % Remove grid lines
end

cbar = colorbar('eastoutside', 'FontSize',14);
cbar.Label.String  = options.sUnits;
cbar.FontSize = 10;
box off
title(options.sTitle,'fontweight','normal','FontSize',10)
caxis(vContourLevels([1,end]))


