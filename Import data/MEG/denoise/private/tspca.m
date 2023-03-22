function [z,idx]=tspca0(x,shifts,keep,threshold,w)
%[z,idx]=tspca0(x,shifts,keep,threshold,w) - time-shift pca
%
%  z: pcs
%  idx: x(idx) maps to z
%
%  x: data matrix
%  shifts: array of shifts to apply
%  keep: number of components shifted regressor PCs to keep (default: all)
%  threshold: discard PCs with eigenvalues below this (default: 0)
%  w: ignore samples with absolute value above this
%
% mean is removed prior to processing


if nargin<1; error('!'); end
if nargin<2||isempty(shifts); shifts=[0]; end
if nargin<3; keep=[]; end
if nargin<4; threshold=[]; end
if nargin<5; w=[]; end

[m,n,o]=size(x);

% offset of z relative to x
offset=max(0,-min(shifts));
shifts=shifts+offset;           % adjust shifts to make them nonnegative
idx=offset+(1:m-max(shifts));   % x(idx) maps to z

% remove mean
x=fold(demean(unfold(x),w),m);

% covariance
if isempty(w);
    c=tscov(x,shifts);
else
    if sum(w(:))==0; error('weights are all zero!'); end
    c=tscov(x,shifts,w);
end

% PCA matrix
[topcs,evs]=pcarot(c);

% truncate
if ~isempty(keep)
    topcs=topcs(:,1:keep);
    evs=evs(1:keep);
end
if ~isempty (threshold)
    ii=find(evs/evs(1)>threshold);
    topcs=topcs(:,ii);
    evs=evs(ii);
end

%clf; plot(evs); set(gca,'yscale','log'); pause

% apply PCA matrix to time-shifted data
z=zeros(numel(idx),size(topcs,2),o);
for k=1:o
    z(:,:,k)=multishift(x(:,:,k),shifts)*topcs;
end


