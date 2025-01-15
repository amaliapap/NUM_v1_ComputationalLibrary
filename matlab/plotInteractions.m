allFlows = sum(sum(Eflow_group)); % Sum of all flows
incr = 5; % Arbitrary scaling factor for line width

% Normalize flow values
normValPOM = (Flow_pom - minFlow) / (maxFlow - minFlow); %Flow_pom/allFlows;%
normValHTL = (Flow_htl - minFlow) / (maxFlow - minFlow);%Flow_htl/allFlows; %(
normVal = (Eflow_group- minFlow) / (maxFlow - minFlow);% Eflow_group(i,j)/allFlows; %
colorIndexPOM=ones(1,length(Flow_pom));
colorIndexHTL=ones(1,length(Flow_pom));
colorIndex=ones(length(ixGroups));

% Concatenate flow matrices
A=reshape(normVal,1,[])';
ValsPomHtl=cat(2,normValHTL,normValPOM);
allVals=cat(1,A,ValsPomHtl');
binVals=logspace(-3,0,10);
% binVals=linspace(0,1,100);%0:0.1:1;
cmap=flip(cmocean('deep',length(binVals)+1));
col_doc='#b55ec2';%#e2bae5
allFlows=sum(Flow_htl,'omitnan')+sum(sum(Eflow_group,'omitnan'),'omitnan')+sum(Flow_pom,'omitnan');% predation      


figure(22)
clf(22)
tiledlayout(1,4)
t1=nexttile([1 4]);

% set the interaction between generalists to 0 for visualization purposes
Eflow_group(1,1)=0;
% Create a colormap based on the range of interaction magnitudes
minFlow = min(min(min(Eflow_group(Eflow_group > 0)),min(Flow_pom)),min(Flow_htl)); % Minimum non-zero flow
maxFlow = max(max(max(Eflow_group(:),max(Flow_pom))),max(Flow_htl(Flow_htl>1e-4))); % Maximum flow

minFlownorm = min(allVals); % Minimum non-zero flow
maxFlownorm = max(allVals);
% position of nodes
xPos=meansizevec;
yPos=meanTL;
for i = 1:(length(ixGroups)) 
    for j = 1:(length(ixGroups)) 

        x_HTL =mean(mHTL,'all','omitnan');
        y_HTL = l_htl; 
        x_doc=1e-3; y_doc=-0.5; % assumed position
        x_POM=totsizevec(end);
        y_POM=0;
        % Define the x and y coordinates of the start and end points
        x_start = meansizevec(i);    x_end = meansizevec(j);%xPos(j)
        y_start = meanTL(i);            y_end = meanTL(j);

        % Generate t values for interpolation
            t = [1, 2];
            xy = [x_start, x_end; y_start, y_end];
            xyHTL= [x_end, x_HTL; y_end, y_HTL];
            xyPOM= [x_end, x_POM; y_end, y_POM];

            % Cubic spline interpolation
            pp = csapi(t, xy);
            tInterp = linspace(1, 2, 100);
            xyInterp = ppval(pp, tInterp);
            xyPOMInterp= ppval(csapi(t, xyPOM), tInterp);
            %---------- end of interpolation ------------
             
            for k=1:length(binVals)
                if normValPOM(j)>=binVals(k) 
                    colorIndexPOM(j)=k+1;
                end
                if normValHTL(j)>=binVals(k) 
                    colorIndexHTL(j)=k+1;
                end
                if normVal(i,j)>=binVals(k) 
                    colorIndex(i,j)=k+1;
                end
            end
            % Calculate the line width, scaling by the magnitude of the flow
            lineWidth_flow = incr * (Eflow_group(i,j) + 1e-5) / allFlows;
            
            % Plot the interaction line with dynamic color and line width
            hold on
            plot(xyPOMInterp(1,:), xyPOMInterp(2,:), 'Color',cmap(colorIndexPOM(j),:), 'LineWidth', 2*incr*(Flow_pom(j))/sum(Flow_pom),'LineStyle',':');%sum(sum(Eflow_group)))
            plot(xyHTL(1,:), xyHTL(2,:), 'Color',cmap(colorIndexHTL(j),:), 'LineWidth', 2*incr*(Flow_htl(j))/sum(Flow_htl),'LineStyle','--');%sum(sum(Eflow_group)))
            if Eflow_group(i,j) > 0 % Only plot non-zero interactions
                plot(xyInterp(1,:), xyInterp(2,:), 'Color', cmap(colorIndex(i,j),:), 'LineWidth', 2*lineWidth_flow);
               % Calculate the direction of the flow vector for arrow
                dx = xPos(j) - xPos(i);
                dy = yPos(j) - yPos(i);
            end
             if j<3
                 xyDOC= [x_doc x_end; y_doc, y_end];
                 plot(xyDOC(1,:),xyDOC(2,:),'Color',col_doc,'LineWidth',3*Flow_doc(j)/sum(Flow_doc));
                 hold on
             end
    end
