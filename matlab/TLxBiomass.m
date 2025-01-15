nexttile

% set(gca, "XScale", 'log')

idxU=ixG(1):ixD(end);
idxCP=ixPC(1):ixPC(end);
idxCA=ixAC(1):ixAC(end);

cmap  = flip(cmocean('curl',50));
cmap=brewermap(15,'PRGn');

% colormap(brewermap([],'RdYlGn'))
ccmap = cmap(2:end-2,:); 
cc=1;
mini=min(log10(totsizevec(predsort_idx))*12);
size_to_use = abs(mini)+1 + log10(totsizevec(predsort_idx))*12;
bnorm = 100;
scatter(TL(predsort_idx), biomvec(predsort_idx), size_to_use((predsort_idx)), ...
    'filled', 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k');
%color showing size...
h1=scatter(TL(predsort_idx(ixG)),biomvec(predsort_idx(ixG)),size_to_use(ixG)*cc,ratio(ixG),...
    'filled','markeredgecolor','k');
% colororder(ccmap)     Htotsizevec pool??
% alpha(.7)
colorbar
colormap(ccmap)
clim([0 1])
hold on
h2=scatter(TL(predsort_idx(ixD)),biomvec(predsort_idx(ixD)),size_to_use(ixD)*cc,...
    'filled','markerfacecolor','g','markeredgecolor','k');
h3=scatter(TL(predsort_idx(idxCP)),biomvec(predsort_idx(idxCP)),size_to_use(idxCP)*cc,...
    'filled','markerfacecolor','c','markeredgecolor','k');
h4=scatter(TL(predsort_idx(idxCA)),biomvec(predsort_idx(idxCA)),size_to_use(idxCA)*cc,...
    'filled','markerfacecolor',c_cp,'markeredgecolor','k');


set(gca, 'yscale','log')
ylim([1e-2, 1e3])
xlim([.5, 4])
xlabel('Trophic level')
ylabel('Biomass')

% xticks(logspace(-7, 5, 5));
% axis tight
grid on
set(gcf, 'color', 'w');