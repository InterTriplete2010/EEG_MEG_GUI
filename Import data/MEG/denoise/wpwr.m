function [y,tweight]=wpwr(x,w)
%[y,tweight]=wpwr(x,w) - weighted power
%
%  y: weighted ssq of x
%  tweight: total weight
%
%  x: data
%  w: weight
%

if nargin<2; w=[]; end

x=unfold(x);
w=unfold(w);

if isempty(w)
    y=sum(x(:).^2);
    tweight=numel(x);
else
    x=vecmult(x,w);
    y=sum(x(:).^2);
    tweight=sum(w(:));
end