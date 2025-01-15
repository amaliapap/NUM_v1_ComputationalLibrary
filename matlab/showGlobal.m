function showGlobal(sim)
       load('npp_climatlogy_cafe_2002_2020.mat','npp')

        lat_dim=size(npp,1);

        lat=zeros(lat_dim,1);
        lat(1)=1/6;
        for i=2:lat_dim
           lat(i)=lat(i-1)+1/6;
        end
        lat=lat-90;
        %
        lon=zeros(2160,1);
        lon(1)=1/6;
        for i=2:2160
          lon(i)=lon(i-1)+1/6;
        end

        % nppAvgAnnual=squeeze(mean(nppAvg(1:11,:,:),1));
        nppCAFEinterpRec=interpolateToNUM(sim, npp);
        %%
            
        % create meshgrid with CAFE's coordinates
        [lon1,lat1]=meshgrid(lon,lat);

        %create meshgrid with NUM's coordinates
        [lon2,lat2]=meshgrid(sim.x,sim.y);

        % interpolate NPP CAFE dimensions to NUM's
        nppCAFEinterp=interp2(lon1,lat1,squeeze(npp),lon2,lat2);

        orig0=(sim.ProdNetAnnual(end,:,:)); %NUM NPP
        orig=squeeze(orig0)'; % flip NUM npp data

        nppCAFEinterpRecenter= [nppCAFEinterp(:,65:end),nppCAFEinterp(:,1:64)];
        % make land white
        for i=1:64
            for j=1:128
                if (nppCAFEinterpRecenter(i,j)==-9999)
                    nppCAFEinterpRecenter(i,j)=NaN;
                    orig(i,j)=NaN;
                end
            end
        end

        %%
        % figure('Renderer','Painters');
        
        tiles = tiledlayout(1,2);%,'TileSpacing','compact');%,'padding','compact');
        tiles.InnerPosition = [0.13,0.11,0.65,0.8150]; % Make space for colorbars

        nexttile
        % cbar = panelGlobal(sim.x,sim.y,(sim.ProdNetAnnual(end,:,:)),[0,1000],...
        cbar = panelGlobal(sim.x,sim.y,(sim.ProdNetAnnual),[0,1000],...
        sTitle='Net primary production NUM', sProjection='eckert4');
        cbar.Label.String = '(mgC m^{-2}d^{-1})';
        cbar.Visible='on';
        % caxis([1,3])
        colorbar
        cmocean('haline',500)
        set(gca,'YTickLabel',[]);
        set(gca,'XTickLabel',[]);

        nexttile
        cbar = panelGlobal(sim.x,sim.y,(flip(nppCAFEinterpRec)'),[0,1000],...
            sTitle='Net primary production CAFE', sProjection='eckert4');
        cbar.Label.String = '(mgC m^{-2}d^{-1})';
        cbar.Visible='on';
        % caxis([1,3])
        colorbar
        cmocean('haline',500)
        set(gca,'YTickLabel',[]);
        set(gca,'XTickLabel',[]);
        set(gcf,'color','w');
                
    end


