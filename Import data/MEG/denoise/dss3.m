function [todss,fromdss,ratio,pwr]=dss3(x,w,keep1,keep2)
%[todss,fromdss,ratio,pwr]=dss1(x,w,keep1,keep2) - evoked-biased DSS denoising
%
%  todss: denoised matrix
%  fromdss: project selected components back to sensor space
%  gain: evoked/total power ratio per DSS component
%  pwr: power per DSS component
%
%  x: data to denoise (time * channels * trials)
%  w: weight
%  keep1: (in DSS0) number of PCs to retain (default: all)
%  keep2: (in DSS0) ignore PCs smaller than keep2 (default: 10.^-12)

if nargin<4; keep2=10.^-12; end
if nargin<3; keep1=[]; end
if nargin<2; w=[]; end
if nargin<1; error('!'); end

[m,n,o]=size(x);
[x,mn]=demean(x,w);                            % remove weighted mean    

% weighted average over trials (--> bias function for DSS)
[xx,ww]=mean_over_trials(x,w);
ww=min(ww,[],2);

%xx=mean(x,3);

% covariance of raw and biased data

% For the covariance matrix I need to get a different w which is only
% in two dimensions.

[c0,nc0]=tscov_dan(x,[],w);


[c1,nc1]=tscov_dan(xx,[],ww); 

c1=c1/o;

% derive DSS matrix
[todss,fromdss,ratio,pwr]=dss_dan(c0,c1,keep1,keep2);


%[todss,fromdss,ratio,pwr]=dss0(c0,c1);
