%
% Set the width of a figure in centimeters:
%
function setFigWidth(width)

a = get(gcf,'position');
a(3) = width;
set(gcf,'units','centimeters','position',a)
