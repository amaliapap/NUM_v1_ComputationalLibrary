latitudes=[60,-5,0];
longitudes=[-15,5,-170];

site=2;

lat =latitudes(site);
lon = longitudes(site);
%%
% Global simulation
%
load('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\simGlobal10yAvg.mat')
p=setupNUMmodel(true);
% p = setupNUMmodel([0.5 2], [10 333 1000], 20,7,1, bParallel=true);
p = parametersGlobal(p);
sim=ans;
sim.p=p;

% woa NO3 and SiO4 observations
load('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\woa\no3_woa_3D_interp.mat')
load('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\woa\si_woa_3D_interp.mat')

% Convertion from umol/kg to ug/l
no3_woa_surf=14*squeeze(no3_woa_3D_interp(:,:,1));% ugN/l
si_woa_surf=28.09*squeeze(si_woa_3D_interp(:,:,1));% ugN/l
%%
simWCseason = calcNPP(sim,lat,lon);
NPP=simWCseason.ProdNet;
load('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\NPP extracted\NPP_extracted60_15W.mat')

%%
finalYear=120-11:120;

idx = calcGlobalWatercolumn(lat,lon,sim);
% ix = (sim.p.ixStart(iGroup):sim.p.ixEnd(iGroup)) -sim.p.idxB+1;
B = sim.B(:,idx.x, idx.y, idx.z,:);
Bphyto=sim.Bphyto(finalYear,idx.x, idx.y);

iGroup=1;
ixG = (sim.p.ixStart(iGroup):sim.p.ixEnd(iGroup)) -sim.p.idxB+1;
iGroup=2;
ixD = (sim.p.ixStart(iGroup):sim.p.ixEnd(iGroup)) -sim.p.idxB+1;

Bg=squeeze(sum(sim.B(finalYear,idx.x, idx.y, 1,ixG),5));
Bg_ix=squeeze(sim.B(finalYear,idx.x, idx.y, 1,ixG));

Bd=squeeze(sum(sim.B(finalYear,idx.x, idx.y, 1,ixD),5));
Bd_ix=squeeze(sim.B(finalYear,idx.x, idx.y, 1,ixD));

rGroups=calcRadiusGroups(sim.p); % for copepods it returns length/2
r_picoG=find(rGroups(ixG)<=2/2);% radius in um divided by two to get the radius between (20-200um)/2
r_nanoG=find(rGroups(ixG)>2/2 & rGroups(ixD)<=20/2);
r_microG=find(rGroups(ixG)>20/2 & rGroups(ixD)<=200/2);
Gpico= squeeze(sum(Bg_ix(:,r_picoG),2));
Gnano= squeeze(sum(Bg_ix(:,r_nanoG),2));
Gmicro= squeeze(sum(Bg_ix(:,r_microG),2));

r_picoD=find(rGroups(ixD)<=2/2);% radius in um divided by two to get the radius between (20-200um)/2
r_nanoD=find(rGroups(ixD)>2/2 & rGroups(ixD)<=20/2);
r_microD=find(rGroups(ixD)>20/2 & rGroups(ixD)<=200/2);
Dpico= squeeze(sum(Bd_ix(:,r_picoD),2));
Dnano= squeeze(sum(Bd_ix(:,r_nanoD),2));
Dmicro= squeeze(sum(Bd_ix(:,r_microD),2));

% copepods
[~,idxAC]=find(sim.p.typeGroups==11); % Find index of Active Copepods
ixAC = (sim.p.ixStart(idxAC(1)):sim.p.ixEnd(idxAC(end))) -sim.p.idxB+1;

r_microC=find(rGroups(ixAC)>=20/2 & rGroups(ixAC)<=200/2);% radius in um divided by two to get the radius between (20-200um)/2
r_mesoC=find(rGroups(ixAC)>200/2 & rGroups(ixAC)<=2e4/2);

B_ac_micro=squeeze(sum(sim.B(finalYear,idx.x, idx.y, 1,r_microC),5));
B_ac_meso=squeeze(sum(sim.B(finalYear,idx.x, idx.y, 1,r_mesoC),5));

