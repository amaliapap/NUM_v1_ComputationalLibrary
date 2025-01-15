% -------------------------
%       NICE PLOT
% -----------------------
% Plots data points where:
% x-axis: Trophic level
% y-axis: Biomass
% c-axis: log(size)
figure(2)
clf

idxU=ixG(1):ixD(end);
idxCP=ixPC(1):ixPC(end);
idxCA=ixAC(1):ixAC(end);

cmap  = flip(cmocean('deep',10));
ccmap = cmap(2:end-2,:); 
cc=1;
mini=min(log10(totsizevec(predsort_idx))*12);
% size_to_use = abs(mini)+1 + log10(totsizevec(predsort_idx))*12;
% size_to_use = log10(totsizevec(predsort_idx));
size_to_use = log10(totsizevec);
scale_to_use=(TL(predsort_idx));
markerColorEdge=cmap(4,:);

    scatter(TL(predsort_idx), biomvec(predsort_idx),[] ,size_to_use((predsort_idx)), ...
       'filled', 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k');
    %color showing size...
    h1=scatter(TL((ixG)),biomvec((ixG)),[],size_to_use(ixG)*cc,...
       'filled','DisplayName','Generalists');
    hold on
    h2=scatter(TL((ixD)),biomvec((ixD)),100,size_to_use(ixD)*cc,...
        'filled','markeredgecolor',markerColorEdge,'DisplayName','Diatoms');
    h3=scatter(TL((idxCP)),biomvec((idxCP)),[],size_to_use(idxCP)*cc,...
        'filled','markeredgecolor',markerColorEdge,'DisplayName','Passive copepods');
    h4=scatter(TL((idxCA)),biomvec((idxCA)),120,size_to_use(idxCA)*cc,...
        'filled','markeredgecolor',markerColorEdge,'DisplayName','Active copepods');
h2.Marker='square';
h3.Marker='d';
h4.Marker='d';
cbar=colorbar;
colormap(ccmap)
% legend show

set(gca, 'yscale','log')
ylim([1e-2, 1e3])
% xlim([.5, 5])
xlabel('Trophic level')
ylabel('Biomass')
ylabel(cbar,'Size [log_{10}(\mugC)]','FontSize',10)
legend boxoff
grid on
set(gcf, 'color', 'w');