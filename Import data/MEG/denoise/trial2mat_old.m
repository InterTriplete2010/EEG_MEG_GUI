function y=trial2mat(x,channels)
%y=trial2mat(x,channels) - transfer trials from list to 3D matrix
%
%  y: data matrix (time * channels * trials)
%
%  x: data list (trials * (trials * channels))
%  channels: list of channels to keep

if nargin<2; channels=[]; end

o=numel(x);
[n,m]=size(x{1});

if isempty(channels)
    y=zeros(m,n,o);
    for k=1:o
        y(:,:,k)=x{k}';
    end
else
    y=zeros(m,numel(channels),o);
    for k=1:o
        xx=x{k}';
        xx=xx(:,channels);
        y(:,:,k)=xx;
    end
end    
