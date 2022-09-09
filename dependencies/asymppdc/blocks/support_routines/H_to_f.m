function H=H_to_f(A,nf)
% 
% input: A - model matrix
%        nf - number of frequency points
%
% outpuf: H(freq) matrix
%
 [n, n, r] = size(A);
    AL = A_to_f(A, nf);
    H = zeros(n,n,nf);
    for i = 1:nf,
        H(:,:,i) = inv(reshape(AL(i,:,:),n,n));
    end

