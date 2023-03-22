% test sns routine
%

clear

% Short sample of MEG data contaminated with noise
% sr=500Hz, 1 Hz highpass and 60 Hz notch filters in hardware,
% selected 40 channels (of 160):
load test_tsr.mat;  

% data are in xx
data_channels=1:37;
ref_channels=38:40; 
data=xx(:,data_channels);       % gradiometers over brain
ref=xx(:,ref_channels);         % magnetometers to measure environment noise

% first clean with tsr
disp('applying tsr to remove environmental noise...');
shifts=-100:100;
toobig1=3000; % ignore values greater than this in estimating projections
toobig2=20; % ignore values greater than this in estimating projections
wx=find_outliers(data,toobig1,toobig2);
wx=min(wx,[],2);
[clean,idx]=tsr(data,ref,shifts,wx);

% apply sns
disp('applying snr to remove sensor noise...');
nneighbors=10; % number of channels for projection
skip=2; % ignore closest neighbor
clean2=sns(clean,nneighbors,skip,wx(idx));
clean2=sns(clean2,nneighbors,skip,wx(idx));

disp(['tsr removed ',num2str(100*(sum(data(:).^2)-sum(clean(:).^2))/sum(data(:).^2)),'% of original power']);
disp(['sns removed ',num2str(100*(sum(clean(:).^2)-sum(clean2(:).^2))/sum(clean(:).^2)),'% of remaining power']);
disp(['remains ',num2str( 100*sum(clean2(:).^2)/sum(data(:).^2)),'% of original power']);


subplot 231;
imagesc(data); ylabel('samples'); xlabel('channels')
title('raw');
subplot 232;
imagesc(clean); ylabel('samples'); xlabel('channels')
title('after tsr');
subplot 233;
imagesc(clean2)
title('after tsr and sns');; ylabel('samples'); xlabel('channels')

ch=5;
subplot 234
plot((1:size(data,1))'/500, data(:,ch), 'b');
ylabel('fT'); xlabel('s'); title(['ch #',num2str(ch),' raw']); set(gca,'ylim', [-6000, 6000]);
subplot 235
plot((1:size(clean,1))'/500, clean(:,ch), 'b');
ylabel('fT'); xlabel('s'); title(['ch #',num2str(ch),' after tsr']); set(gca,'ylim', [-6000, 6000]);
subplot 236
plot((1:size(clean2,1))'/500, clean2(:,ch), 'b');
ylabel('fT'); xlabel('s'); title(['ch #',num2str(ch),' after tsr and sns']); set(gca,'ylim', [-6000, 6000]);

set(gcf, 'name', 'Testing sns routine')