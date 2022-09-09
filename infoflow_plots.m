% This script plots partial results of
% Zhang et al., PNAS 2022
% Active neural coordination of motor behaviors with internal states
% Please add subfolders to the path
clear
close all
% load cleaned fUS (by ROI), movement, and heart rate data
h1 = load('./data/fusi_mv_hr_data_v2.mat');
% load brain state data
h2=load('./data/brain_state_data_v2.mat');
%%
% Fig. 2E

% number of frequency points
nFreqs = 128;

% number of ROIs
nroi = size(h1.data.fusi, 2);

% block design
T = zeros(3,nroi+2);
T(1,1:nroi) = 1:nroi;
T(2,1) = nroi+1;
T(3,1) = nroi+2;

% run block PDC
[pdc_b,w,IP] = run_block_pdc([h1.data.fusi h1.data.mi h1.data.hr], h1.data.fs, nFreqs, T);

disp(['Selected AR order = ' num2str(IP)])

% plot block PDC
figure

var_lab = {'Brain', 'MI', 'HR'};
for i = 1:3
    for j =1:3
    subplot(3, 3, (i-1)*3+j)

    plot(w,squeeze(abs(pdc_b(i,j,:))),'Color',[0.7 0.5 0.5],'LineWidth',2)

    xlabel('Frequency (Hz)')
    ylabel('PDC')
    box off
    
    title([var_lab{j} ' to ' var_lab{i}])
    axis tight
    
    ylim([0 0.4])
    end
end


%%
% Fig. 3C,D

% redesign block to run PDC for individual ROIs
% block design
T = zeros(nroi+2,nroi+2);
T(1:nroi,1) = 1:nroi;
T(nroi+1,1) = nroi+1;
T(nroi+2,1) = nroi+2;

% run block PDC
[pdc_roi,w,IP] = run_block_pdc([h1.data.fusi h1.data.mi h1.data.hr], h1.data.fs, nFreqs, T);

% information flow matrix
A = real(-sum(log(1 - pdc_roi(:,:,w>0.0&w<=0.5)),3));
A = A - diag(diag(A));

% Brain <-> MI
% find 75% threshold
bm = [A(end-1, find(h1.data.isvessel==0)) A(find(h1.data.isvessel==0), end-1)'];
thresh = prctile(bm(bm>0), 75);

figure
subplot(121)
% fill in each ROI with information flow
infoim = NaN(size(h2.data.parcellation));
for i = 1:nroi
    infoim(h2.data.parcellation == i) = A(end-1, i);
end
imagesc(infoim,[0 0.3])
colorbar
hold on
% if above threshold plot boundary
for j = 1:nroi        
        if A(end-1, j) > thresh && h1.data.isvessel(j) == 0
            [B,L] = bwboundaries(h2.data.parcellation == j,'noholes');
            for k = 1:length(B)
               boundary = B{k};
               plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
            end
        end       
end
title('Brain to MI')

subplot(122)
for i = 1:nroi
    infoim(h2.data.parcellation == i) = A(i,end-1);
end
imagesc(infoim,[0 0.3])
colorbar
hold on

for j = 1:nroi        
        if A(j, end-1) > thresh && h1.data.isvessel(j) == 0
            [B,L] = bwboundaries(h2.data.parcellation == j,'noholes');
            for k = 1:length(B)
               boundary = B{k};
               plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
            end
        end       
end

title('MI to Brain')

set(gcf,'position',[100,100,1000,400])

% Brain <-> HR
bh = [A(end, find(h1.data.isvessel==0)) A(find(h1.data.isvessel==0), end)'];
thresh = prctile(bh(bh>0), 75);

figure
subplot(121)

infoim = NaN(size(h2.data.parcellation));
for i = 1:nroi
    infoim(h2.data.parcellation == i) = A(end, i);
end
imagesc(infoim,[0 0.7])
colorbar
hold on

for j = 1:nroi        
        if A(end, j) > thresh && h1.data.isvessel(j) == 0
            [B,L] = bwboundaries(h2.data.parcellation == j,'noholes');
            for k = 1:length(B)
               boundary = B{k};
               plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
            end
        end       
end
title('Brain to HR')

subplot(122)
for i = 1:nroi
    infoim(h2.data.parcellation == i) = A(i,end);
end
imagesc(infoim,[0 0.7])
colorbar
hold on

for j = 1:nroi        
        if A(j, end) > thresh && h1.data.isvessel(j) == 0
            [B,L] = bwboundaries(h2.data.parcellation == j,'noholes');
            for k = 1:length(B)
               boundary = B{k};
               plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
            end
        end       
end

title('HR to Brain')

set(gcf,'position',[100,100,1000,400])
