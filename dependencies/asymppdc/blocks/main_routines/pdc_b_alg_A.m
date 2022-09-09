function pdc_b=pdc_b_alg_A(A,pf,nf,Block_set)
% 
% input: A - model matrix
%        pf - residure covariance matrix
%        nf - number of frequencies
%        Block_set  - Matrix containg indices for each blocks 
%                     rows - number the blocks (=<n) -nb blocks
%                     columns - number provide the indices per block
%                               (=n - filled with zeros above the number of
%                               valid indices)
%output: pdc_b - i_block,j_block, as a function of frequency
%        
%
%
[nb,dummy]=size(Block_set);
Aff=permute(A_to_f(A,nf),[2 3 1]);
PP=ssi_alg(Aff,pf);
pdc_b=zeros(nb,nb,nf);
%ipf=inv(pf);
for i=1:nb
    pf_b=grab_block(pf,i,i,Block_set);
    for j=1:nb
        for ff=1:nf
        Aijb=grab_block(Aff(:,:,ff),i,j,Block_set);
        Pjj=grab_block(PP(:,:,ff),j,j,Block_set);
        aux=Pjj-Aijb'*inv(pf_b)*Aijb;
        pdc_b(i,j,ff)=1-det(aux)/det(Pjj);
        end
    end
end
