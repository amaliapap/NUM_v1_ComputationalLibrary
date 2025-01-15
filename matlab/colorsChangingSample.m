% Sample data for 4 curves (can replace with your actual data)
x = linspace(0, 10, 100);
y1 = sin(x);     % First curve
y2 = cos(x);     % Second curve
y3 = sin(2*x);   % Third curve
y4 = cos(2*x);   % Fourth curve

% Corresponding values (could be any scalar representing the curves, e.g., maximum value, etc.)
% values = [.001, .2, .03, .0004];  % Values associated with the curves
values = linspace(1,10,4)'*(ones(1,4));
% values = Eflow_group;
% Normalize values for the colormap (range between 0 and 1)
% for i=1:length(values)
% normValues = (values - min(values,[],'all')) / (max(values,[],'all') - min(values,[],'all'));
normValues = ((values) / sum(values,'all','omitnan')) ;

valuesLim=normValues;
valuesLim(2,:)=NaN;
valuesLim(1)=NaN;
% end
% Choose a colormap (you can use 'parula', 'jet', 'hsv', etc.)
cmap=cmocean('deep',30);

ccmap = cmap(2:end-6,:); 
colormapName = ccmap;  % Color map, you can try different colormaps

nColors = size(colormapName, 1);  % Number of colors in the colormap

A=reshape(normValues,1,[]);

% Get the colormap
colors = colormap(colormapName);
% Assign color based on the normalized values
% for i=1:16
    % for j=1:4
curveColors = colors(floor(A * (nColors - 1)) + 1, :);
% curveColors = colors(floor(normValues * (nColors - 1)) + 1, :);
    % end
% end
% Plot each curve with its respective color
figure;
for i=1:length(A)
    % for j=1:4
    hold on;
    % for i=length(xy)
    % plot(xy(1,:),xy(2,:) , 'Color', curveColors(i,:),'LineWidth',2);%sum(Flow_htl));
    % hold on
    % end
    plot(x, i*y1, 'Color', curveColors(i,:), 'LineWidth', 2, 'DisplayName', 'Curve 1');
    % plot(x, i*y2, 'Color', curveColors(i,:), 'LineWidth', 2, 'DisplayName', 'Curve 2');
    % plot(x, i*y3, 'Color', curveColors(i,:), 'LineWidth', 2, 'DisplayName', 'Curve 3');
    % plot(x, i*y4, 'Color', curveColors(i,:), 'LineWidth', 2, 'DisplayName', 'Curve 4');
    hold off;
end
% end
% Add colorbar
colormap(colormapName);  % Set the colormap for the figure
c = colorbar;            % Create the colorbar
clim([min(normValues,[],'all') max(normValues,[],'all')]);  % Set the colorbar limits based on value range
% caxis([min(normValues,[],'all') 0.03])
% Add labels and title
xlabel('X-axis');
ylabel('Y-axis');
title('Curves Colored by Values');
grid on;
