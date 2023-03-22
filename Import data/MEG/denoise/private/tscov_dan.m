function [covMatrix,totalWeight]=tscov_dan(data,shifts,weights)
%[c,totalWeight]=tscov(data,shifts,weights) - time shift covariance
%
%  covMatrix: covariance matrix
%  totalWeight: total weight (c/totalWeight is normalized covariance)
%
%  data: data
%  shifts: array of time shifts (must be non-negative)
%  weights: weights
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

if nargin<3; weights=[]; end;
if nargin<2||isempty(shifts); shifts=0; end;

if min(shifts)<0; error('shifts should be non-negative'); end

shifts=shifts(:);           % --> column vector
nshifts=numel(shifts); 

[m,n,o]=size(data);
covMatrix=zeros(n*nshifts);

if isempty(weights)
    % no weights
    
    for k=1:o
        shiftedData=multishift(data(:,:,k),shifts);
        covMatrix=covMatrix+shiftedData'*shiftedData;
    end
    totalWeight=size(shiftedData,1)*o;
    
else
    % weights
%     if size(weights,2)>1; error('weights should have single column'); end
    
    for k=1:o
         shiftedData=multishift(data(:,:,k),shifts);
         theseWeights=weights(1:size(shiftedData,1),:,k);
         shiftedData=vecmult(shiftedData,theseWeights);
         covMatrix=covMatrix+shiftedData'*shiftedData;
    end
    totalWeight=sum(weights(:));
end

