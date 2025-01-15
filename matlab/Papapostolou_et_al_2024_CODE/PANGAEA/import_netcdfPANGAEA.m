% Calls function: interp_woa_grid in
addpath('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\woa');
% https://doi.pangaea.de/10.1594/PANGAEA.785501
% ncdisp('https://www.ncei.noaa.gov/thredds-ocean/dodsC/woa23/DATA/phosphate/netcdf/all/1.00/woa23_all_p00_01.nc')
% ncdisp('woa23_all_n00_01.nc')
% MarEDat20120214Bacteria
 % open downloaded ncdf dataset
% ncdisp('MarEDat20120524Mesozooplankton.nc') 
ncdisp('MarEDat20120524Mesozooplankton.nc') 

netcdf.inqVar(ncid,9);
 ncid=netcdf.open('MarEDat20120214Bacteria.nc'); 
% save variables
% po4_nc=netcdf.getVar(ncid,9);
% data_3D=po4_nc;

% nc=netcdf('MarEDat20120524Mesozooplankton.nc')
biomass=nc{'BIOMASS'}(:,1:9,:,:);  %1:9 FOR MESOZP top 150m
% close(nc)
lon=nc{'LONGITUDE'}(:);
lat=nc{'LATITUDE'}(:);
depth=nc{'DEPTH'}(:);
FillValue = 1.000000040918479e+35;
biomass(biomass>1.00e+34)=NaN;
%%
dep=depth(2:end);
dz=zeros(1,length(dep))';
for i=1:length(dep)-1
    dz(i)=abs(dep(i)-dep(i+1));
end
dz=dz(1:end-1);
%%
biomassYrAvg=squeeze(mean(biomass,1,'omitnan'));

% Integrate mesoZP biomass over the top 150m (dz(1:)))
mesoZPyrAvgTop150int = squeeze(sum(permute(biomassYrAvg,[2 3 1]).*reshape(dz(1:9),1,1,numel(dz(1:9))),3,'omitnan'));
mesoZPannualTop150int_Recenter= [mesoZPyrAvgTop150int(:,181:end),mesoZPyrAvgTop150int(:,1:180)]';

%%
data_imported=(squeeze(mean(double(data_3D),4)));%mean TIME
data_importedTop150=squeeze(mean(data_imported(:,:,1:9),3))*1e-34;
data_Recenter=interp_woa_grid(sim,data_imported',lon_nc,lat_nc);  
 %% final step: close
 % netcdf.close(ncid);