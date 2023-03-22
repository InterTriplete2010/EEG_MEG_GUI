function w=find_outliers(x,toobig1,toobig2)
%w=find_outliers(x,toobig1,toobig2) - find outliers (glitches, etc.).
%
%  w: mask matrix (0: bad, 1: good)
%
%  x: data 
%  toobig1: absolute threshold for glitches
%  toobig2: relative threshold for outliers
%
% Data can be 2D or 3D.  If 3D, data are folded and variance stats are 
% calculated over folded (concatenated) columns.  W is same size as X.
% 
% TOOBIG1 is an absolute threshold that applies to absolute value.  TOOBIG2
% is a threshold that applies to absolute value relative to mean absolute value. 
% For any value above threshold the mask is set to zero, else one.

if nargin<2; error('!'); return; end
if nargin<3; toobig2=[]; end

[m,n,o]=size(x);
x=unfold(x);

% remove mean
x=demean(x);

% apply absolute threshold:
w=ones(size(x));
if ~ isempty(toobig1);
    w(find(abs(x)>toobig1))=0;
    x=demean(x,w);
    w(find(abs(x)>toobig1))=0;
    x=demean(x,w);
    w(find(abs(x)>toobig1))=0;
    x=demean(x,w);
else
    w=ones(size(x));
end


% apply relative threshold
if ~isempty(toobig2);
    X=wmean(x.^2,w);
    X=repmat(X,size(x,1),1);
%     idx=find(x.^2>(X*toobig2));
%     w(idx)=0;
%     idx= x.^2>(X*toobig2);
    w(x.^2>(X*toobig2))=0;
end

w=fold(w,m);
