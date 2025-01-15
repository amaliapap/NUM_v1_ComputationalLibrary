% returns the value from the data that is
% closest to the target lat and lon and is non-NaN

function data_out = findClosestCoordValue(data_in, lat, lon, lat_nc, lon_nc)
data = data_in;% 180x360

% Coordinates you provide
target_lat = lat;
target_lon = lon;

% Find non-NaN coordinates
% row          column
[non_nan_lat, non_nan_lon] = find(~isnan(data));


% Compute distances
distances = pdist2([lat_nc(non_nan_lat(:)), lon_nc(non_nan_lon(:))], [target_lat, target_lon]);

% Find the index of the minimum distance
[~, min_idx] = min(distances);

% Get the indices of the closest non-NaN coordinates
closest_lat_idx = non_nan_lat(min_idx);
closest_lon_idx = non_nan_lon(min_idx);

data_out=data(closest_lat_idx,closest_lon_idx);


