function [hylabel]=labelity(i,chLabels) % Labels y-axis plottings
if isempty(chLabels)
   hylabel=ylabel(['i = ' int2str(i)],...
      'Rotation',90);
   set(hylabel,'FontSize',[12], ... %'FontWeight','bold', ...
      'FontName','Arial');  % 'FontName','Arial', 'Times'
else
   hylabel=ylabel([chLabels{i}]);
   set(hylabel,'FontSize',[12]); %'FontWeight','bold','Color',[0 0 0])
end;