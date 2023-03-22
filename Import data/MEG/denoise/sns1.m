function y=sns1(x,nneighbors,skip)
% y=sns1(x,nneigbors,skip) - sensor noise suppression (version for size(x,2) large)
%
%   y: clean data
%
%   x: data to denoise
%   nneighbors: number of channels to use in projection [default: all]
%   skip: number of closest neighbors to skip [default: 0]
%

% Copyright 2007, 2008 Alain de Cheveigne

if ndims(x)>2; error('SNS1 works only for 2D matrices'); end
[m,n]=size(x);

if nargin<2 || isempty(nneighbors); nneighbors=n-1; end
if nargin<3 || isempty(skip); skip=0; end

mn=mean(x);
x=vecadd(x,-mn);    % remove mean
N=sqrt(sum(x.^2));
NN=1./N; 
NN(find(isnan(NN)))=0;
x=vecmult(x,NN);    % normalize

y=zeros(size(x));

for k=1:n
        
    c1=x'*x(:,k);                       % correlation with neighbors
    c1=c1/c1(k);
    c1(k)=0;                            % demote self
    [c1,idx]=sort(c1.^2,1,'descend');   % sort
    idx=idx(1+skip:nneighbors+skip);              % keep best
    
    %plot(c1); drawnow

    % pca neighbors to orthogonalize them
    xx=x(:,idx);
    c2=xx'*xx;
    [topcs,eigenvalues]=pcarot(c2);
    topcs=topcs*diag(1./sqrt(eigenvalues));
    
    y(:,k)=tsregress(x(:,k),xx*topcs);
    
    if 0==mod(k,1000);
        [k 100*sum(y(:,1:k).^2)/sum(x(:,1:k).^2)]
    end
end

y=vecmult(y,N);     % restore norm
