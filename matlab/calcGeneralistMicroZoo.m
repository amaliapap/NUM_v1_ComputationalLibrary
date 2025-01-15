%
% Make a plot of bacteria, phytoplankton, zooplankton, and the diatom ratio 
% 
% function sim = calcGeneralistMicroZoo(sim, options)
% arguments
%     sim struct;
    options.sProjection = 'mollweid';%'fast'; %projection to use. Defaults to 'fast'. Other projections
% %               requires that the mapping toolbox is installed. 
% %               Good projection is 'eckert4'.
% end
cd('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab')
sLibName = loadNUMmodelLibrary();
ixTime =1:length(sim.t); %find(sim.t>(max(sim.t)-365)); %nTime = length(sim.t(sim.t >= max(sim.t-365))); % Just do the last year
% Get grid volumes:
sim.p.pathGrid='C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\TMs\MITgcm_2.8deg\grid.mat';
load(sim.p.pathGrid,'dv','dz','dx','dy');
ix = ~isnan(sim.N(1,:,:,1)); % Find all relevant grid cells


BzooGens = zeros(length(sim.t), length(sim.x), length(sim.y));

nX = length(sim.x);
nY = length(sim.y);
nZ = length(sim.z);
%
% Extract fields from sim:
%
N = sim.N;
DOC = sim.DOC;
if isfield(sim.p,'idxSi')
    Si = sim.Si;
else
    Si = 0;
end
B = sim.B;
L = sim.L;
T = sim.T;
p = sim.p;
%
% find indices of generalists:
%
ixGeneralists = p.typeGroups==1 | p.typeGroups==5;
p=sim.p;

rGroups=calcRadiusGroups(sim.p); % for copepods it returns length/2
ixG = (p.ixStart(ixGeneralists)-p.idxB+1):(p.ixEnd(ixGeneralists)-p.idxB+1);
r_microG=find(rGroups(ixG)>=20/2 & rGroups(ixG)<=200/2);% radius in um divided by two to get the radius between (20-200um)/2

for iTime = ixTime
    for i = 1:nX
        for j = 1:nY
            for k = 1:nZ
                if ~isnan(N(iTime,i,j,k))
                    if isfield(p,'idxSi')
                        u = [squeeze(N(iTime,i,j,k)), ...
                            squeeze(DOC(iTime,i,j,k)), ...
                            squeeze(Si(iTime,i,j,k)), ...
                            squeeze(B(iTime,i,j,k,:))']; % we only include the micro-generalists
                    else
                        u = [squeeze(N(iTime,i,j,k)), ...
                            squeeze(DOC(iTime,i,j,k)), ...
                            squeeze(B(iTime,i,j,k,:))'];
                    end
                    % [~, Bzootmp, ~] = ...
                    %     calcPhytoZoo(p, u, L(iTime,i,j,k), T(iTime,i,j,k), sLibName);
              
                    conv = squeeze(dz(i,j,k));
                    rates = getRates(p, u, L(iTime,i,j,k), T(iTime,i,j,k), sLibName);
                    rates.jLreal( isnan(rates.jLreal) ) = 0;
                    jCarbon = rates.jDOC + rates.jFreal + rates.jLreal + 1e-100;
                    Bg = u(p.idxB:end)';
                    Bzootmp = sum( Bg(r_microG).*rates.jFreal(r_microG)./jCarbon(r_microG) );
                   % this returns micro-generalist zooplankton
                    BzooGens(iTime,i,j) = BzooGens(iTime,i,j) + sum(Bzootmp)*conv;% mgC/m2
                end
            end
        end
    end
end
sim.BzooGens = BzooGens;
%%
BzooGens_mean = squeeze(mean(sim.BzooGens(ixTime,:,:),1))/1000;% g/m2

%% Make plot:
%
cmap=flip(cmocean('deep',100));
ccmap=cmap(2:end,:);      
% ccmap2=[cmap(1:50,:);flip(cmap(51:end,:))];
% for the ratios
cmap2=cmocean('delta',10);
cmap=flip(cmocean('deep',6));
cmap3=cmap(2:end,:);
cmap4=(cmocean('matter',6));
ccmap2=[cmap3(1:end,:);cmap4(2:end-1,:)];

x0=0; %positions (no need to change)
y0=0;
width=15; %figure width in cm
heightf=10; %figure height in cm
fig=figure(10);
set(fig,'Renderer','Painters','Units','centimeters',...
'Position',[x0 y0 width heightf],...
'PaperPositionMode','auto','Name','Copepod ratios-GlobalZonal');

clf
tiledlayout(1,2,'TileSpacing','tight','padding','compact')

t1=nexttile(1);
cbar=panelGlobal(sim.x, sim.y,(BzooGens_mean) ,sTitle="Unicellular micro-zooplankton", sUnits="", sProjection=options.sProjection);
        cbar.Visible='off';
        % clim([1 3])
        colormap(ccmap2);
        set(gca,'YTickLabel',[]);
        set(gca,'XTickLabel',[]);
        set(gcf,'color','w');
        % post6=t6.Position(2);
        % cbar.Position(4)=0.025;
        cbar=colorbar;
        ylabel(cbar, 'g_C m^{-2}','FontSize',10)

