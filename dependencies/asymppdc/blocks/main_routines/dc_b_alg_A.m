function dc_b=dc_b_alg_A(A,pf,nf,Block_set)
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
%output: dc_b - i_block,j_block, as a function of frequency
%
%
[nb,dummy]=size(Block_set);
Hff=H_to_f(A,nf);
SS=ss_alg(A,pf,nf); % ineficiente
dc_b=zeros(nb,nb,nf);
ipf=inv(pf);
 for i=1:nb
    for j=1:nb
        for ff=1:nf
       Sii=grab_block(SS(:,:,ff),i,i,Block_set);
       daux=det(Sii);
        Hijb=grab_block(Hff(:,:,ff),i,j,Block_set);
        ipf_b=inv(grab_block(ipf,j,j,Block_set));
        aux=Sii-Hijb*ipf_b*Hijb';
        dc_b(i,j,ff)=1-det(aux)/daux;
        end
    end
end