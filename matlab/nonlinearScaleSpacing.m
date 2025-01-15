figure;
% Define the original x data and the y data
x_original = linspace(1, 5, 100);
y = sin(x_original); % Example y-data

% Define a transformation function that is strictly increasing
transform = @(x) (x < 2).*x + ...
                 (x >= 2 & x <= 4).*(2 + (x - 2) + 0.5*(x - 2).^2) + ...
                 (x > 4).*(4 + 1.5 + (x - 4));

% Apply the transformation to the x-data
x_transformed = transform(x_original);

% Plot the data using the transformed x-values
plot(x_transformed, y);

% Adjust x-ticks to show original x-values
% Ensure the ticks are strictly increasing
xticks_transformed = transform([1 2 3 4 5]);
set(gca, 'XTick', xticks_transformed, 'XTickLabel', {'1', '2', '3', '4', '5'});

% Label axes
xlabel('x-axis');
ylabel('y-axis');
title('Custom x-axis Transformation');
