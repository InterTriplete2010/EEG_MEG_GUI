% test tsr routine (tspca)
%

% basic tests
disp('basic tests...');
x=rand(100);
ref=x(:,1:10);
disp('1')
z=tsr(x,ref);
shifts=0;
disp('2')
z=tsr(x,ref,shifts);
shifts=0:10;
disp('3')
z=tsr(x,ref,shifts);
shifts=-10:10;
disp('4')
z=tsr(x,ref,shifts);
wx=ones(size(x,1),1,size(x,3));
wref=ones(size(ref,1),1,size(ref,3));
disp('5')
z=tsr(x,ref,shifts,wx,wref);
keep=10;
disp('6')
z=tsr(x,ref,shifts,wx,wref,keep);
thresh=10.^-12;
disp('7')
z=tsr(x,ref,shifts,wx,wref,[],thresh);
x=rand([100,100,10]);
wx=ones([100,1,10]);
ref=x(:,1:10,:);
wref=ones([100,1,10]);
disp('8')
z=tsr(x,ref,shifts,wx,wref,[],thresh);
disp('...done');

clear

% scalar regression
t=(1:1000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
shifts=[0];     % zero shift == scalar regression
z1=tsr(xx,ref,shifts);
N=70;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
shifts=[0];     % zero shift == scalar regression
z2=tsr(xx,ref,shifts);
figure(1)
subplot 141
imagescc(x); title('signal');
subplot 142
imagescc(xx); title('w noise (3 components)');
subplot 143
imagescc(z1); title('denoised (3 comp)');
subplot 144
imagescc(z2); title('denoised (70 comp)');
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
n2=sum((x(:)-z1(:)).^2)/sum(x(:).^2);
n3=sum((x(:)-z2(:)).^2)/sum(x(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, after TSR (3): ',num2str(10*log10(n2)), ' dB, after TSR (70): ',num2str(10*log10(n3)), ' dB']);


% effect of adding irrelevant regressors
t=(1:1000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
shifts=[0];     % zero shift == scalar regression
z1=tsr(xx,ref,shifts);
NN=70; % number of irrelevant regressors
ref=[ref,randn(size(ref,1),NN)];
shifts=[0];     % zero shift == scalar regression
z2=tsr(xx,ref,shifts);
figure(2)
subplot 141
imagescc(x); title('signal');
subplot 142
imagescc(xx); title('w noise');
subplot 143
imagescc(z1); title('denoised');
subplot 144
imagescc(z2); title('70 irrel comp');
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
n2=sum((x(:)-z1(:)).^2)/sum(x(:).^2);
n3=sum((x(:)-z2(:)).^2)/sum(x(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, after TSR: ',num2str(10*log10(n2)), ' dB, 70 irrel comp: ',num2str(10*log10(n3)), ' dB']);


% weights
t=(1:1000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
shifts=[0];     % zero shift == scalar regression
[z1,idx,mn,w1]=tsr(xx,ref,shifts);
w=ones(size(x,1),1);  w(1:end*(1/4))=0;
[z2,idx,mn,w2]=tsr(xx,ref,shifts,w);
[z3,idx,mn,w3]=tsr(xx,ref,shifts,w,w);
figure(3)
subplot 151
imagescc(x); title('signal');
subplot 152
imagescc(xx); title('w noise');
subplot 153
imagescc(z1); title('no weight');
subplot 154
imagescc(z2); title('x weight');
subplot 155
imagescc(z3); title('x&ref weight');
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
n2=sum((x(:)-z1(:)).^2)/sum(x(:).^2);
n3=sum((x(:)-z2(:)).^2)/sum(x(:).^2);
n4=sum((x(:)-z3(:)).^2)/sum(x(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no w: ',num2str(10*log10(n2)), ' dB, w wx: ',num2str(10*log10(n3)), ' dB, w wx&wref: ',num2str(10*log10(n4)), ' dB']);

% effect of increasing weights
t=(1:1000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
shifts=[0];     % zero shift == scalar regression
[z1,idx,mn,w1]=tsr(xx,ref,shifts);
thresh=0.25;
w=ones(size(x,1),1);  w(find(rand(size(w))>thresh))=0;
[z2,idx,mn,w2]=tsr(xx,ref,shifts,w);
thresh=0.1;
w=ones(size(x,1),1);  w(find(rand(size(w))>thresh))=0;
[z3,idx,mn,w3]=tsr(xx,ref,shifts,w,w);
figure(4)
subplot 151
imagescc(x); title('signal');
subplot 152
imagescc(xx); title('w noise');
subplot 153
imagescc(z1); title('no weight');
subplot 154
imagescc(z2); title('75% zero w');
subplot 155
imagescc(z3); title('90% zero w');
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
n2=sum((x(:)-z1(:)).^2)/sum(x(:).^2);
n3=sum((x(:)-z2(:)).^2)/sum(x(:).^2);
n4=sum((x(:)-z3(:)).^2)/sum(x(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no w: ',num2str(10*log10(n2)), ' dB, 75%: ',num2str(10*log10(n3)), ' dB, 90%: ',num2str(10*log10(n4)), ' dB']);


% delays (ref not delayed)
t=(1:1000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
shifts=[0];     % zero shift == scalar regression
[z1,idx1,mn,w1]=tsr(xx,ref,shifts);
shifts=[0:10];  
[z2,idx2,mn,w2]=tsr(xx,ref,shifts);
shifts=[-10:10];  
[z3,idx3,mn,w3]=tsr(xx,ref,shifts);
figure(5)
subplot 251
imagescc(x); title('signal');
subplot 252
imagescc(xx); title('w noise');
subplot 253
imagescc(z1); title('no shift');
subplot 254
imagescc(z2); title('[0:10]');
subplot 255
imagescc(z3); title('[-10:10]');
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
xx=x(idx1,:,:); n2=sum((xx(:)-z1(:)).^2)/sum(xx(:).^2);
xx=x(idx2,:,:); n3=sum((xx(:)-z2(:)).^2)/sum(xx(:).^2);
xx=x(idx3,:,:); n4=sum((xx(:)-z3(:)).^2)/sum(xx(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no shift: ',num2str(10*log10(n2)), ' dB, [0:10]: ',num2str(10*log10(n3)), ' dB, [-10:10]: ',num2str(10*log10(n4)), ' dB']);
% delays (ref delayed)
xx=x+circshift(noise,-5);                       % add to signal with delay
ref=noisecomps;                                 % references
shifts=[0];     % zero shift == scalar regression
[z1,idx1,mn,w1]=tsr(xx,ref,shifts);
shifts=[0:10];  
[z2,idx2,mn,w2]=tsr(xx,ref,shifts);
shifts=[-10:10];  
[z3,idx3,mn,w3]=tsr(xx,ref,shifts);
figure(5)
subplot 256
imagescc(x); title('signal');
subplot 257
imagescc(xx); title('w noise');
subplot 258
imagescc(z1); title('no shift');
subplot 259
imagescc(z2); title('[0:10]');
subplot (2,5,10);
imagescc(z3); title('[-10:10]');
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
xx=x(idx1,:,:); n2=sum((xx(:)-z1(:)).^2)/sum(xx(:).^2);
xx=x(idx2,:,:); n3=sum((xx(:)-z2(:)).^2)/sum(xx(:).^2);
xx=x(idx3,:,:); n4=sum((xx(:)-z3(:)).^2)/sum(xx(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no shift: ',num2str(10*log10(n2)), ' dB, [0:10]: ',num2str(10*log10(n3)), ' dB, [-10:10]: ',num2str(10*log10(n4)), ' dB']);

% delays and weights
t=(1:1000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
w=ones(size(x,1),1);  w(1:end*(1/4))=0;
shifts=[-10:10];  
[z1,idx1,mn,w1]=tsr(xx,ref,shifts);
[z2,idx2,mn,w2]=tsr(xx,ref,shifts,w);
[z3,idx3,mn,w3]=tsr(xx,ref,shifts,w,w);
figure(6)
subplot 251
imagescc(x); title('signal'); set(gca,'clim',[-1.5 1.5])
subplot 252
imagescc(xx); title('w noise'); set(gca,'clim',[-1.5 1.5])
subplot 253
imagescc(z1); title('no weight'); set(gca,'clim',[-1.5 1.5])
subplot 254
imagescc(z2); title('x weighted'); set(gca,'clim',[-1.5 1.5])
subplot 255
imagescc(z3); title('x&ref weighted'); set(gca,'clim',[-1.5 1.5])
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
xx=x(idx1,:,:); n2=sum((xx(:)-z1(:)).^2)/sum(xx(:).^2);
xx=x(idx2,:,:); n3=sum((xx(:)-z2(:)).^2)/sum(xx(:).^2);
xx=x(idx3,:,:); n4=sum((xx(:)-z3(:)).^2)/sum(xx(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no weight: ',num2str(10*log10(n2)), ' dB, X weighted: ',num2str(10*log10(n3)), ' dB, X&REF weighted: ',num2str(10*log10(n4)), ' dB']);

% delays and weights (signal has glitch and needs weighting)
t=(1:2000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
xx(1:end*(1/10),:)=0;                           % GLITCH
w=ones(size(x,1),1);  w(1:end*(1/4))=0;
shifts=[-10:10];  
[z1,idx1,mn,w1]=tsr(xx,ref,shifts);
[z2,idx2,mn,w2]=tsr(xx,ref,shifts,w);
[z3,idx3,mn,w3]=tsr(xx,ref,shifts,w,w);
figure(6)
subplot 256
imagescc(x); title('signal'); set(gca,'clim',[-1.5 1.5])
subplot 257
imagescc(xx); title('w noise'); set(gca,'clim',[-1.5 1.5])
subplot 258
imagescc(z1); title('no weight'); set(gca,'clim',[-1.5 1.5])
subplot 259
imagescc(z2); title('x weighted'); set(gca,'clim',[-1.5 1.5])
subplot (2,5,10);
imagescc(z3); title('x&ref weighted'); set(gca,'clim',[-1.5 1.5])
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
y=x(idx1,:,:); n2=sum((y(:)-z1(:)).^2)/sum(y(:).^2);
y=x(idx2,:,:); n3=sum((y(:)-z2(:)).^2)/sum(y(:).^2);
y=x(idx3,:,:); n4=sum((y(:)-z3(:)).^2)/sum(y(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no weight: ',num2str(10*log10(n2)), ' dB, X weighted: ',num2str(10*log10(n3)), ' dB, X&REF weighted: ',num2str(10*log10(n4)), ' dB']);


% delays and weights (ref has glitch and needs weighting)
t=(1:2000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
ref(1:end*(1/10),:)=1;                           % GLITCH
w=ones(size(x,1),1);  w(1:end*(1/4))=0;
shifts=[-10:10];  
[z1,idx1,mn,w1]=tsr(xx,ref,shifts);
[z2,idx2,mn,w2]=tsr(xx,ref,shifts,w);
[z3,idx3,mn,w3]=tsr(xx,ref,shifts,w,w);
figure(7)
subplot 251
imagescc(x); title('signal'); set(gca,'clim',[-1.5 1.5])
subplot 252
imagescc(xx); title('w noise'); set(gca,'clim',[-1.5 1.5])
subplot 253
imagescc(z1); title('no weight'); set(gca,'clim',[-1.5 1.5])
subplot 254
imagescc(z2); title('x weighted'); set(gca,'clim',[-1.5 1.5])
subplot (2,5,5);
imagescc(z3); title('x&ref weighted'); set(gca,'clim',[-1.5 1.5])
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
xx=x(idx1,:,:); n2=sum((xx(:)-z1(:)).^2)/sum(xx(:).^2);
xx=x(idx2,:,:); n3=sum((xx(:)-z2(:)).^2)/sum(xx(:).^2);
xx=x(idx3,:,:); n4=sum((xx(:)-z3(:)).^2)/sum(xx(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no weight: ',num2str(10*log10(n2)), ' dB, X weighted: ',num2str(10*log10(n3)), ' dB, X&REF weighted: ',num2str(10*log10(n4)), ' dB']);
% same, no shifts
t=(1:2000)';
nchans=100;
x=repmat(sin(2*pi*0.001*t),1,nchans);           % signal
N=3;
noisecomps=randn(size(x,1),N);                  % noise components
noise=noisecomps*randn(N,100);                  % mixes 
xx=x+noise;                                     % add to signal
ref=noisecomps;                                 % references
ref(1:end*(1/10),:)=0;                          % GLITCH
w=ones(size(x,1),1);  w(1:end*(1/4))=0;
shifts=[0];  
[z1,idx1,mn,w1]=tsr(xx,ref,shifts);
[z2,idx2,mn,w2]=tsr(xx,ref,shifts,w);
[z3,idx3,mn,w3]=tsr(xx,ref,shifts,w,w);
figure(7)
subplot 256
imagescc(x); title('signal'); set(gca,'clim',[-1.5 1.5])
subplot 257
imagescc(xx); title('w noise'); set(gca,'clim',[-1.5 1.5])
subplot 258
imagescc(z1); title('no weight'); set(gca,'clim',[-1.5 1.5])
subplot 259
imagescc(z2); title('x weighted'); set(gca,'clim',[-1.5 1.5])
subplot (2,5,10);
imagescc(z3); title('x&ref weighted'); set(gca,'clim',[-1.5 1.5])
n1=sum((x(:)-xx(:)).^2)/sum(x(:).^2);
xx=x(idx1,:,:); n2=sum((xx(:)-z1(:)).^2)/sum(xx(:).^2);
xx=x(idx2,:,:); n3=sum((xx(:)-z2(:)).^2)/sum(xx(:).^2);
xx=x(idx3,:,:); n4=sum((xx(:)-z3(:)).^2)/sum(xx(:).^2);
disp(['NL: ', num2str(10*log10(n1)), ' dB, no weight: ',num2str(10*log10(n2)), ' dB, X weighted: ',num2str(10*log10(n3)), ' dB, X&REF weighted: ',num2str(10*log10(n4)), ' dB']);


% Short sample of MEG data contaminated with noise
% sr=500Hz, 1 Hz highpass and 60 Hz notch filters in hardware,
% selected 40 channels (of 160):
load test_tsr.mat;  

% data are in xx
data_channels=1:37;
ref_channels=38:40; 
data=xx(:,data_channels);       % gradiometers over brain
ref=xx(:,ref_channels);         % magnetometers to measure environment noise

dataw=find_outliers(data,2000,10);
dataw=min(dataw,[],2);

refw=find_outliers(ref,2000,20);
refw=min(refw,[],2);

dataw=[]; refw=[];

disp('applying tsr to remove environmental noise...');
shifts=-100:100; % number of delays
clean=tsr(data,ref,shifts,[],dataw,refw);
clean2=sns(clean,10,3);

d=data(1:8000,:); c=clean(1:8000,:); c2=clean2(1:8000,:);
disp([' TSR removed ',num2str(100*(sum(d(:).^2)-sum(c(:).^2))/sum(d(:).^2)),'% of power']);
disp([' SNS removed ',num2str(100*(sum(c(:).^2)-sum(c2(:).^2))/sum(c(:).^2)),'% of power']);

figure(8)
subplot 231;
imagescc(data); ylabel('samples'); xlabel('channels')
title('raw');
subplot 232;
imagescc(clean);
title('after tsr');; ylabel('samples'); xlabel('channels')
subplot 233;
imagescc(clean2);
title('after sns');; ylabel('samples'); xlabel('channels')

ch=30;
subplot 234
pwelch(data(1:4000,ch),512,[],[],500);
 title(['ch #',num2str(ch),' raw']);  set(gca, 'ylim', [-10, 60])
subplot 235
hold on
pwelch(clean(1:4000,ch),512,[],[],500);
 title(['ch #',num2str(ch),' after tsr']);  set(gca, 'ylim', [-10, 60])
subplot 236
hold on
pwelch(clean(1:4000,ch),512,[],[],500);
 title(['ch #',num2str(ch),' after tsr']);  set(gca, 'ylim', [-10, 60])

set(gcf, 'name', 'Testing tsr routine')