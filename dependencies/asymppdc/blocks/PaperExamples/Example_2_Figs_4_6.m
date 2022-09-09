% Supplementary software material for Frontiers in Neuroinformatics 
% May 2014 issue
%
% Takahashi DY, Baccala LA and Sameshima K (2014). Canonical Information 
% Flow Decomposition Among Neural Structure Subsets. Front. Neuroinform. 
% 8:49. doi: 10.3389/fninf.2014.00049 
% 
% This routine generate the Figures 4 and 5 of Example 2, whose diagram is 
% depicted in Figure 3, and the parameters are in Equations (29)-(41).This
% particular routine deals with the case of a = 1.
%

clear
close all
nn=10;

A=zeros(nn,nn,2);
A(1,1,1) =  2*.99*cos(pi/50);
A(1,1,2) = -(.99)^2;
A(2,1,1) =  1;
A(9,1,1) =  1;
A(8,2,1) =  1;
A(8,2,3) =  1;
A(2,3,1) =  1;A(8,8,1) = -1;
A(3,3,2) = -(.99)^2;
A(3,3,1) =  2*.99*cos(pi/2);
A(6,3,3) =  1;
A(6,3,1) =  1;
A(2,3,1) =  1;A(4,5,1) = -.99;
A(5,4,1) =  .99;
A(9,5,1) =  1;
A(7,6,1) = -.99;
A(9,6,1) =  1;
A(6,7,1) =  .99;
A(9,8,1) =  .5;
A(4,10,1) =  1; % = a. Either -1 (Fig. 4,5) or +1 (Fig. 6) 
A(7,10,1) =  1;
A(10,10,1) =  2*.99*cos(2*pi/3);
A(10,10,2) = -(.99)^2;

%Block set
T = [ 1 2 3 4 5 0 0 0 0 0;  % Block 1: {1,2,3,4,5}
      6 7 0 0 0 0 0 0 0 0;  % Block 2:   {6,7}
      8 9 0 0 0 0 0 0 0 0;  % Block 3:   {8,9}
     10 0 0 0 0 0 0 0 0 0]; % Block 4:    {10}
  
nb = size(T);
nb = nb(1);
nf = 128; % number of frequencies in [0 .5) range

% Block PDC
pf =  eye(nn);
pdc_b = pdc_b_alg_A(A,pf,nf,T);
[h11 dummy]=plot_block2(pdc_b,'PDC');
set(h11,'NumberTitle','off','MenuBar','none')
% Canonical PDC
[pdc_c,len_c] = pdc_c_alg_A(A,pf,nf,T);
h1=plot_canon2(pdc_c,'PDC',T);

set(h1,'NumberTitle','off','MenuBar','none', ...
    'Name', ['Figure 4. cPDC for Example 2 is identical for |a| = 1'])
supAxes=[.08 .08 .84 .84];
[ax,h1supx]=suplabel('Source','x',supAxes);
set(h1supx, 'FontSize',[24])
[ax,h1supy]=suplabel('Target','y',supAxes);
set(h1supy, 'FontSize',[24])


% Block DC
dc_b = dc_b_alg_A(A,pf,nf,T);
[h22 dummy] = plot_block2(dc_b,'DC');
set(h22,'NumberTitle','off','MenuBar','none')
% Canonical DC
[dc_c,len_c] = dc_c_alg_A(A,pf,nf,T);
h2=plot_canon2(dc_c,'DC',T);

set(h2,'NumberTitle','off','MenuBar','none', ...
    'Name', ['Figure 6. cDC for Example 2 with a = 1'])
supAxes=[.08 .08 .84 .84];
[ax,h2supx]=suplabel('Source','x',supAxes);
set(h2supx, 'FontSize',[24])
[ax,h2supy]=suplabel('Target','y',supAxes);
set(h2supy, 'FontSize',[24])

eval(['print -depsc Figure_6.eps -painters'])
eval(['print -dpdf Figure_6.pdf -painters'])

tilefigs3
