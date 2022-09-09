function [h h12]=plot_block2(x,stitle)
%Block DC or PDC plotting routine.
%function [h h12]=plot_block2(x,stitle)
%
% Input:
%   x - pdc_b or dc_b
%   stitle - title string
% Output:
%   h - figure handle
%   h12 - plot handle

nt=size(x);
nb=nt(1);
nf=nt(3);
ff=(0:nf-1)*.5/nf;
h=figure;
k=0;
for i=1:nb
    for j=1:nb
        k=k+1;
        hs=subplot(nb,nb,k);
        h12 = plot(ff,abs(reshape(x(i,j,:),1,nf)),'r');
        axis([0 0.5 -.05 1.05])
        if i==j,
            set(hs, 'Color', 0.8*[1 1 1]); % Background color
        end;
        
    end
end
suptitle(['Block ' stitle])