end

% Plot the nodes as circles
plot(xPos, yPos, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(x_HTL, y_HTL, 'ko', 'MarkerSize', 11, 'MarkerFaceColor', 'k');

colormap(cmap)
colorbar;
clim([minFlow maxFlow]);
% clim([minFlownorm maxFlownorm]);

title('Eflow Interaction Matrix with Dynamic Line Color and Width');
xlabel('Mean body mass [\mugC]')
ylabel('Mean trophic level [-]')
ylim([-1 y_HTL+1])

% hold off;
set(gca, "XScale", 'log')

%
c_cp=[206, 0, 91]/250;
ixDgroup=2; ixGgroup=1; ixCPgroup=3; ixCAgroup=4;
multFactor=1500; % multiplication factor for bubble size
    scatter(meansizevec, meanTLvec, meanbiomvec.* multFactor, ...
        'filled', 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k');
    hd=plot(meansizevec((ixDgroup)),meanTLvec((ixDgroup)),'go',LineWidth=.4); % make diatoms of biom<< visible
    hd.MarkerEdgeColor='k';
    hd.MarkerFaceColor='g';
    hd.MarkerSize=3;
    h1=scatter(meansizevec((ixGgroup)),meanTLvec((ixGgroup)),meanbiomvec((ixGgroup)).*multFactor,'c',...
        'filled','markeredgecolor','k');
    h2=scatter(meansizevec((ixDgroup)),meanTLvec((ixDgroup)),meanbiomvec((ixDgroup)).*multFactor,...
        'filled','markerfacecolor','g','markeredgecolor','g',MarkerFaceAlpha=.7);
    h3=scatter(meansizevec((ixCPgroup)),meanTLvec((ixCPgroup)),meanbiomvec((ixCPgroup)).*multFactor,...
        'filled','markerfacecolor',c_cp,'markeredgecolor','k',MarkerEdgeAlpha=.5);
    h4=scatter(meansizevec((ixCAgroup)),meanTLvec((ixCAgroup)),meanbiomvec((ixCAgroup)).*multFactor,...
        'filled','markerfacecolor','#eb8628','markeredgecolor','k',MarkerEdgeAlpha=.5);
    h_POM=scatter(x_POM,y_POM,biomvec(end).*multFactor,...
        'filled','markerfacecolor',[.4,.4,.4],'markeredgecolor','k',MarkerFaceAlpha=.2,MarkerEdgeAlpha=.4); %POM trophic level in fig at 0
    h_htl=scatter(x_HTL,y_HTL,2000*(sum(Flow_htl)),'markerfacecolor',[1 1 1],'markeredgecolor','k',MarkerFaceAlpha=1);
    h_DOC=scatter(x_doc,y_doc,50*mean(sim.DOC,'all','omitnan'),'markerfacecolor',col_doc,'markeredgecolor',col_doc,MarkerFaceAlpha=.5);
xlabel('Mean body mass [\mugC]')
ylabel('Mean trophic level [-]')

% xticks(logspace(-7, 5, 5));
    leg=legend([h1,h2,h3,h4,h_POM,h_htl,h_DOC],'Generalists','Diatoms','Copepods$_{pass.}$',...
    'Copepods$_{act.}$','POM','HTL','DOC','fontsize',10,'Location','best','box','off',Interpreter='latex'); 
    leg.NumColumns=4;
    leg.Location='southoutside';
set(gcf, 'color', 'w');
title_list={'Seasonally stratified','Upwelling','Oligotrophic'};
title('Global annual average energy flows',FontSize=11,FontWeight='normal')
% title(t1,append(string(title_list(site)),': \epsilon_{\mu}=',num2str(round(mte,2,"significant"))),"FontWeight","normal")
ylim([-1 y_HTL+1])
