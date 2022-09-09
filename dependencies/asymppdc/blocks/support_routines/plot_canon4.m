function hh=plot_canon4(x,strMeasure,max_comp,chLabels)
% Canonical DC and PDC plotting routine for generating Figure 7
% of EEG Ictus example in
% Takahashi DY, Baccala LA and Sameshima K (2014). Canonical Information
% Flow Decomposition Among Neural Structure Subsets. Front. Neuroinform.
% 8:49. doi: 10.3389/fninf.2014.00049
%
%function plot_canon4(x,measure,block_set,max_comp)
%Input:
%     x - pdc_c/dc_c estimates
%     measure - either 'DC' or 'PDC'.
%     block_set - used to determine the number cPDC/cDC components.
%     max_comp - maximum number of components
%     chLabels - block elements label
%
nt=size(x);
nb=nt(1)
nf=nt(3);
if length(nt)<4
    nc=1;
else
    nc=nt(4);
end
if nargin==3
    nc=max_comp;
end
ff=(0:nf-1)*.5/nf;
flgHold=1;

hh=figure;
set(hh,'NumberTitle','off','MenuBar','none', ...
    'Name', ['Canonical ' strMeasure])

colorset=['g','b','k','r','y'];
k=0;
for i=1:nb
    for j=1:nb
        k=k+1;
        h=subplot2(nb,nb,k);
        for ll=1:nc
            if ll == 1
                h12=plot(ff,reshape(x(i,j,:,ll),1,nf),'Color',[0 .6 0]);
            else
                h12=plot(ff,reshape(x(i,j,:,ll),1,nf),'k');
            end
            if ll == 1,
                set(h12,'LineWidth',1.5)
                ax(1)=gca; ax(2)=ax(1);
                axis([0 0.125/2 -.1 1.1])
            end;
            if rem(k,nb)==1,labelity(i,chLabels);,end
            if (flgHold)&(ll==1), hold,end
            if k>nb*(nb-1),labelitx(j,chLabels);,end
        end
        
        if ~(i == nb & j==1),
            set(h,'XTickLabel', [' '],'YTickLabel', [' '])
        end;
        
        if i==j,
            set(h, 'Color', 0.8*[1 1 1]); % Background color
        end;
    end
    
end
