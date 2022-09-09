function [dc_c,len_c]=dc_c_alg_A(A,pf,nf,Block_set)
% 
% input: A - model matrix
%        pf - residure covariance matrix
%        nf - number of frequencies
%        Block_set  - Matrix containg indices for each blocks 
%                     rows - number the blocks (=<n) -nb blocks
%                     columns - number provide the indices per block
%                               (=n - filled with zeros above the number of
%                               valid indices) 
%
% output: dc_c - i_block,j_block,freg,which_component
%         len_c - number of components at i_block,j_block,freq
%
[nb,n]=size(Block_set);
Hff=H_to_f(A,nf);
SS=ss_alg(A,pf,nf);
%dc_c=zeros(nb,nb,nf,n);
ipf=inv(pf);
for i=1:nb
    for jj=1:nb
        ipf_b=inv(grab_block(ipf,jj,jj,Block_set));
        for ff=1:nf
        Sii=inv(grab_block(SS(:,:,ff),i,i,Block_set));
        Hijb=grab_block(Hff(:,:,ff),i,jj,Block_set);
%        i,j
        [dummy,aux] = eig(Sii*Hijb*ipf_b*Hijb');
        aux=real(sort(diag(aux)));
        laux=length(aux);
       % if i>jj,ff,keyboard,end
        len_c(i,jj,ff)=laux;
        dc_c(i,jj,ff,1:laux)=sort(aux,'descend');
     end
    end
end