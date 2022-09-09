
function [pdc_b,w,IP] = run_block_pdc(y,fs,nFreqs,T)

[nChannels,nSegLength]=size(y);
if nChannels > nSegLength, y=y.'; 
    [nChannels,nSegLength]=size(y);
end

% detrend signals
for i=1:nChannels, y(i,:)=detrend(y(i,:)); end;
% standardize signals
for i=1:nChannels, y(i,:)=y(i,:)/std(y(i,:)); end;

% Order selection parameters
maxIP = 30; % maxIP - externally defined maximum IP 
alg=1;  % Nuttall-Strand (alg=1) algorithm 
criterion = 1; %AIC, Akaike information criterion (Our preferred one)

% frequencies
w = fs*(0:(nFreqs-1))/2/nFreqs;

% multivariate AR model
[IP,pf,A,pb,B,ef,eb,vaic,Vaicv] = mvar(y,maxIP,alg,criterion);

% run block pdc
pdc_b=pdc_b_alg_A(A,pf,nFreqs,T);

