function plot_block4(x,strMeasure,chLabels)
%
%   x - pdc_b or dc_b
%   strMeasure - title
nt=size(x);
nb=nt(1);
nf=nt(3);
ff=(0:nf-1)*.5/nf;
h=figure;
set(h,'NumberTitle','off','MenuBar','none', ...
   'Name', ['Block ' strMeasure])
k=0;
for i=1:nb
   for j=1:nb
      k=k+1;
      h=subplot2(nb,nb,k);
      h12 = plot(ff,reshape(x(i,j,:),1,nf),'k');
      set(h12,'LineWidth',1.5)
      axis([0 0.5/8 -.01 1.01])
      if rem(k,nb)==1, labelity(i,chLabels); end
      if k>nb*(nb-1), labelitx(j,chLabels); end

      if ~(i == nb & j==1),
         set(h,'XTickLabel', [' '],'YTickLabel', [' '])
      end;

      if i==j,
         set(h, 'Color', 0.8*[1 1 1]); % Background color on main diagonal
      end;
   end
end
