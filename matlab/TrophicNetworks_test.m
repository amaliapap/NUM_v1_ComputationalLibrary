%First need to run extractWCfromGlobal
% function EflowplotNUMhtlWC_columnTiles(sim,lat,lon,site,time)
sim=simWC_site2;
site=2;
time=21;
%    Indices of different groups
%
% generalists
[~, idxG ]=find(sim.p.typeGroups==5); 
ixG  = (sim.p.ixStart( idxG (1)):sim.p.ixEnd( idxG (end))) -sim.p.idxB+1;
% diatoms
[~, idxD ]=find(sim.p.typeGroups==3); 
ixD  = (sim.p.ixStart( idxD (1)):sim.p.ixEnd( idxD (end))) -sim.p.idxB+1;

% passive copepods
[~, idxPC ]=find(sim.p.typeGroups==10); 
ixPC  = (sim.p.ixStart( idxPC (1)):sim.p.ixEnd( idxPC (end))) -sim.p.idxB+1;

% active copepods
[~,idxAC]=find(sim.p.typeGroups==11); % Find index of Active Copepods
ixAC = (sim.p.ixStart(idxAC(1)):sim.p.ixEnd(idxAC(end))) -sim.p.idxB+1;

totsizevec=sim.p.m(sim.p.idxB:end);
preysize=totsizevec;
[~,predsort_idx]=sort(preysize);

%% calculate trophic level
biomvec=sim.B(time,:);
rates=sim.ratesTime;
jPP=rates.jDOC+rates.jLreal; %Uptake of Primary Production 
jF=rates.jFreal; %Uptake of Food
ratio=jPP./(jPP+jF);

theta=getTheta(sim.p);

% TL2=calcTrophicLevelamp(sim,rates,biomvec);  % old version
[TL2,~]=calcTrophicLevel(sim.p,biomvec,rates); % test version
%
TL=TL2;
TLactive_mean=mean(TL(ixAC));
Biom_CA=sum(biomvec(ixAC));
TLactive_Wmean=mean(biomvec(ixAC).*TL(ixAC)/Biom_CA);

%% Eflow real
Eflow=zeros(sim.p.n-sim.p.idxB+1);
for i=1:sim.p.n-sim.p.idxB+1
    for j=1:1:sim.p.n-sim.p.idxB+1
        % Eflow(i,j)= rates.jFreal(i)*theta(i,j)/sum(theta(i,:),2); 
        Eflow(i,j)= rates.jFreal(i)*theta(i,j)/sum(theta(i,:),2)*biomvec(i); 
    end
end
Eflow(isnan(Eflow))=0;
Eflow_sort=Eflow(predsort_idx,predsort_idx);
%% Progressive Trophic Efficiency (PTE)
lhtl = CalchtlTrophicLevel(sim,sim.ratesTime,squeeze(sim.B(time,:)));
 cd 'C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab'
 [~,lambda_htl]=calcTrophicLevel(sim.p,squeeze(sim.B(time,:)),sim.ratesTime);
% [~,~,nppG,npp_og]   = CfixedRespTotal(sim,sim.rates);
[~,~,nppG,npp_og]   = CfixedRespTotalTime(sim,sim.rates,time);

mte0=sum(sim.rates.mortHTL(time,:).*sim.B(time,:))/npp_og;
mte=sim.ProdHTLwc(time)/sim.ProdNetwc(time);
pte=mte^(1/(lambda_htl-1));
disp(append('lambda_htl=',num2str(lambda_htl)));
disp(lhtl);
%% Trophic Transfer Efficiency from on group to the following
pte_i=zeros(1,sim.p.n-sim.p.idxB+1);
for i=1:(sim.p.n-sim.p.idxB+1)
    pte_i(i)=(sim.rates.mortpred(i))/sum(Eflow(i,:),2);
    if i<=20
     epsilonT(i)=sum(Eflow(:,i),1)/abs(sum(Eflow(i,:),2)+nppG(i)+rates.jDOC(i));
    else
     epsilonT(i)=sum(Eflow(:,i),1)/abs(sum(Eflow(i,:),2));
    end
end
epsilonT(epsilonT==Inf)=0;
nppGroups=zeros(1,sim.p.n-sim.p.idxB+1);
nppGroups(ixG(1):ixD(end))=nppG; % all the unicellulars
%% Trophic Transfer efficiency from one TL to the next
for i=1:ceil(max(TL))
    [~,idxTL{i}]=find(TL<=i);
    Eflow_in{i}=sum(sum(Eflow(idxTL{i},:),2)+sum(nppGroups(idxTL{i})),1); % i-group is the predator
    Eflow_out{i}= sum(sum(Eflow(:,idxTL{i}),1)+sum(rates.mortHTL(idxTL{i}).*biomvec(idxTL{i})));               % i-group is prey   
