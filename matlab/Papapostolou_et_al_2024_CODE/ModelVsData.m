% Figures
% Comparison of NUM with data: Picophytoplankton, POC, Copepods Biomasses
%                              NPP 
% - POC data from GO-POPCORN from Tanioka et al., 2022 
%     data: https://doi.org/10.5281/zenodo.6967484
%     processed according to GOPOPCORNfigures.m 
%     and saved as 'dataGOPOPCORNver2.mat' in the folder 'processed_data'
%
% - Picophytoplankton data from Martínez-Vicente et al., 2017
%     data: https://doi.org/10.5281/zenodo.1067229
%     processed according to PicophytoFiguresAtlantic.m 
%     and saved as 'pico_insitudata.mat' in the folder 'processed_data'
%
% - Copepod data along the AMT track from López and Anadón,2008
%
% INPUT: dataGOPOPCORNver2.mat
%        poco_cpf_db_v2.mat
%        pico_insitudata.mat (filtered data)
% 
function status = ModelVsData(sim)
% sim.p.pathGrid='C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\TMs\MITgcm_2.8deg/grid.mat'
sim.Bpico = sim.BpicoAnnualMean;
r = calcRadiusGroups(sim.p);

x0=0; %positions (no need to change)
y0=0;
width=16; %figure width in cm
heightf=11; %figure height in cm

fig=figure(8);
set(fig,'Renderer','Painters','Units','centimeters',...
'Position',[x0 y0 width heightf],...
'PaperPositionMode','auto','Name','Model vs Data');
clf
tiles = tiledlayout(2,3,'TileSpacing','tight',Padding='tight');
tiles.TileIndexing = 'columnmajor';
ylimLatitude = [-65 55];
set(groot,'defaultAxesFontSize',10)
% Pico data:
fitPico = PicophytoFiguresAtlantic(sim,r);
pbaspect([1 1 1])

fprintf('Pico fit:    %f\n', fitPico);

% POPcorn data:
fitPopcorn = GOPOPCORNfigures(sim,r);
pbaspect([1 1 1])

fprintf('Popcorn fit: %f\n', fitPopcorn);
% Copepod data:
fitCopepods = AMTcopepods(sim);
pbaspect([1 1 1])

fprintf("Copepods fit: %f\n", fitCopepods);

NPPEutro = printStats(5,-119,sim); % Needs to be a bit north of equator to hit the eutrophic area
NPPOligo = printStats(22,158,sim);
NPPSeasonal = printStats(60,-15,sim);

status = [fitPico, fitPopcorn, fitCopepods, NPPEutro, NPPOligo, NPPSeasonal];

    function NPP = printStats(lat,lon,sim)
        ix = calcGlobalWatercolumn(lat,lon,sim);
        ixTime = sim.t>max(sim.t)-365;
        NPP = mean(spatialaverage(ix,sim.ProdNetAnnual(1,:,:)));
        fprintf('Prod net %5.0f mg C/m2/day\n', NPP);
        r = calcRadius(sim.p.m(sim.p.idxB:end));
    end

    function phi = spatialaverage(ix,field)
        phi = (...
            field(:,ix.x, ix.y) + ...
            field(:,ix.x-1, ix.y) + ...
            field(:,ix.x+1, ix.y) + ...
            field(:,ix.x, ix.y+1) + ...
            field(:,ix.x-1, ix.y+1) + ...
            field(:,ix.x+1, ix.y+1) + ...
            field(:,ix.x, ix.y-1) + ...
            field(:,ix.x-1, ix.y-1) + ...
            field(:,ix.x+1, ix.y-1) )/9;
    end

