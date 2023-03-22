function y=sns_weighted(x,nneighbors,skip,w)
% y=sns(x,nneigbors,skip,w) - sensor noise suppression
%
%   y: denoised matrix
%
%   x: matrix  to denoise
%   nneighbors: number of channels to use in projection (default: all)
%   skip: number of closest neighbors to skip (default: 0)
%   w : weights (default: all ones)

% Copyright 2007, 2008 Alain de Cheveigne


% See: 
% de Cheveign\'e, A. and Simon, J. Z. (2007). "Sensor Noise Suppression." 
% Journal of Neuroscience Methods in press.
%
% The basic idea is to project each channel of X on a basis formed by the
% orthogonalized set of other channels. Supposing (a) that sensor noise is
% uncorrelated across sensors, and (b) genuine signal is correlated, sensor
% noise is removed and genuine signal preserved. 
% 
% Implementation issues:
% - Data are often available as an array of epochs. This implementation
% caters for 3D data (time * channnels * trials);
% - It is important to deemphasize high amplitude artifacts and glitches
% so that they do not dominate the solution.  This implementation uses
% weighted covariance and means.
% - Processing assumes zero-means data. Means are calculated with weights.
% - The implementation tries to be efficent and minimize memory requirements
% so as to handle large data sets.
%
% Larger data sets (disk based) could be handled by performing mean and
% covariance calculations block-by-block, in several passes.


if nargin<4; w=[]; end
if nargin<3 || isempty(skip); skip=0; end
if nargin<2 || isempty(nneighbors); nneighbors=size(x,2)-1; end
if ~isempty(w) && sum(w(:))==0; error('weights are all zero!'); end

[m,n,o]=size(x);
x=unfold(x);

[x,mn0]=demean(x);  % remove mean
[c,nc]=tscov(x);    % raw covariance


% sns matrix
if ~isempty(w);
    w=unfold(w);
    [x,mn1]=demean(x,w);
    [wc,nwc]=tscov_dan(x,[],w);                     % weighted covariance
    r=sns0(c,nneighbors,skip,wc);
else
    mn1=0;
    w=ones(n,o);
    r=sns0(c,nneighbors,skip,c);
end

% apply to data
y=x*r;

y=fold(y,m);

mn=mn0+mn1;
