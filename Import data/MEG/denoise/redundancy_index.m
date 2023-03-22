function [idx,r]=redundancy_index(x,shifts)
%[idx,r]=redundancy_index(x,shifts) - order channels in terms of decreasing redundancy
%
%  idx: indices of channels in order of decreasing redundancy
%  r: regression coefficients (same order as idx)
%  
%  x: data (samples x channels)
%  shifts: shifts to apply in regression (default: [0])

if nargin<2||isempty(shifts); shifts =[0]; end

[m,n,o]=size(x);
x=unfold(x);
x=demean(x);
x=normcol(x);

idx=zeros(1,n);
r=ones(1,n);

ii=1:n;
for j=1:n-1
    
    % for each channel, regress it on all other channels
    rr=zeros(1,numel(ii));
    for k=1:numel(ii)
        a=x(:,ii(k));
        b=[x(:,ii(1:k-1)),x(:,ii(k+1:end))]; 
        [c,iii]=tsregress(a,b, shifts);
 
        rr(k)=wpwr(c)/wpwr(a(iii,:));
    end    
    
    % channel with best regression
    [dummy,iiii]=max(rr);
    best_channel=ii(iiii);
    
    % record in result arrays
    idx(j)=best_channel;
    r(j)=rr(iiii);

    % discard that channel   
    ii(iiii)=[];
    
    subplot 211; plot(r)
    subplot 212; plot(rr); drawnow
end
idx(n)=ii(end);
r(n)=rr(end);