% passive copepods
[~, idxPC ]=find(sim.p.typeGroups==10); % Find index of Active Copepods
ixPC  = (sim.p.ixStart( idxPC (1)):sim.p.ixEnd( idxPC (end))) -sim.p.idxB+1;

r_microCp=find(rGroups(ixPC )>=20/2 & rGroups(ixPC )<=200/2);% radius in um divided by two to get the radius between (20-200um)/2
r_mesoCp=find(rGroups(ixPC )>200/2 & rGroups(ixPC )<=2e4/2);

B_pc_micro=squeeze(sum(sim.B(finalYear,idx.x, idx.y, 1,r_microCp),5));
B_pc_meso=squeeze(sum(sim.B(finalYear,idx.x, idx.y, 1,r_mesoCp),5));
%%
% Figure:
%
cmap=flip(cmocean('deep',100));
ccmap=cmap(2:end,:); 

%-----------------------
% figure specifications
%-----------------------
x0=0; %positions (no need to change)
y0=0;
width=16; %figure width in cm
height=16; %figure height in cm

fig=figure('Renderer','Painters','Units','centimeters',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');

clf
set(gcf,'color','w');
set(groot,'defaultAxesFontSize',10)
tiledlayout(5,3,'TileSpacing','tight','Padding','loose','TileIndexing','columnmajor')
dayFYr=9*365+15; % 15th Jan final year
%
% column #1
%
t1=nexttile(1);
plotWC(squeeze(sim.B(:,idx.x, idx.y, idx.z,:)),sim,sim.z(idx.z));
colormap(ccmap);
ax=gca;
ax.XTick=[dayFYr+30*(1-1) dayFYr+30*(3-1) dayFYr+30*(5-1) dayFYr+30*(7-1)...
    dayFYr+30*(9-1) dayFYr+30*(11-1)]; % ~15th of each odd month
% ax.XTickLabel={'Jan', 'Mar', 'May', 'Jul', 'Oct', 'Nov'}';
% XTickLabel={num2str(mod(3300,365)),num2str(mod(3400,365)),num2str(mod(3500,365)),num2str(mod(3600,365))}';
set(gca,'XTickLabel',[]);
xlabel('')
% set(colorbar,'visible','off')

cmapg=(brewermap(3,'GnBu'));
cmapd=(brewermap(3,'PuRd'));
cmapN=brewermap(11,'BrBG');
cmapp=cmapN(7:end,:);
  

t2=nexttile(2);
lgp=fillbetweenlines(finalYear, 0*Gpico, Gpico, cmapp(1,:));
hold on
lgn=fillbetweenlines(finalYear, Gpico, Gpico+Gnano, cmapp(2,:));
lgm=fillbetweenlines(finalYear, Gpico+Gnano, Gpico+Gnano+Gmicro, cmapp(3,:));
ldp=fillbetweenlines(finalYear, Gpico+Gnano+Gmicro, Gpico+Gnano+Gmicro+Dpico, cmapd(1,:));
ldn=fillbetweenlines(finalYear, Gpico+Gnano+Gmicro+Dpico, Gpico+Gnano+Gmicro+Dpico+Dnano, cmapd(2,:));
ldm=fillbetweenlines(finalYear, Gpico+Gnano+Gmicro+Dpico+Dnano, Gpico+Gnano+Gmicro+Dpico+Dnano+Dmicro, cmapd(3,:));

ylabel('Unicellular (\mug_Cl^{-1})')
yyaxis right
% plot(finalYear,squeeze(sim.N(finalYear,idx.x, idx.y, 1)),'k:','linewidth',1.5)
lbph=plot(finalYear,Bphyto,'k:','linewidth',1.5,Color=[0.45 0.45 0.45]); % integrated

ylabel('B_{phyto} (mg_Cm^{-2})',Color=[0.45 0.45 0.45])
% lg=legend('Generalists pico','nano','micro','Diatoms pico','nano','micro');
% lg.Location='southoutside';
% lg.NumColumns=3;
ax=gca;
ax.XTick=109:2:120;
% ax.XTickLabel={'Jan', 'Mar', 'May', 'Jul', 'Oct', 'Nov'}';
set(gca,'XTickLabel',[]);
lbph.Marker="o";
lbph.MarkerSize=1.7;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = [0.45 0.45 0.45];
  NPP_extracted_site1=NPP_extracted;


t3=nexttile(3);
cnppNUM=plot(finalYear,NPP(finalYear),"Color",cmapp(3,:),'linewidth',1.5, 'linestyle','-');
hold on
plot(finalYear,NPP_extracted(1,:),'k:','linewidth',1.5,"Color",[.5 .5 .5])
plot(finalYear,NPP_extracted(2,:),'--','linewidth',1.5,"Color",[.5 .5 .5])
plot(finalYear,NPP_extracted_site1(3,:),"Color",[0 0 0], 'linestyle','-.','linewidth',1.5)
cnppNUM.Marker="o";
cnppNUM.MarkerSize=1.7;


lg=legend('NUM','Eppley model', 'Standard VGPM', 'CAFE');
lg.NumColumns=2;
ax=gca;
ax.XTick=109:2:120;
% ax.XTickLabel={'Jan', 'Mar', 'May', 'Jul', 'Oct', 'Nov'}';
% xlabel('Time (month)')
ylabel('NPP (mg_Cm^{-2}day^{-1})')
set(gca,'XTickLabel',[]);

  

t4=nexttile(4);

microC=fillbetweenlines(finalYear, 0*B_ac_micro, B_ac_micro, cmapp(1,:));
hold on
mesoC=fillbetweenlines(finalYear, B_ac_micro,B_ac_micro + B_ac_meso, cmapp(3,:));
microCp=fillbetweenlines(finalYear, B_ac_micro + B_ac_meso,B_ac_micro + B_ac_meso + B_pc_micro, cmapd(1,:));
mesoCp=fillbetweenlines(finalYear, B_ac_micro + B_ac_meso + B_pc_micro,B_ac_micro + B_ac_meso + B_pc_micro + B_pc_meso, cmapd(3,:));

ax=gca;
ax.XTick=109:2:120;
% ax.XTickLabel={'Jan', 'Mar', 'May', 'Jul', 'Oct', 'Nov'}';
% xlabel('Time (month)')
ylabel('Copepods (\mug_Cl^{-1})')
  % green active - pink passive
set(gca,'XTickLabel',[]);

t5=nexttile(5);

plot(finalYear,squeeze(sim.N(finalYear,idx.x, idx.y, 1)),'k:','linewidth',1.5)
hold on
plot(finalYear,squeeze(sim.Si(finalYear,idx.x, idx.y, 1)),'--','linewidth',1.5)
plot(finalYear,squeeze(sim.DOC(finalYear,idx.x, idx.y, 1)),'r','linewidth',1.5)
ax=gca;
ax.XTick=109:2:120;
ax.XTickLabel={'Jan', 'Mar', 'May', 'Jul', 'Oct', 'Nov'}';
xlabel('Time (month)')
ylabel('Nutrients (\mug_Xl^{-1})')
legend('N','Si','DOC','box','off')
%% column 2
load('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\NPP extracted\NPP_extracted_05S05E.mat')
site=2;
lat =latitudes(site);
lon = longitudes(site);
DiagnosticTiles(sim,lat,lon,NPP_extracted,site)

%% column 3
load('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\NPP extracted\NPP_extracted_0_172W.mat')
site=3;
lat =latitudes(site);
lon = longitudes(site);
DiagnosticTiles(sim,lat,lon,NPP_extracted,site)

%% -------------------------------- LEGEND ---------------------------------
leg=legend([lgp,lgn,lgm,ldp,ldn,ldm,microC,mesoC],...
    {'pico_G','nano_G','micro_G','pico_D','nano_D','micro_D','micro_C','meso_C'}, ...
    'box','off');
leg.FontSize=8;
leg.NumColumns=2;
leg.Location='layout';