% Converts generalists and diatoms mass to radius in mum
% Converts copepod body-mass to prosome length/2 in mum, based on
% prosome length(um) to body-mass relationship for copepods
% from Chisholm and Roff (1990)
% -------treat POM as generalists------- MUST BE ADDRESSED
    function r = calcRadiusGroups(p)

        rho = 0.4*1e6*1e-12; % mug/cm3 (Andersen et al 2016; rho = m/V = 0.3*d^3/(4/3*pi*(d/2)^3) )

        for iGroup = 1:p.nGroups
            ix = (p.ixStart(iGroup):p.ixEnd(iGroup))-p.idxB+1;
            m(ix) = p.m(ix+p.idxB-1);

            %
            % Generalists:
            %
            if ((p.typeGroups(iGroup)==1) || (p.typeGroups(iGroup)==5)|| (p.typeGroups(iGroup)==100))
                r(ix) = (3/(4*pi)*m(ix)/rho).^(1/3);
            end
            %
            % Diatoms:
            %
            if ((p.typeGroups(iGroup)==3) || (p.typeGroups(iGroup)==4))
                v = 0.6;
                r(ix) = (3/(4*pi)*m(ix)/rho/(1-v)).^(1/3);
            end
            if ((p.typeGroups(iGroup)==10) || (p.typeGroups(iGroup)==11))
                % prosome length divided by 2 to be equivalent to radius
                r(ix)= ( m(ix)/(0.73*0.48*exp(-16.41))^(1/2.74) )/2;
            end
        end
    end

  function fit = PicophytoFiguresAtlantic(sim,r)
        load('processed_data/poco_cpf_db_v2.mat','pococpfdbv2')  % load picophytoplankton data table
        load('processed_data/pico_insitudata.mat','insitudata')  % load data with reduced columns

        % convert data variables to vectors
        datapoco=pococpfdbv2;
        insitu=table2array(datapoco(:,5));
        experiment=table2array(datapoco(:,15));

        % Assuming insitudata is a matrix with at least 3 columns (rows x columns)

        % Define latitude and longitude limits
        latLimits = [30.63, 43.4];
        lonLimits = [-10.33, 21.77];
        lonAtlantic = [-60, 22];
        % Create logical indices for rows that meet the criteria
        indicesToKeep = (insitudata(:, 2) >= latLimits(1) & insitudata(:, 2) <= latLimits(2)) & ...
            (insitudata(:, 3) >= lonLimits(1) & insitudata(:, 3) <= lonLimits(2));

        indicesAtlantic = (insitudata(:, 3) >= lonAtlantic(1) & insitudata(:, 3) <= lonAtlantic(2));

        % Use logical indexing to keep only the rows that meet the criteria
        filteredData = insitudata((indicesToKeep==false & indicesAtlantic), :);
        %%
        insitudata = filteredData;
        insitu     = insitudata(:,1);
        lat        = insitudata(:,2);
        lon        = insitudata(:,3);
        month_poco = insitudata(:,6);

        % MODEL OUTPUT
        lonWrapped = wrapTo180(sim.x); % convert longitude ordinates from [0,360]->[-180,180]
        r_pico     = find(r<=2);%-sim.p.nNutrients;
        r_pico     = r_pico(4:end);
        Bpico1     = sim.B(:,:,:,:,r_pico); % mugC/L
        Bpico_sum  = squeeze(sum(Bpico1,5)); % sum all size-classes

        Bpico2=sim.Bpico;
        Bpico=Bpico_sum;
        %%
        %------------------------------------------------------------------------------
        % Find model Biomass and Chla for the same coordinates and months as the data
        %------------------------------------------------------------------------------

        Picobiom_model=zeros(length(lat),1);

        for i=1:length(lat)

            [ ~, idx_lonG] = min( abs( lonWrapped-lon(i) ) );
            [ ~, idx_latG] = min( abs( sim.y-lat(i) ) );

            ix_lon(i) = idx_lonG;
            ix_lat(i) = idx_latG;

            % next step is to find combined coordinates
            Picobiom_model(i)=Bpico(month_poco(i),idx_lonG(1),idx_latG(1),1); % values taken at top layer
        end

        % FIGURE : NUM vs insitu
        nexttile(1)
        set(gcf,'color','w');
        set(groot,'DefaultLineLineWidth',0.4)
        loglog(insitu,Picobiom_model,'o','markerfacecolor','  #a2d9ce','markeredgecolor','#45b39d','MarkerSize',3);
        ax = gca;
        mx = max(max(insitu), max(Picobiom_model));
        mn = min(min(insitu), min(Picobiom_model));
        hold on
        t = linspace(1,100, 100);
        plot(t,t,'k-','LineWidth',2)
        hold off

        xlim([1 100])
        ylim([1 100])
        xlabel('')
        ylabel('Model biomass (mg C m^{-3})',FontSize=10)
        tt=title('a','FontWeight','normal','HorizontalAlignment','left');
        tt.Position(1)=1.3;
        hold on
        
        ix = ~isnan(Picobiom_model);
        fit = (Picobiom_model(ix) ./ insitu(ix));
        fit = mean( log(fit(~isinf(fit))));
        meanBias = log(mean(Picobiom_model(ix)) ./ mean(insitu(ix)));  
        p=75;

        % Text with the mean bias
        % str = append('Bias=',num2str(fit));
        % 
        % text(0.95,0.05,str,'Units','normalized','HorizontalAlignment','right','VerticalAlignment','bottom')
        h = text(t(p), t(p), '1:1','HorizontalAlignment','center',...
            'VerticalAlignment','Bottom','FontSize',10); 
        pAng = atan((t(p)-t(p-1)) / (t(p)-t(p-1)));  
        xExt = cos(pAng) * h.Extent(3); %this is the x-extent after the text is rotated
        %Compute width per char (assuming str is just 1 line); in x-axis units
        nchar = numel(h.String);  %number of characters
        wpch = xExt/nchar; 
        charPosX = linspace(t(p)-wpch*(ceil(nchar/2)+1), t(p)+wpch*floor(nchar/2), nchar+1);
        charPosY = charPosX; %Use equation of the line
        % Get slope|angle at each coordinate (quick and dirty way)
        slope = diff(charPosY)./diff(charPosX); 
        % Compute the angle of the text
        ang = atan(-1./slope)*180/pi +90; 
        hh = text(charPosX(2:end), charPosY(2:end), num2cell(h.String), 'HorizontalAlignment','center','VerticalAlignment','Bottom',...
            'FontSize',10); 
        % Rotate each letter 
        set(hh, {'Rotation'}, num2cell(ang'))
        delete(h)
        pbaspect([1 1 1])
        ax = gca;


        nexttile(2)
        box on
        for j=1:length(lat)
            if (lon(j)>=-60 && lon(j)<=0)
                hold on
                plot(insitu(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',3);
                plot(Picobiom_model(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',3);
                xlabel('Picophytoplankton (mg C m^{-3})',FontSize=10)
                ylabel('Latitude',FontSize=10)
            end
        end
        ylim(ylimLatitude)
        tt=title('d','FontWeight','normal','HorizontalAlignment','left');
        tt.Position(1)=5;

    end

%--------------------------------------------------------------------------
% Plots of GO-POPCORN data and comparison with model output (sim.Bmicro)
% data: https://doi.org/10.1038/s41597-022-01809-1
% this is only the code, the model results here don't fit
% (the biomass is too low, but it is probably better in the newest version)
% copepods and detritus should also be include in Bmicro-POC_avg_uM (?)
%
%--------------------------------------------------------------------------
%                          DATA PROCESSING
%-   -   - -   - -   - -   - -   - -   - -   - -   - - -   - - -   - - -
% *STEP 1*: Convert data table to array and convert units of POC to ugC/L
% *STEP 2*: Select size-classes of the model with r in [0.7/2, 30/2] um
% *STEP 3*: Remove the rows where POC is NaN
% *STEP 4*: Group data by cruise and subgroup by cruise_station
% *STEP 5*: Calculate the mean values at each station --> 'summary_Dep'
% *STEP 6*: Isolate only the last year of the model output and match the
%           model months to the observation months
% *STEP 7*: Find the model biomass at the same coordinates, depth and month
%           as the data, 'Pbiom_model'
% *STEP 8*: Calculate the mean value over depth at each coordinate,
%           'Pbiom_model_depth_avg'
% *STEP 9*: Apply the same grouping as the data (STEP 4) to the model
%           output from STEP 8 'summary_model'
% *STEP 10*: Plot transect
% *STEP 11*: For each cruise, plot observations and model output
% - -   - - -   - - -   - - -   - - -   - - -   - - -   - - -   - - -   - -
%--------------------------------------------------------------------------
% Arctic cruises are not included
    function fit = GOPOPCORNfigures(sim,r)


        load('processed_data/dataGOPOPCORNver2.mat', 'dataGOPOPCORNver2')
        %%
        % sim=simFun1;

        % MODEL OUTPUT
        % load('simGlobalDevelopCompareFun.mat')
        % sim=simGlobalDevelopComapreFun;


        % convert data variables to vectors
        dataPOP=dataGOPOPCORNver2;
        cruise=table2array(dataPOP(:,"Cruise"));
        cruise_station=table2array(dataPOP(:,"Cruise_Station"));
        lat=table2array(dataPOP(:,"Latitude"));
        lat1=lat;
        lon=table2array(dataPOP(:,"Longitude"));
        lon1=lon;
        depth=table2array(dataPOP(:,"Depth"));
        month=table2array(dataPOP(:,"Month"));
        day=table2array(dataPOP(:,"Day"));
        year=table2array(dataPOP(:,"Year"));
        POCavg_uM=table2array(dataPOP(:,"POCavg_uM")).*12;  % converted to mugC/L

        %nutricline_1uM_Interp=table2array(dataPOP(:,18));

        lonWrapped = wrapTo180(sim.x); % convert longitude ordinates from [0,360[-->[-180,180]

        % The size range is 2.4ug-30um, so Biomass needs to be updated.
        % r = calcRadiusGroups(sim.p);
        % load('rGroups.mat')
        % r=rGroups;

        rho = 0.4*1e6*1e-12; % mug/cm3 (Andersen et al 2016
        mass = @(r) 4*pi/3*rho*r^3;

        f = calcMassRangeFraction(sim.p, mass(0.7/2), mass(30/2));
        Bpopcorn_sum = squeeze( sum( sim.B .* reshape(f,1,1,1,1,numel(f)), 5) ); %squeeze( sum( sim.B*ones(1,1,1,1,size(sim.B,5)).*f ) )
        %r_popcorn=find(r>=0.7/2 & r<=30/2);

        %Bpopcorn=sim.B(:,:,:,:,r_popcorn); % mugC/L
        %Bpopcorn_sum=squeeze(sum(Bpopcorn,5)); % sum all size-classes
        %%
        dataPOPc=[cruise cruise_station lat lon depth month POCavg_uM];
        nan_rows= any(isnan(dataPOPc(:,7)),2); %POCavg_uM=NaN
        % Remove rows where POC=NaN
        %...........................
        dataPOPclean = dataPOPc(~nan_rows, :);

        % if cruise_station==NaN then assign it to a new non-existing unique station
        for i=1: height(dataPOPclean)
            if isnan(dataPOPclean(i,2))
                dataPOPclean(i,2)=1000+i;
            end
        end

        % convert matrix to table
        dataPOP = array2table(dataPOPclean);
        % Create custom column names
        customColumnNames = {'Cruise', 'Cruise_Station', 'Latitude','Longitude','Depth','Month','POCavg_uM'};
        dataPOP.Properties.VariableNames = customColumnNames;

        %% -------------------------------------------------------------------
        % grouping based on cruise and subgrouping based on cruise station
        %-------------------------------------------------------------------

        grouping_Cruise_cs=findgroups(dataPOP.Cruise, dataPOP.Cruise_Station);
        % create table same as dataPOP including the 'Grouping'
        temp_table=table(grouping_Cruise_cs,dataPOP.Cruise,dataPOP.Latitude,dataPOP.Longitude,dataPOP.Depth,...
            dataPOP.Month,dataPOP.POCavg_uM,'VariableNames',{'Grouping','Cruise','Latitude','Longitude','Depth','Month','POCavg_uM'});
        %.................................................
        % average POC concentartion and depth at each subgroup.
        %.................................................
        summary_Dep=groupsummary(temp_table,'Grouping','mean'); % this gives us mean values at each station

        temp_array=table2array(temp_table);
        % remove arctic cruises: 1701,1709,1901,2018
        temp_array_noA=temp_array(1:2296,:); %2296
        myData=temp_array_noA;
        %%
        %---------------------------------------------------------------------
        % Find model Biomass for the same coordinates and depth with the data
        %---------------------------------------------------------------------
        lat   = myData(:,3);
        lon   = myData(:,4);
        depth = myData(:,5);
        month = myData(:,6);
        % Initialize Pbiom_model with zeros
        Pbiom_model = zeros(length(lat),1);
        Pbiom_model_depth_avg = Pbiom_model;

        for i=1:length(lat)

            [ ~, idx_lonG]  = min( abs( lonWrapped-lon(i) ) );

            [ ~, idx_latG]  = min( abs( sim.y-lat(i) ) );

            [ ~, idx_depth] = min( abs( sim.z-depth(i) ) );

            % Find the index of the corresponding month over the last year of the
            % simulation
            idx_mon = (length(sim.t)-12) + month(i);

            % Save the indices just in case
            ix_lon(i) = idx_lonG;
            ix_lat(i) = idx_latG;
            ix_dep(i) = idx_depth;
            ix_mon(i) = idx_mon;

            % Assign POC values for the indices above
            Pbiom_model(i) = Bpopcorn_sum(idx_mon(1),idx_lonG(1),idx_latG(1),idx_depth(1)); % in mugC/L (I think)
            Pbiom_model_depth_avg(i) = mean(Bpopcorn_sum(idx_mon(1),idx_lonG(1),idx_latG(1),idx_depth(1)),4)';
        end

        depth_model=sim.z(ix_dep);
        lat_model=sim.y(ix_lat);
        lon_model=lonWrapped(ix_lon);
        month_model=mod(ix_mon,12)';
        for i=1:length(month_model)
            if month_model(i)==0
                month_model(i)=12;
            end
        end
        %%
        grouping_numbers=unique(myData(:,1));
        sumPOC_group=zeros(1,length(grouping_numbers));
        sumPOC_model=zeros(1,length(grouping_numbers));

        count=zeros(1,length(grouping_numbers));
        count_model=zeros(1,length(grouping_numbers));

        depth_max=zeros(1,length(grouping_numbers));
        myData_wo_model=myData;
        myData_with_model=[myData lat_model lon_model depth_model Pbiom_model month_model];

        myData_sorted = sortrows(myData_with_model,1); % sorted data based on grouping
        myData_sorted_modelOnly = [myData_sorted(:,1) myData_sorted(:,8:11)];
        for ix_g = 1:length(grouping_numbers)
            for j = 1:length(myData_sorted)
                if myData_sorted(j,1) == ix_g
                    sumPOC_group(ix_g) = sumPOC_group(ix_g) + myData_sorted(j,7);
                    count(ix_g) = count(ix_g)+1;
                    lat_group(ix_g)   = myData_sorted(j,3);
                    lon_group(ix_g)   = myData_sorted(j,4);
                    cruise_name(ix_g) = myData_sorted(j,2);
                    month_group(ix_g) = myData_sorted(j,6);
                    if myData(j,5)>depth_max(ix_g)
                        depth_max(ix_g)=myData(j,5); % max_depth at each grouping/station
                    end
                end
            end
        end
        myData_model_unique=unique(myData_sorted_modelOnly,"rows");
        myData_model_unique2=unique(myData_sorted_modelOnly(:,1:end-1),"rows");

        for ix_g = 1:length(grouping_numbers)
            for j = 1:length(myData_model_unique)
                if myData_model_unique(j,1) == ix_g
                    sumPOC_model(ix_g)  = sumPOC_model(ix_g) + myData_model_unique(j,5);
                    count_model(ix_g)   = count_model(ix_g)+1;
                    lat_model_new(ix_g) = myData_model_unique(j,2);
                    lon_model_new(ix_g) = myData_model_unique(j,3);
                    if myData_model_unique(j,4)>depth_max(ix_g)
                        depth_max_model(ix_g) = myData_model_unique(j,4); % max_depth at each grouping/station
                    end
                end
            end
        end

        for ix_g = 1:length(grouping_numbers)
            meanPOC_group(ix_g) = sumPOC_group(ix_g)/count(ix_g);
            meanPOC_model(ix_g) = sumPOC_model(ix_g)/count_model(ix_g);
        end

        myData_final=[grouping_numbers cruise_name' lat_group' lon_group' month_group' meanPOC_group' lat_model_new' lon_model_new' meanPOC_model'];

        colNames = {'grouping','cruise name','lat','lon','month','mean POC','lat model','lon model','mean POC model'};
        finalDataTable = array2table(myData_final,'VariableNames',colNames);
        %
        % cruise 46 has only Nan
        cruise_name=[7,9,13,18,28,1319,1418,1701,1709,1901,2018];

        % find indices of each cruise
        cruise1_ix=find(myData_final(:,2)==cruise_name(1));
        cruise2_ix=find(myData_final(:,2)==cruise_name(2));
        cruise3_ix=find(myData_final(:,2)==cruise_name(3));
        cruise4_ix=find(myData_final(:,2)==cruise_name(4));
        cruise5_ix=find(myData_final(:,2)==cruise_name(5));
        cruise6_ix=find(myData_final(:,2)==cruise_name(6));
        cruise7_ix=find(myData_final(:,2)==cruise_name(7));

        months=1:12;

        %%          TRANSECTS PLOT
        % figure
        % clf
        %    set(gcf,'color','w');
        %    surface(lon,lat,POCavg_uM,'EdgeColor','none')
        %    axis tight
        %    title('POC AVG uM')

        cmap=  [255, 0, 0; 255, 128, 0; 255, 255, 0;...
            128, 255, 0; 0, 255, 0; 0, 255, 128; 0, 255, 255;...
            0, 128, 255; 0, 0, 255; 128, 0, 255; 0, 210, 241;...
            255, 0, 255; 255, 0, 128]./255;

        latlim=[min(lat),max(lat)];
        lonlim=[min(lon),max(lon)];
              %%

        str=strings([1,length(cruise_name)]);
        for i=1:length(cruise_name)
            str(i)=append('cruise',num2str(i));
        end

        % cmap(month(j),:); where j are the data points
        monthmap=  [0, 93, 174; 59, 63, 126; 169, 223, 205; 250, 250, 110;... % jan,feb same color
            252, 150, 176; 199, 61, 92; 177, 48, 104; 135, 73, 163;...
            204, 183, 255; 149, 167, 255; ...
            122, 186, 242; 0, 116, 217]./255;

        lat=myData_final(:,3);
        lon=myData_final(:,4);
        latlim=[min(lat),max(lat)];
        lonlim=[min(lon),max(lon)];
        POCavg_uM=myData_final(:,6);
        Pbiom_model_final=myData_final(:,9);
        month=myData_final(:,5);

        % FIGURE : NUMvsPOPCORN
        nexttile(3)

        set(gcf,'color','w');
        set(groot,'DefaultLineLineWidth',0.4);
        loglog(POCavg_uM,Pbiom_model_final,'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d','MarkerSize',3);
        ax=gca;
        mx = max(max(POCavg_uM), max(Pbiom_model_final));
        mn = min(min(POCavg_uM), min(Pbiom_model_final));
        hold on
        t = linspace(1, 1000, 100);
        plot(t,t,'k-','LineWidth',2)
        % plot([0.05 50],[0.05 50],'k-','linewidth',2)
        hold off

        xlim([1 1000])
        ylim([1 1000])

        %xlabel('POC_{POPCORN} (\mugC/l)')
        ylabel('Model biomass (mg C m^{-3})',FontSize=10)
        tt=title('b','FontWeight','normal','HorizontalAlignment','left');
        tt.Position(1)=1.5;      
        % set(gca,'xscale','log','yscale','log')
        hold on
        ix = ~isnan(Pbiom_model_final);
        fit = (Pbiom_model_final(ix) ./ (POCavg_uM(ix)));
        fit = mean( log(fit(~isinf(fit))));

        % str = append('Bias=',num2str(fit));
        % text(0.95,0.05,str,'Units','normalized','HorizontalAlignment','right','VerticalAlignment','bottom')
        pbaspect([1 1 1])
        ax=gca;
        ax.XTick=[1 10 100 1000]; ax.YTick=[1 10 100 1000];

        %%
        % DETAILED Figure with latitudes
        nexttile(4)
        box on
        % set(gca, 'XScale', 'log')
        set(groot,'DefaultLineLineWidth',0.4);

        for j=cruise1_ix
            %set(gca,'XTickLabel',[]);
            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1)
            xlim([0 250])
            ylim(latlim)
        end

        %nexttile
        for j=cruise2_ix
            %set(gca,'XTickLabel',[]);
            %set(gca,'YTickLabel',[]);
            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1);
            xlim([0 250])
            ylim(latlim)
            %title(str(2))
        end

        %nexttile
        for j=cruise3_ix
            %set(gca,'XTickLabel',[]);
            %set(gca,'YTickLabel',[]);
            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1);
            xlim([0 250])
            ylim(latlim)
            %title(str(3))
        end

        %nexttile
        for j=cruise4_ix
            %set(gca,'XTickLabel',[]);
            %set(gca,'YTickLabel',[]);

            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1);
            xlim([0 250])
            ylim(latlim)
            %title(str(4))
        end


        %nexttile
        cruise5_ix_mooutlire=cruise5_ix;
        cruise5_ix_mooutlire(467)=[];
        for j=cruise5_ix_mooutlire
            % set(gca,'XTickLabel',[]);
            % set(gca,'YTickLabel',[]);
            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1);
            xlim([0 250])
            ylim(latlim)
            xlabel("Biomass (mg C m^{-3})",FontSize=10)
            %ylabel('latitude')
            %title(str(5))
        end

        %nexttile
        for j=cruise6_ix
            %set(gca,'YTickLabel',[]);
            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1);
            xlim([0 250])
            ylim(latlim)
            xlabel("Biomass (mg C m^{-3})")
            %title(str(6))
        end

        %nexttile
        for j=cruise7_ix
            %set(gca,'YTickLabel',[]);
            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1);
            xlim([0 250])
            ylim(latlim)
            % ylabel('latitude')
            % xlabel("biomass (\mugC/L)")
            %title(str(7))
        end

        %nexttile
        for j=cruise7_ix
            % set(gca,'YTickLabel',[]);
            hold on
            plot(POCavg_uM(j),lat(j),'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d ','MarkerSize',1);
            plot(Pbiom_model_final(j),lat(j),'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',1);
            xlim([0 250])
            % ylim(latlim)
            xlabel("POC (mg C m^{-3})",FontSize=10)
            %title(str(7))
        end
        tt=title('e','FontWeight','normal','HorizontalAlignment','left');
        tt.Position(1)=15;
        ylim(ylimLatitude)
    end
  
%
% Compare modelled copepod data along the AMT track with data from López and Anadón (2008)
% (As in Serra-Pompei et al 2022 figure 4).
%
    function [fit, Bmodel] = AMTcopepods(sim)
        %
        % Define data:
        %
        lat = [48.3178   47.2274   43.0218   40.0623   38.1931   34.7664   30.8723   26.1994   21.9938   20.7477   18.0997  10.0000    6.2617    2.0561   -6.5109  -10.4050  -14.6106  -18.8162  -22.5545  -26.4486  -29.5639  -32.679 -38.2866  -40.9346];
        lon = [-9.8450  -15.1765  -19.6695  -19.9979  -24.8281  -23.1558  -20.9826  -20.9748  -20.8011  -18.2991  -18.4613 -21.7812  -22.9416  -24.4346  -24.9203  -24.9138  -24.9068  -24.8998  -24.8936  -24.8871  -27.2152  -30.8767 -38.2007  -41.6963];

        % gC/m2:
        B(:,4) = [0.3773         0    0.5633    0.2040    0.2184    0.4332    0.1227    0.2330    0.2388    0.7008    0.7034    0.4824    0.4041    0.8479    0.2901    0.1400    0.0940   0.0608    0.1280    0.1464    0.0971    0.0146    2.0710    1.0978];
        B(:,3) = [0.3867         0    1.3984    0.1426    0.4378    0.2779    0.1462    0.1762    0.2137    0.1188    0.9154    0.3385    0.1510    0.4508    0.2764    0.0832    0.1096   0.0713    0.0841    0.0914    0.1161    0.0185    0.9881    2.2958];
        B(:,2) = [0.4546         0    3.3248    0.3611    0.6092    0.4867    0.4421    0.4759    0.7146    0.3288    1.0946    0.4472    0.3366    0.7643    0.2680    0.1965    0.2758   0.2222    0.2398    0.2159    0.2563    0.2960    0.9183    2.0695];
        B(:,1) = 0.001*[31.8556        0  334.3384  179.7190  474.8743  178.9145  171.5795   94.4342   76.2060  156.2178  323.9796  192.1518  171.0234   82.9817   52.5360   87.6493  134.3682 108.6737   91.5219   78.9438  127.7676  101.3492  234.6723  567.7467];
        Btot = sum(B,2);
        %
        % Extract copepods from the model:
        %
        for i = 1:length(lat)
            try
                ixWC = calcGlobalWatercolumn(lat(i), lon(i), sim);

                Bmodel(i) = 0;
                for j = find(sim.p.typeGroups>=10 & sim.p.typeGroups<=11)
                    ixB = sim.p.ixStart(j):sim.p.ixEnd(j) - sim.p.idxB+1;
                    B = sum(sim.B(:, ixWC.x, ixWC.y, :, ixB),5) / 1000;
                    B = squeeze(mean(B(sim.t>sim.t(end)-365,:,:,:),1));
                    ixZ = ~isnan(B);
                    B = sum(B(ixZ).*sim.dznom(ixZ));
                    Bmodel(i) = Bmodel(i) + B;
                end
            catch
                Bmodel(i) = NaN;
            end
        end
        Bmodel_g=Bmodel; Btot_g=Btot;
        % Bmodel=Bmodel_g*1000; Btot=Btot_g*1000; % convert to \ugC/
        %
        % Plot
        %
        nexttile(5)
        loglog(Btot, Bmodel,'o','markerfacecolor','  #a2d9ce','markeredgecolor',' #45b39d','MarkerSize',3)
        ax = gca;
        mx = max(max(Btot), max(Bmodel));
        mn = min(min(Btot), min(Bmodel));

        hold on
        t = linspace(0,10, 100);
        plot(t,t,'k-','LineWidth',2)
        % plot([0.05 50],[0.05 50],'k-','linewidth',2)
        hold off
       
        xlim([0 10])
        ylim([0 10])
        %xlabel('Data (g C/m^2)')
        ylabel('Model biomass (g C m^{-2})',FontSize=10)
        tt=title('c','FontWeight','normal','HorizontalAlignment','left');
        tt.Position(1)=.15;
        hold on
        ix  = ~isnan(Bmodel);
        fit = Bmodel(ix) ./ Btot(ix)';
        fit = mean( log(fit(~isinf(fit))));

        % str = append('Bias=',num2str(fit));
        % text(0.95,0.05,str,'Units','normalized','HorizontalAlignment','right','VerticalAlignment','bottom')
        pbaspect([1 1 1])
        ax=gca;
        ax.XTick=[0.1 1 10];  ax.YTick=[0.1 1 10];


        nexttile(6)%' #..a2d9ce..'
        plot(Btot,lat,'o','markerfacecolor','  #a2d9ce','markeredgecolor','#45b39d','MarkerSize',3)
        hold on
        plot(Bmodel, lat,'o','markerfacecolor','k','markeredgecolor','k','MarkerSize',3)
        %ylabel('Latitude')
        ylim(ylimLatitude)
        xlabel('Copepods (g C m^{-2})',FontSize=10)
        %legend({'Data','Model'})
        tt=title('f','FontWeight','normal','HorizontalAlignment','left');
        tt.Position(1)=.5;
        leg=legend('\textit{in situ}','NUM','fontsize',10,interpreter='latex');
        leg.ItemTokenSize(1) = 10;
        leg.Location='best';
        leg.Color='none';
        leg.NumColumns=1;
    end

    
    end
