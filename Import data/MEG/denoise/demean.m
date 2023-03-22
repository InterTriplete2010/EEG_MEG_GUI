function [x,mn]=demean(x,w)
%[y,mn]=demean(x,w) - remove weighted mean over cols

if nargin<2; w=[]; end
if nargin<1; error('!');end

[m,n,o]=size(x);
x=unfold(x);

if isempty(w);
    
    mn=mean(x,1);
    %y=bsxfun(@minus,x,mn);
    x=vecadd(x,-mn);
    
else
    
    w=unfold(w);
    
    if size(w,1)~=size(x,1); error('X and W should have same nrows & npages'); end
    if size(w,2)==1;
        mn=sum(vecmult(x,w),1) ./ sum(w,1);
    elseif size(w,2)==n;
        mn=sum(x.*w) ./ sum(w,1);
    else
        error('W should have same number of cols ans X, or else 1');
    end

    %y=bsxfun(@minus,x,mn);
    x=vecadd(x,-mn);
    
end

x=fold(x,m);
