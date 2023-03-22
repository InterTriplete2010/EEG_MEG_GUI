function [topcs,eigenvalues]=pcarot(cov,keep)
% [topcs,eigenvalues]=pcarot(cov,keep) - PCA rotation from covariance
%
%  topcs: PCA rotation matrix
%  eigenvalues: PCA eigenvalues
%  
%  cov: covariance matrix
%  keep: number of components to keep [default: all]

if nargin<2; keep=size(cov,1); end

[V, S] = eig(cov) ;  
V=real(V);
S=real(S);
[eigenvalues, idx] = sort(diag(S)') ;
eigenvalues=fliplr(eigenvalues);
idx = fliplr(idx);
topcs = V(:,idx);


eigenvalues=eigenvalues(1:keep);
topcs=topcs(:,1:keep);
