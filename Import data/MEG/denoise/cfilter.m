function y=cfilter(x,lag,alpha)
%y=cfilter(x,lag,alpha) - comb filter
%
%  y: filtered signal
%
%  x: signal to filter (columnwise, see filter)
%  lag: lag of comb filter (can be fractionary)
%  alpha: coefficient to apply to lagged signal (default: 1)

if nargin<3; alpha=1; end
if nargin<2; error('too few parameters'); end

nlag=floor(lag);
flag=lag-nlag;

B(1)=1;
B(1+nlag)=alpha*(1-flag);
B(1+nlag+1)=alpha*flag;

B=B/sum(abs(B));    % normalize

y=filter(B,1,x);

