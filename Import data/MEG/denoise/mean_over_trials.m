function [y,tw]=mean_over_trials(x,w);
%[y,tw]=mean_over_trials(x,w) - weighted average over trials
%
%  y: weighted average over trials (time*trials)
%  tw: total weight (time*1)
%
%  x: data to average (time*channels*trials)
%  w: weight to apply (time*channels*trials or time*1*trials);

if nargin<2; w=[]; end
if nargin<1; error('!'); end

[m,n,o]=size(x);

if isempty(w); 
    y=mean(x,3); 
    tw=ones(m,n,1)*o;
else
    [mw,nw,ow]=size(w);
    if mw~=m; error('!'); end
    if ow~=o; error('!'); end
    x=unfold(x); 
    w=unfold(w);
    if nw==n;
        x=x.*w;
        x=fold(x,m);
        w=fold(w,m);
        y=sum(x,3)./sum(w,3);
    elseif nw==1;
        x=vecmult(x,w);
        x=fold(x,m);
        w=fold(w,m);
        y=vecmult(sum(x,3),1./sum(w,3));
    end
    tw=sum(w,3);
end

