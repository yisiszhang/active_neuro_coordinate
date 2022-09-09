function h=plot_canon2(x,measure,block_set,max_comp)
% Canonical DC or PDC plotting routine for Figure 2 of Example 1 in 
% Takahashi DY, Baccala LA and Sameshima K (2014). Canonical Information 
% Flow Decomposition Among Neural Structure Subsets. Front. Neuroinform. 
% 8:49. doi: 10.3389/fninf.2014.00049 
%
%function plot_canon2(x,measure,block_set,max_comp)
%Input:
%     x - pdc_c/dc_c estimates
%     measure - either 'DC' or 'PDC'.
%     block_set - used to determine the number cPDC/cDC components.
%     max_comp - maximum number of components
%     chLabels - block elements label

nt=size(x);
nb=nt(1); % Number of blocks
nf=nt(3); % Number of frequencies

nc=5;

nBlockSize = sum((block_set ~= 0)');

if length(nt)<4
    nc=1;
else
    nc=nt(4);
end

% if nargin>2,
%     if size(nBlockSize) > 1,
%         if nargin ==4,
%             nc=max_comp;
%         end;
%     else
%         nBlockSize = nc*ones(1,nc);
%     end;
% end

ff=(0:nf-1)*.5/nf;
flgHold=1;
h=figure;
colorset=['r','b','y','g','k','m','c','y','k','k','k','k','k','k','k','k'];
k=0;
for i=1:nb
    for j=1:nb
        k=k+1;
        hs=subplot(nb,nb,k);
        m = min(nBlockSize(i),nBlockSize(j));
        for ll = m:-1:1,
            hp=plot(ff,reshape(x(i,j,:,ll),1,nf),colorset(ll));
            axis([0.0 0.5 -.05 1.05])

            if (flgHold)&(ll == m), hold,end
            %if ll~=1, flgHold=0,end
        end
        if i==j,
            set(hs, 'Color', 0.8*[1 1 1]); % Background color
        end;
    end
    %suptitle(['Canonical ' measure ' ' num2str(ll)])
end
suptitle(['Canonical ' measure])

