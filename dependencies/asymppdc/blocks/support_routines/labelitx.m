function [hxlabel]=labelitx(j,chLabels) % Labels x-axis plottings
if isempty(chLabels)
   hxlabel=xlabel(['j = ' int2str(j)]);
   set(hxlabel,'FontSize',[12], ... %'FontWeight','bold', ...
      'FontName','Arial'); % 'FontName','Arial'
else
   hxlabel=xlabel([chLabels{j}]);
   set(hxlabel,'FontSize',[12]) %'FontWeight','bold')
end;
