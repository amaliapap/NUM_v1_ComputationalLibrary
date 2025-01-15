function function_plot_maps_sat(P,lat_sat, lon_sat, cclims, ccmap,p)

    ax = axesm ( 'Origin',  [0 -90 0], 'MapProjection','pcarree', 'Frame', 'on',...
            'ScaleFactor', 1, 'labelrotation', 'off', 'FLineWidth', 2);    
    ax.XColor = 'white';
    ax.YColor = 'white';
    axis tight manual
%     surfacem(lat_sat,lon_sat,P','LineStyle','none');
%     contourfm(lat_sat,lon_sat,P','LineStyle','none','LineWidth',0.01);
    [~,hh]=contourfm(lat_sat,lon_sat,P',linspace(cclims(1),cclims(2),15),'LineWidth',0.01);%,'edgecolor','none','LineColor','none','LineStyle','none');
    clim([cclims(1) cclims(2)])
    if nargin==6
        colormap(p,ccmap);
    else
        colormap(ccmap);
    end
    len=(length(hh.Children)-1)/2;
        for id=1:len
            ab=hh.Children(id);
            abp=hh.Children(len+id);
            ab.Color=abp.FaceColor;
        end

    clearvars ab abp cc hh
%     shading flat
    geoshow('landareas.shp', 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [0.2 0.2 0.2],'LineWidth',0.01);
    framem('FlineWidth',0.7,'FEdgeColor','k')
    set(gcf,'color','w');
end