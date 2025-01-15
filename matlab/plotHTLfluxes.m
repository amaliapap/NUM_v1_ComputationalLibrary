[~,idx]=find(abs(sim.y)<60);
pn=squeeze(mean(sim.ProdNet,1));
ph=squeeze(mean(sim.ProdHTL,1));
mte=pn./ph;
%%
[lon_interpW,lat_interpW]=meshgrid(sim.x,sim.y);

lon=lon_interpW';
lat=lat_interpW';
%%
pnpp=pn(:);
phtl=ph(:);
lat_vec=lat(:);
mte_vec=mte(:);

%% ----------------------------------- 
%     Figure: MTE correlations 
%-------------------------------------
cmap=flip(cmocean('matter',80));
ccmap=cmap(2:end,:);   

width=16; %figure width in cm
heightf=14; %figure height in cm
x0=0;
y0=0;

figure_number = 2;           % Desired figure number
fig = figure(figure_number); % Create the figure with the specified number
set(fig, 'Renderer','Painters','Units','centimeters',...
    'Position',[x0 y0 width heightf],...
    'PaperPositionMode','auto','Name','Global & Zonal functions');
clf
set(gcf,'color','w');
set(groot,'defaultAxesFontSize',10)
tiledlayout(2,2,'TileSpacing','compact','padding','compact')

% same for mHTL, mNPP, lHTL
nexttile
scatter(pnpp,mte_vec,5,lat_vec,"filled")
xlabel('npp')
ylabel('MTE')
cbar=colorbar;
ylabel(cbar,'Latitude')
corval=corr([pnpp,mte_vec],'Rows','complete','type','Spearman');
text(0.72,0.95,num2str(corval(1,2),'%.2f'),'Units','normalized','fontsize',8)
cbar=colorbar;
ylabel(cbar,'Latitude')
set(gca,'XScale','log','YScale','log')

nexttile
scatter(mNPP_norm,mte_vec,5,lat_vec,"filled")
xlabel('mnpp_{norm}')
corval=corr([mNPP_norm,mte_vec],'Rows','complete','type','Spearman');
text(0.72,0.95,num2str(corval(1,2),'%.2f'),'Units','normalized','fontsize',8)
set(gca,'XScale','log','YScale','log')

nexttile
scatter(m_htl,mte_vec,5,lat_vec,"filled")
xlabel('mass_{HTL}')
corval=corr([m_htl,mte_vec],'Rows','complete','type','Spearman');
text(0.72,0.95,num2str(corval(1,2),'%.2f'),'Units','normalized','fontsize',8)
set(gca,'XScale','log','YScale','log')

nexttile
scatter(lambda_htl,mte_vec,5,lat_vec,"filled")
xlabel('TL_{HTL}')
corval=corr([lambda_htl,mte_vec],'Rows','complete','type','Spearman');
text(0.72,0.95,num2str(corval(1,2),'%.2f'),'Units','normalized','fontsize',8)
set(gca,'XScale','log','YScale','log')
% colormap(ccmap)

%%
