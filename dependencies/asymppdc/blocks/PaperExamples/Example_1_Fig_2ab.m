% Supplementary software material for Frontiers in Neuroinformatics 
% May 2014 issue
%
% Takahashi DY, Baccala LA and Sameshima K (2014). Canonical Information 
% Flow Decomposition Among Neural Structure Subsets. Front. Neuroinform. 
% 8:49. doi: 10.3389/fninf.2014.00049 
% 
% Example 1. See Figure 1 and A coefficient, Equation (26), for the detail of the model 
%
clear all; close all; clc

nn=4; % Number of blocks

A=zeros(nn,nn,1);
A(1,1,1)=.5;
A(2,2,1)=.5;
A(3,3,1)=.5;
A(4,4,1)=.5;

for figure2=['A' 'B'],
    
    switch figure2
        case 'A'  % Figure 2A
            a = 0.1; b = 0.2; c = 0.1; d = 0.2; e = 0; f = 0; g = 0; h =0;
        case 'B'  % Figure 2B
            a = .5; b = 0; c = 0; d = 1; e = .3; f = -0.1; g = .3; h = .4;
    end;
    A(3,1,1) = a;
    A(3,2,1) = b;
    A(4,1,1) = c;
    A(4,2,1) = d;
    A(2,1,1) = e;
    A(2,1,1) = e;
    A(1,2,1) = f;
    A(4,3,1) = g;
    A(3,4,1) = h;
    
    %Block set:
    T=[1 2 0 0;
        3 4 0 0];
    
    nb=size(T);
    nb=nb(1);
    nf=128; % Number of frequencies point in [0 e .5) range.
    
    % Block PDC
    pf= eye(nn);
    %pf(7,1)=-.9;
    %pf(1,7)=-.9;
    pdc_b=pdc_b_alg_A(A,pf,nf,T);
    [h1 dummy] = plot_block2(pdc_b,'PDC');
    set(h1,'NumberTitle','off','MenuBar','none', ...
            'Name', ['Figure 2' figure2 ' condition.'])
    % Canonical PDC
    [pdc_c,len_c]=pdc_c_alg_A(A,pf,nf,T);
    h12 = plot_canon1(pdc_c,'PDC',T);
    set(h12,'NumberTitle','off','MenuBar','none', ...
            'Name', ['Figure 2' figure2 ' condition.'])
    
    
    % Block DC
    dc_b=dc_b_alg_A(A,pf,nf,T);
    [h2 dummy] = plot_block2(dc_b,'DC');
    set(h2,'NumberTitle','off','MenuBar','none', ...
            'Name', ['Figure 2' figure2 ' condition.'])
        
    % Canonical DC
    [dc_c,len_c]=dc_c_alg_A(A,pf,nf,T);
    h22 = plot_canon1(dc_c,'DC',T); %,max(max(max(len_c))))
    set(h22,'NumberTitle','off','MenuBar','none', ...
            'Name', ['Figure 2' figure2 ' condition.'])
    
    switch figure2
        case 'A'
            % Figure 2A
            hfigure2=figure;
            subplot(2,2,1)
        case 'B'
            % Figure 2B
            figure(hfigure2);
            subplot(2,2,2)
        otherwise
            
    end;
    
    v=pdc_c(2,1,:,2);
    v=reshape(v,1,128);
    plot(0:pi/128:pi-pi/128,v,'b')
    axis([0 pi 0 1])
    hold
    v=pdc_c(2,1,:,1);
    v=reshape(v,1,128);
    plot(0:pi/128:pi-pi/128,v, 'r')
    axis([0 pi -0.02 1.03])
    htitle=title([figure2 '             {{cPDC}_{21}}']);
    set(htitle,'HorizontalAlignment','right')
    xlabel('Frequency (rad/s)')
end;
set(hfigure2,'NumberTitle','off','MenuBar','none', ...
    'Name', ['Figure 2.'])

eval(['print -depsc Figure_2.eps -painters'])
eval(['print -dpdf Figure_2.pdf -painters'])

tilefigs3
