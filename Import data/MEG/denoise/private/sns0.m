function r=sns0(c,nneighbors,skip,wc)
% r=sns0(c,nneigbors,wc) - sensor noise suppression
%
%   r: denoising matrix
%
%   c: full covariance of data to denoise
%   nneighbors: number of channels to use in projection [default: all]
%   skip: number of neighbors to skip [default: 0]
%   wc: weighted covariance
%
% 


n=size(c,1);

if nargin<2 || isempty(nneighbors); nneighbors=n-1; end
if nargin<3 || isempty(skip); skip=0; end
if nargin<4 || isempty(wc); wc=c; end

r=zeros(size(c));

% normalize
d=sqrt(1./diag(c));
c=vecmult(vecmult(c,d),d');

for k=1:n
 
    c1=c(:,k);                          % correlation of channel k with all other channels
    [c1,idx]=sort(c1.^2,1,'descend');   % sort by correlation
    idx=idx(skip+2:skip+1+nneighbors);  % keep best

    % pca neighbors to orthogonalize them
    c2=wc(idx,idx);
    [topcs,eigenvalues]=pcarot(c2);
    topcs=topcs*diag(1./sqrt(eigenvalues));
    
    % augment rotation matrix to include this channel
    topcs=[1,zeros(1,nneighbors);zeros(nneighbors,1),topcs];
    
    % correlation matrix for rotated data
    c3=topcs'*wc([k;idx],[k;idx])*topcs;
    
    % first row defines projection to clean component k
    c4=c3(1,2:end)*topcs(2:end,2:end)';

    % insert new column into denoising matrix
    r(idx,k)=c4;
end
