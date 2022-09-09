function [pdc_c,len_c]=pdc_c_alg_A(A,pf,nf,Block_set)
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
% output: pdc_c - i_block,j_block,frequency,which_component
%         len_c - number of components at i_block,j_block,freq
%
[nb,n]=size(Block_set);
Aff=permute(A_to_f(A,nf),[2 3 1]);
PP=ssi_alg(Aff,pf);
%pdc_b=zeros(nb,nb,nf,n);
ipf=inv(pf);
for i=1:nb
    pf_b=grab_block(pf,i,i,Block_set);
    for j=1:nb 
        for ff=1:nf
            Pjj=grab_block(PP(:,:,ff),j,j,Block_set);
            Aijb=grab_block(Aff(:,:,ff),i,j,Block_set);
            %        i,j
          %  isqrtPjj = inv(sqrtm(Pjj));
            %[~,aux] = eig(isqrtPjj*Aijb'*inv(pf_b)*Aijb*isqrtPjj);
            
            [dummy,aux] = eig(Aijb'*inv(pf_b)*Aijb*inv(Pjj));
            aux =sort(real(diag(aux)));
            laux=length(aux);
            len_c(i,j,ff)=laux;
            pdc_c(i,j,ff,1:laux)=sort(aux,'descend');
        end
    end
end
