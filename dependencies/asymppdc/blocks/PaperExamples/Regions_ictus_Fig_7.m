% Supplementary software material for Frontiers in Neuroinformatics 
% May 2014 issue
%
% Takahashi DY, Baccala LA and Sameshima K (2014). Canonical Information 
% Flow Decomposition Among Neural Structure Subsets. Front. Neuroinform. 
% 8:49. doi: 10.3389/fninf.2014.00049 
% 
% This routine generate the Figures 7 from ictus data recorded in epileptic
% patients.
%

clear all; close all; clc

load results_ictus % Loading previouly estimated MAR model from ictus 
                   % EEG data.

% Block set  definition

T=zeros(3,27);

%=========================  Left hemisphere electrodes set:
T(1,1:4)=[1 3 11 20];     % Frontal  (LF)
T(2,1)=5;                 % Central  (LC)
T(3,1:4)=[13 15 22 26];   % Temporal (LT)
T(4,1:2)=[7 24];          % Parietal (LP)
T(5,1)=9;                 % Occipital(LO)

%=========================  Right hemisphere electrodes set:
T(6,1:4)=T(1,1:4)+1;      % Frontal  (RF)
T(7,1)=6;                 % Central  (RC)
T(8,1:4)=[13 15 22 26]+1; % Temporal (RT)
T(9,1:2)=[7 24]+1;        % Parietal (RP)
T(10,1)=10;               % Occipital(RO)

ChLabels =['LF';'LC';'LT';'LP';'LO';
           'RF';'RC';'RT';'RP';'RO'];
        
cLabels=cellstr(ChLabels);

x=linhacodigo(T);

nb=size(T);
nb=nb(1);
nf=128; % Number of frequencie in [0 .5) range.

% Block PDC
pdc_b=pdc_b_alg_A(A,pf,nf,T);
plot_block4(real(pdc_b),['PDC' x],cLabels)
% Canonical PDC
[pdc_c,len_c] = pdc_c_alg_A(A,pf,nf,T);
h1=plot_canon4(real(pdc_c),['PDC' x],1,cLabels);
set(h1,'NumberTitle','off','MenuBar','none', ...
    'Name', ['Figure 7. cPDC from the Empirical Data Example (ictus)'])

% Block DC
dc_b = dc_b_alg_A(A,pf,nf,T);
plot_block4(real(dc_b),['DC' x],cLabels)
% Canonical DC
[dc_c,len_c] = dc_c_alg_A(A,pf,nf,T);
h2=plot_canon4(real(dc_c),['DC' x],1,cLabels);


% Bring Figure 7 to the front
figure(h1); pause(10)


eval(['print -depsc2 -painters Figure_7.eps'])
eval(['print -dpdf -painters Figure_7.pdf'])

% Tile the analysis results' figures of Ictus example
tilefigs3