end

epsilonTL=cell2mat(Eflow_out)./cell2mat(Eflow_in);
%%
% interaction-lines colormaps
cmap_pass=[241, 166, 153,250*0.4;239, 108, 111,250*0.4;219, 7, 61,250*0.4]/250; % 4-element vectors where the 4th is alpha
% cmap_pass=[219, 7, 61,250*0.2 ;219, 7, 61,250*0.4 ;219, 7, 61,250*0.6 ;]/250; % only transparency changing
cmap_act=[248, 196, 113,250*0.4 ; 245, 176, 65,250*0.4;243, 156, 18,250*0.4 ]/250;
% cmap_act=[243, 156, 18,250*0.2; 243, 156, 18,250*0.4; 243, 156, 18,250*0.6;]/250; % only transparency changing

% ATTENTION! setting POM trophic level to 0 for plotting purposes!
TL(end)=0;
bnorm = 100;
fluxes_to_htl=0;
intercHTL=zeros(1,length(totsizevec));
figure(33)
clf
tiledlayout(1,4)
t1=nexttile([1 3]);
for i = 2:(length(totsizevec)) % predators
    for j = 1:(i-1)%length(totsizevec) % prey
        interc = (Eflow_sort(i, j))./ sum(sum(Eflow));
        if (interc > 0.0001)% || intercHTL(j)>0.0005)
            % Define the x and y coordinates of the start and end points
            x_start = totsizevec(i);    x_end = totsizevec(j);
            y_start = TL(i);            y_end = TL(j);
            % Generate t values for interpolation
            t = [1, 2];
            xy = [x_start, x_end; y_start, y_end];
            pp = csapi(t, xy);
            % ppHTL=csapi(t,xyHTL);
            tInterp = linspace(1, 2, 100);
            xyInterp = ppval(pp, tInterp);
            % xyHTLInterp = ppval(ppHTL, tInterp);
            %---------- end of interpolation ------------
            row_color=1;
            if interc>=1e-3 && interc<1e-2
                row_color=1; % lightest shade
            elseif interc>=1e-2 && interc<1e-1
                row_color=2;
            elseif interc>1e-1 %&& interc<1e-1
                row_color=3; % darkest shade for the strongest interactions
            end
          connectingColor=cmap_pass(row_color,:);
          % Plot the spline curve
            if interc>0.001
                plot(xyInterp(1,:), xyInterp(2,:), 'Color', connectingColor, 'LineWidth', .8)%interc/bnorm
            end
            hold on
        end
        % hold on
        % plot(xyHTL(1,:),xyHTL(2,:) , 'b:','LineWidth',ceil(intercHTL(j))); % Plot the points with log scale on x-axis
        % h_htl=scatter(x_HTL,y_HTL,1,'markerfacecolor','none','markeredgecolor',[0,0,0],MarkerFaceAlpha=.5,MarkerEdgeAlpha=0);
    end
end
%   HTL flows
% for i = 2:(length(totsizevec)) % predators
    for j = 1:length(totsizevec) % prey
        intercHTL(j) = double(rates.mortHTL(j).*biomvec(j));
        fluxes_to_htl=fluxes_to_htl+intercHTL(j);   % this will be used only to scale the plotted HTL-disc
         x_HTL = 1e3; % assumed position of HTL in the x-axis
         y_HTL=max(TL)+1; % HTL trophic level is plotted as the highest trophic level in the plankton community +1 
         % y_HTL=lambda_htl; % test version: it  doesn't look nice in the plot
            % Define the x and y coordinates of the start and end points
            x_start = totsizevec(j);   
            y_start = TL(j);           
           
            % Generate t values for interpolation
            xyHTL= [x_start, x_HTL; y_start, y_HTL];
                      
            row_colorHTL=1; % lightest shade
            if intercHTL(j)>=1e-3 && intercHTL(j)<1e-2
                row_colorHTL=1; % lightest shade
            elseif intercHTL(j)>=1e-2 && intercHTL(j)<1e-1
                row_colorHTL=2;
            elseif intercHTL(j)>1e-1 %&& interc<1e-1
                row_colorHTL=3; % darkest shade for the strongest interactions
            end
          
            if intercHTL(j)>0.0001
                plot(xyHTL(1,:),xyHTL(2,:) , 'Color', cmap_act(row_colorHTL,:),'LineWidth',0.8);
                hold on
            end % Plot the points with log scale on x-axis
        end
           
%% end


set(gca, "XScale", 'log')

idxU=ixG(1):ixD(end);
idxCP=ixPC(1):ixPC(end);
idxCA=ixAC(1):ixAC(end);

cmap=brewermap(15,'PRGn');

