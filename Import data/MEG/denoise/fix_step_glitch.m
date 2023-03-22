function x=fix_step_glitch(x,N,criterion,nodisp)
%y=fix_step_glitch(x,n,criterion) - fix step-like glitches
%
%  y: fixed data
%
%  x: data to fix (column matrix)
%  N: maximum number of recursions (default: 3)
%  criterion: required reduction in variance (default: 100)
%
% This routine assumes that there is a small number of step glitches, each
% with an amplitude much larger than ongoing variations.  

if nargin<4; nodisp=[]; end
if nargin<3||isempty(N); criterion=100; end
if nargin<2||isempty(N); N=3; end

[m,n,o]=size(x);
x=unfold(x);
[x,mn]=demean(x);

[dummy,idx]=max(abs(cumsum(x)));

if N<1; x=x; return; end

y=zeros(size(x));
for k=1:n
    x1=fix_step_glitch(x(1:idx,k),N-1,criterion,1);
    x2=fix_step_glitch(x(idx+1:end,k),N-1,criterion,1);    
    x1=x1-mean(x1);
    x2=x2-mean(x2);
    y(:,k)=[x1;x2];
        
    if(wpwr(x(:,k))/wpwr(y(:,k))) < criterion;
        y(:,k)=x(:,k);    % power reduction is too small, don't change anything
    else
        if isempty(nodisp)
            disp(['WARNING: removing step glitch on channel ',num2str(k)]);
            subplot 121; plot(x(:,k)); title('before glitch removal');
            subplot 122; plot(y(:,k)); title('after glitch removal');
            drawnow; %pause(1);
        end
    end
end
 
y=vecadd(y,mn);
y=fold(y,m);
x=y;
