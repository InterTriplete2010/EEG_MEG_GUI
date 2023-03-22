function y=remove_redundant_channels(x,N)
%y=remove_redundant_channels(x,N) - remove channels predictable by others
%
%  y: remaining channels
%  
%  x: data (samples x channels)
%  N: number of channels to keep

[m,n,o]=size(x);
x=unfold(x);
x=demean(x);
x=normcol(x);

while (size(x,2)>N)

    % regress each channel on all other channels
    rr=zeros(1,size(x,2));
    for k=1:size(x,2);
        a=x(:,1);
        b=x(:,2:end);
        [c,ii]=tsregress(a,b, -1:1);
        rr(k)=wpwr(c)/wpwr(a(ii,:));
        x=circshift(x,[0 -1]);
       % imagescc(x); drawnow
    end
    plot(rr); drawnow;
    
    % channel with best regression
    [dummy,idx]=max(rr);
    [idx max(rr)]
    
    % discard that channel
    x(:,idx)=[];
end

y=fold(x,m);
