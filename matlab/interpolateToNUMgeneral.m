% interpolateToNUM and recenter
function npp_interp=interpolateToNUMgeneral(sim,data_imported)
        lat_dim=size(data_imported,1);
        lat=zeros(lat_dim,1);
        lat(1)=1/6;
        for i=2:lat_dim
            lat(i)=lat(i-1)+1/6;
        end
        lat=lat-90;
        %
        lon_dim=size(data_imported,2);
        lon=zeros(lon_dim,1);
        lon(1)=1/6;
        for i=2:lon_dim
            lon(i)=lon(i-1)+1/6;
        end

        % create meshgrid with CAFE's coordinates
        [lon_interp,lat_interp]=meshgrid(lon,lat);

        %create meshgrid with NUM's coordinates
        [lon_num,lat_num]=meshgrid(sim.x,sim.y);

        % interpolate NPP CAFE dimensions to NUM's
        nppCAFEinterp=interp2(lon_interp,lat_interp,squeeze(data_imported),lon_num,lat_num);

        orig0=(sim.ProdNetAnnual(end,:,:)); %NUM NPP
        orig=squeeze(orig0)'; % flip NUM npp data

        nppCAFEinterpRecenter= [nppCAFEinterp(:,65:end),nppCAFEinterp(:,1:64)];
        % make land white
        nppCAFEinterpRecenter(nppCAFEinterpRecenter==-9999)=NaN;
        orig(orig==0)=NaN;


        npp_interp=nppCAFEinterpRecenter;
    end


