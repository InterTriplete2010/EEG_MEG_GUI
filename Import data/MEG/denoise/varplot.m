function varplot(x,mode)
%varplot(x,mode) - plot variance maps (time*trials, time*chans, chans*trials)
%
%  x: data (time * channels * trials)
%  mode: 0:imagescc (default), 1:plot

if nargin<2; mode=0; end

if ~mode


    subplot 221; 
    imagescc(sqrt(unfold(x.^2)));
    ylabel('unfolded time (samples)'); xlabel('channels');

    subplot 222; 
    imagescc(sqrt(squeeze(sum(x.^2,2))));
    ylabel('epoch time (samples)'); xlabel('trials');

    subplot 223; 
    imagescc(sqrt(squeeze(sum(x.^2,3))));
    ylabel('epoch time (samples)'); xlabel('channels');

    subplot 224; 
    imagescc(sqrt(squeeze(sum(x.^2,1))));
    ylabel('channels'); xlabel('trials');

else
    
    subplot 221; 
    plot(sqrt(unfold(x.^2)));
    xlabel('unfolded time (samples)'); title('channels') 
    
    subplot 222; 
    plot(sqrt(squeeze(sum(x.^2,2)))); title('trials')
    xlabel('epoch time (samples)'); 

    subplot 223; 
    plot(sqrt(squeeze(sum(x.^2,3)))); title('channels')
    xlabel('epoch time (samples)'); 

    subplot 224; 
    plot(sqrt(squeeze(sum(x.^2,1)))'); title('channels')
    xlabel('trials'); 
    
end
    