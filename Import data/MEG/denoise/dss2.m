function [todss,fromdss,ratio,pwr]=dss2(x,prd,w,keep1,keep2)
%[todss,fromdss,ratio,pwr]=dss2(x,prd,w,keep1,keep2) - max or min periodicity dss
%
%  todss: denoised matrix
%  fromdss: project selected components back to sensor space
%  gain: evoked/total power ratio per DSS component
%  pwr: power per DSS component
%
%  x: data to denoise (time * channels * trials)
%  prd: samples, period to maximize (or minimize if negative)
%  w: weight
%  keep1: (in DSS0) number of PCs to retain (default: all)
%  keep2: (in DSS0) ignore PCs smaller than keep2 (default: 10.^-12)

if nargin<5; keep2=10.^-12; end
if nargin<4; keep1=[]; end
if nargin<3; w=[]; end
if nargin<2; error('!'); end

minus_flag=0;
if prd<0; 
    minus_flag=1;
    prd=-prd;
end

% integer and fractionnary parts
prd_i=floor(prd);
prd_f=prd-prd_i;

[m,n,o]=size(x);

% raw
if ~isempty(w)
    x=demean(x,w);    
    [c0,nc0]=tscov(x,[],w);
else
    x=demean(x);
    [c0,nc0]=tscov(x);
end
c0=c0/o;

idx=1:size(x,1)-prd_i-1;

% biased
if ~isempty(w); 
    w=min([w(idx,:,:), w(idx+prd_i,:,:), w(idx+prd_i+1,:,:)],[],2);
    if minus_flag
        x=x(idx,:,:) - (1-prd_f)*x(idx+prd_i,:,:) + prd_f*x(idx+prd_i+1,:,:);
    else
        x=x(idx,:,:) + (1-prd_f)*x(idx+prd_i,:,:) + prd_f*x(idx+prd_i+1,:,:);
    end
    x=demean(x,w)/2;
    [c1,nc1]=tscov(x,[],w); 
else
    if minus_flag
        x=x(idx,:,:) - (1-prd_f)*x(idx+prd_i,:,:) + prd_f*x(idx+prd_i+1,:,:);
    else
        x=x(idx,:,:) + (1-prd_f)*x(idx+prd_i,:,:) + prd_f*x(idx+prd_i+1,:,:);
    end
    x=demean(x)/2;
    [c1,nc1]=tscov(x); 
end
c1=c1/o;

% derive DSS matrix
[todss,fromdss,ratio,pwr]=dss0(c0,c1,keep1,keep2);
