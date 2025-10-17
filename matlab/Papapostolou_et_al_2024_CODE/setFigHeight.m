%
% Set the height of a figure in centimeters:
%
function setFigHeight(height)

a = get(gcf,'position');
a(4) = height;
set(gcf,'units','centimeters')
set(gcf,'position',a)