c_cp=[206, 0, 91]/250;%cmap(2,:);
c_ap=[243, 156, 18]/250;

multFactor=3000; % multiplication factor for bubble size
ccmap = cmap(3:end-2,:); 
    scatter(totsizevec, TL, biomvec ./ bnorm .* multFactor, ...
        'filled', 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k');
    hd=plot(totsizevec((ixD)),TL((ixD)),'go',LineWidth=.4); % make diatoms of biom<< appear
    hd.MarkerEdgeColor='k';
    hd.MarkerFaceColor='g';
    hd.MarkerSize=3;
    h1=scatter(totsizevec((ixG)),TL((ixG)),biomvec((ixG))./bnorm.*multFactor,ratio(ixG),...
        'filled','markeredgecolor','k');
    alpha(.7)
    cbar=colorbar('horizontal','Direction','reverse');
    colormap(ccmap)
    cbar.Label.String = 'Photorophy degree [-]';
    cbar.Location="north";
     a=get(cbar); %gets properties of colorbar
     cb=a.Position; %gets the positon and size of the color bar
    cbar.Position=[cb(1) cb(2) 0.3 cb(4)];
    if site>1
        set(cbar,'visible','off')
    end
    clim([0 1])
    hold on
    h2=scatter(totsizevec((ixD)),TL((ixD)),biomvec((ixD))./bnorm.*multFactor,...
        'filled','markerfacecolor','g','markeredgecolor','k',MarkerFaceAlpha=.7);
    h3=scatter(totsizevec((idxCP)),TL((idxCP)),biomvec((idxCP))./bnorm.*multFactor,...
        'filled','markerfacecolor',c_cp,'markeredgecolor','k',MarkerEdgeAlpha=.5);
    h4=scatter(totsizevec((idxCA)),TL((idxCA)),biomvec((idxCA))./bnorm.*multFactor,...
        'filled','markerfacecolor','#eb8628','markeredgecolor','k',MarkerEdgeAlpha=.5);
    hPOM=scatter(totsizevec(end),TL(end),biomvec(end)./bnorm.*multFactor,...
        'filled','markerfacecolor',[.4,.4,.4],'markeredgecolor','k',MarkerFaceAlpha=.2,MarkerEdgeAlpha=.4); %POM trophic level in fig at 0
    h_htl=scatter(x_HTL,y_HTL,50*(fluxes_to_htl/10),'markerfacecolor','none','markeredgecolor','k',MarkerFaceAlpha=.5);

    set(gca, 'xscale', 'log')
ylim([0.5, 4.5])
xlim([1e-9, 1e5])
if site==3 % show xlabel only on the bottom of the figure
    xlabel('Body mass [\mugC]')
end
ylabel('Trophic level [-]')
% cbar.Label.String = 'Photorophy degree [-]';
% set(colorbar,'visible','off')

xticks(logspace(-7, 5, 5));
if site==3
    leg=legend([h1,h2,h3,h4,hPOM,h_htl],'Generalists','Diatoms','Copepods_{pass.}',...
    'Copepods_{act.}','POM','HTL','Location','best','box','off'); 
    leg.NumColumns=3;
    leg.Location='southoutside';
    leg.Position=[0.1,   -0.002,    0.7593,    0.0568];
end
grid on
set(gcf, 'color', 'w');
% title(t1,append('lat=',num2str(lat),', lon=',num2str(lon)),"FontWeight","normal")
title_list={'Seasonally stratified','Upwelling','Oligotrophic'};
title(t1,append(string(title_list(site)),': \epsilon_{\mu}=',num2str(round(mte,2,"significant"))),"FontWeight","normal")
ylim([0 4])
disp(append('fluxes to HTL=',num2str(fluxes_to_htl)))

t2=nexttile();
set(gcf,'color','w');
set(groot,'defaultAxesFontSize',10)
set(groot,'defaultLineLineWidth',2)
    set(gca,'YTickLabel',[]);
    set(gca, 'YScale','log')
    maxEl=.25;
    yPoints=[.001,.01,.05,maxEl];

    yyaxis right
    plot(1:ceil(max(TL)),epsilonTL)
    ax=gca;
    if site==3
        xlabel('Trophic level [-]')
    end
    ylabel('Progressive Efficiency [-]')
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
        set(gca, 'YTick',yPoints, 'YTickLabel',yPoints)
        ylim([0 maxEl])
title(t2,append('$\bar{\epsilon}_{\lambda}$=',num2str(round(pte,2,'significant'))),"FontWeight","normal",Interpreter="latex")

disp(append('pte=',num2str(pte),', epsilonTL_mean=',num2str(mean(epsilonTL))));


    % set(ax, 'YScale','log', 'YTick',yPoints, 'YTickLabel',yPoints)
