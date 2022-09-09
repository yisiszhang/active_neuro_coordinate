function SS = ssi_alg(AL, e_cov)
%    '''Calculates the Inverse Spectral density (SS)
%         AL -> A(ff) matrix
%         e_cov -> residues
%         nf -> number of frequencies
%         '''
    [n, m,r] = size(AL);
    SS = zeros(size(AL));
    %keyboard
    ie_cov=inv(e_cov);
    for i = 1:r,
        SS(:,:,i) = AL(:,:,i)'*ie_cov*AL(:,:,i);
    end;    
    %print ss[5]
%    SS=permute(ss,[2,3,1]);
%    return ss.transpose(1,2,0)