newPalette={[21, 16, 240]/256, [0, 163, 136]/256,...
    [240, 154, 15]/256,[240, 154, 15]/256,... % passive copepods
    [219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256};... % active copepods
    % [116, 71, 145]/256}; % POM
sim.p.colGroup=newPalette;

time=400; %/3500 for July
m =[sim.p.mLower(3:end), sim.p.mLower(end)+sim.p.mDelta(end)];
% [~, iTime] = min(abs(sim.t-time));
[~, iTime] = min(abs(sim.t-time));
 iDepth=1;  
Rates = calcAllRatesAvg(sim,time);
lambda=calcTrophicLevel(sim,Rates);

MassAll=sim.p.m(sim.p.idxB:end);
p=sim.p;
name={};
presence=zeros(1,11);

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
tiledlayout(2,1,'TileSpacing','tight','Padding','loose','TileIndexing','columnmajor')


t1=nexttile(1);
for iGroup = 1:p.nGroups
    ix = (p.ixStart(iGroup):p.ixEnd(iGroup))-p.idxB+1;
    m = p.m(ix+p.idxB-1);
    set(gca, 'XScale', 'log')
    hold on
    % loglog(m,lambda(ix),'linewidth',2,'Color',p.colGroup{iGroup})
    loglog(m,lambda(ix),'o','Color',p.colGroup{iGroup})
        % plot(ov_mass1,lmax,'d')
    loglog(mcG,vq1g,'d')
    %
    % Legend :
    %

    % Generalists :
    if (p.typeGroups(iGroup)==1 || p.typeGroups(iGroup)==5) && presence(p.typeGroups(iGroup))==0 
           name{end+1}='Generalists';
           presence(p.typeGroups(iGroup))=1;
           cG = loglog(m,lambda(ix),'linewidth',2,'Color',p.colGroup{iGroup});

    %Diatoms:
    elseif (p.typeGroups(iGroup)==3 || p.typeGroups(iGroup)==4) && presence(p.typeGroups(iGroup))==0 
           name{end+1}='Diatoms';
           presence(p.typeGroups(iGroup))=1;
           cD = loglog(m,lambda(ix),'linewidth',2,'Color',p.colGroup{iGroup});

    % Copepods:
    elseif (p.typeGroups(iGroup)==10)&& presence(p.typeGroups(iGroup))==0 
           name{end+1}='Passive copepod';
           presence(p.typeGroups(iGroup))=1;
           cPC = loglog(m,lambda(ix),'linewidth',2,'Color',p.colGroup{iGroup});

    elseif (p.typeGroups(iGroup)==11)&& presence(p.typeGroups(iGroup))==0 
           name{end+1}='Active copepod';
           presence(p.typeGroups(iGroup))=1;
           cAC = loglog(m,lambda(ix),'linewidth',2,'Color',p.colGroup{iGroup});

    end
    
end

hold off

ylim([0.9 max(lambda)+0.3])
xlim(calcXlim(p))
ylabel('Trophic Level')
xlabel('Mass ({\mu}gC)')
legend([cG,cD,cPC,cAC],name,'Location','northwest','box','off')
% Maximum trophic level and index of the Top-predator group of each size
% class

[lambda_htl,mHTL] =max(lambda); 
%%

% Community spectrum:
%
t2=nexttile(2);
 set(gca, 'XScale', 'log')
% [mc, Bc] = calcCommunityTrophicLevel(lambda, sim);
loglog(vq1);
sLegend{1} = 'Community Trophic Level';

% ylim([0.9 max(lambda)+0.3])
xlim(calcXlim(sim.p))
hold off
xticks=[10^-8 10^-7 10^-6 10^-5 10^-4 10^-3 10^-2 10^-1 1 10];

xlabel('Mass ({\mu}gC)')
%legendentries=[dum,legendentries];
%sLegend=[captionedstrat,sLegend];
