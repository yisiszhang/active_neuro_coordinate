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
% Fig. 4F
% number of frequency points
nFreqs = 128;

% number of ROIs
nroi = size(h1.data.fusi, 2);

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

% control score:
ctrl_score = [A(end-1,h1.data.isvessel==0)' - A(end,h1.data.isvessel==0)'];

% prepare data to estimate percentage variance explained
% response is roi activity
Y = h2.data.fusi_roi(:, h2.data.isvessel==0);
% predictor is brain state
xdummy = onehotencode(categorical(h2.data.state),2);

% number of vc folds
K = 10;
rng(20)
cvp = cvpartition(categorical(h2.data.state), 'KFold', 10);
nroi = size(Y, 2);
varexp = zeros(K, nroi, 4);

% estimate variance explained for each fold and each state #
for i = 1:K
    for j = 1:4
        ytrain = Y(cvp.training(i), :);
        xtrain = xdummy(cvp.training(i), j);
        ytest = Y(cvp.test(i), :);
        xtest = xdummy(cvp.test(i), j);
        
        % use full rank for reduced rank regression
        [beta, total_mse, t] = rrr(xtrain, ytrain);
        yhat = [ones(size(xtest, 1), 1) xtest]*beta';
        
        % calculate R2
        varexp1 = 1 - var(ytest-yhat)./var(ytest);
        varexp(i, :, j) = varexp1;
    end
end


figure
% plot bar with 95% ci
barwitherr((1.96*squeeze(std(varexp)))*100, 100*(squeeze(mean(varexp,1))))
colormap(turbo(length(h2.data.roiname)))
box off
set(gca,'xtick',1:length(h2.data.roiname))
set(gca,'xticklabel',h2.data.roiname);
ylabel('%Variance explained')
set(gcf,'Position',[100 100 800 400])
cri = 0.001/nroi;
for i = 1:nroi
    mm = squeeze(varexp(:,i,:));
    if sum(mean(mm(:,[1,2]))) > 2*sum(mean(mm(:,[3,4]))) && max(mean(squeeze(varexp(:,i,:))) - 1.96*std(squeeze(varexp(:,i,:))))>0
        text(i, 12.5, '#')
    elseif 2*sum(mean(mm(:,[1,2]))) < sum(mean(mm(:,[3,4]))) && max(mean(squeeze(varexp(:,i,:))) - 1.96*std(squeeze(varexp(:,i,:))))>0
        text(i, 12.5, 'o')
    else
        text(i, 12.5, 'x')
    end
end

% mean variance explained
mm = squeeze(mean(varexp));
% variance of variance explained
vv = squeeze(var(varexp));

% state score:
state_score = log((mm(:,1) + mm(:,2))./(mm(:,3) + mm(:,4)));
% variance of state score
logscrvar = (vv(:,1)+vv(:,2)) ./ (mm(:,1) + mm(:,2)).^2 + (vv(:,3)+vv(:,4)) ./ (mm(:,3) + mm(:,4)).^2 ;
% error bar
err = sqrt(logscrvar);

% linear regression
mdl = fitlm(ctrl_score, state_score);

figure
% plot linear regression
xplot = linspace(min(ctrl_score), max(ctrl_score), 100);
yplot = xplot*mdl.Coefficients.Estimate(2)+mdl.Coefficients.Estimate(1);
[~, yci] = predict(mdl,xplot','Prediction','curve');
colormap(jet(5))
hold on
errorbar(ctrl_score, state_score, err, 'ko','MarkerFaceColor','r')
line(xplot, yplot)
xlabel('Control score')
ylabel('State score')
box off
set(gcf,'Position',[100 100 500 400])

% plot power spectrum
z = h2.data.state==1 | h2.data.state==2;

% multitaper parameters
params.tapers = [10.5, 20];
params.pad = 0;
params.Fs = 2;
params.fpass = [0.001, 0.5];
params.err = [1 0.05];

session = h2.data.session;
m1 = find(session(2:end) ~= session(1:end-1));
sMarkers = [[1; m1+1] [m1; length(session)];];
movingwin = [1000 1000];

% calculate multitaper psd using chronux
[ S, f, Serr ]= mtspectrumc_unequal_length_trials(double(z), movingwin, params, sMarkers );

figure
plot(f, S, '-k')
hold on
plot(f, Serr, 'color', [0.6 0.6 0.6])
hold off
box off
set(gcf,'Position',[100 100 500 400])

xlabel('Frequency (Hz)')
ylabel('PSD')
