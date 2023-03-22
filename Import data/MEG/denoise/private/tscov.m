function [c,tw]=tscov(x,shifts,w);
%[c,tw]=tscov(x,shifts,w) - time shift covariance
%
%  c: covariance matrix
%  tw: total weight (c/tw is normalized covariance)
%
%  x: data
%  shifts: array of time shifts (must be non-negative)
%  w: weights
%  
% This function calculates, for each pair [X(i),X(j)] of columns of X, the
% cross-covariance matrix between the time-shifted versions of X(i). 
% Shifts are taken from array SHIFTS. Weights are taken from W.
%
% X can be 1D, 2D or 3D.  W is 1D (if X is 1D or 2D) or 2D (if X is 3D).
% 
% Output is a 2D matrix with dimensions (ncols(X)*nshifts)^2.
% This matrix is made up of an ncols(X)^2 matrix of submatrices
% of dimensions nshifts^2.
% 
% The weights are not shifted. 

if nargin<3; w=[]; end;
if nargin<2||isempty(shifts); shifts=0; end;

if min(shifts)<0; error('shifts should be non-negative'); end

shifts=shifts(:);           % --> column vector
nshifts=numel(shifts); 

[m,n,o]=size(x);
c=zeros(n*nshifts);

if isempty(w)
    % no weights
    
    for k=1:o
        xx=multishift(x(:,:,k),shifts);
        c=c+xx'*xx;
    end
    tw=size(xx,1)*o;
    
else
    % weights
    if size(w,2)>1; error('w should have single column'); end
    
    for k=1:o
         xx=multishift(x(:,:,k),shifts);
         ww=w(1:size(xx,1),:,k);
         xx=vecmult(xx,ww);
         c=c+xx'*xx;
    end
    tw=sum(w(:));
end

