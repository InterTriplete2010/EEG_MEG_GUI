function [idx,d,mn,idx_unsorted]=find_outlier_trials(x,proportion,mn)
%[idx,d,mn,idx_unsorted]=find_outlier_trials(x,proportion,mn) - find outlier epochs
%
%  idx: indices of trials to keep
%  d: relative deviations from mean
%  mn: weighted mean
%  
%  x: data (time * channels * trials)
%  proportion: proportion of trials to keep
%  mn: mean (default: calculate from data) (if nan use regression)

if nargin<2; error('!'); end
if nargin<3; mn=[]; end

[m,n,o]=size(x);
x=reshape(x,m*n,o);

if isempty(mn); mn=mean(x,2); end
if isnan(mn)
    mn=tsregress(x,mean(x,2));  % distance from regression
else
    mn=repmat(mn(:),1,o);       % distance from mean
end
d=x-mn;
d=sum(d.^2)/o ./ sum(mn.^2) ;

[dd,idx]=sort(d,'ascend');
idx=idx(1:round(proportion*numel(idx)));
idx_unsorted=idx;
idx=sort(idx); % put them back in natural order
mn=mean(x(:,idx),2);
