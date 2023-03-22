function trial=mat2trial(x,trial,channels,lengths)
%trial=mat2trial(x,trial,channels,lengths) - transfer data from 3D matrix to FT trial list
%
%  trial: data list (trials * (channels * time))
%
%  x: data matrix (time * channels * trials)
%  trial: FT data list to store data into 
%  channels: channel numbers
%  lengths: list of trial lengths (samples)
%  

if nargin<4; lengths=[]; end
if nargin<3; channels =[]; end
if nargin<2; trial=[]; end

[m,n,o]=size(x);

if isempty(lengths); 
    lengths=m*ones(1,o);    % all trials the same length
end
lengths=lengths(:)';
if numel(lengths)~=o; error('!'); end

if isempty(trial)
    trial=cell(1,o);
    for k=1:o
        trial{k}=x(1:lengths(k),:,k)';
    end
else
    if isempty(channels)
        for k=1:o
            trial{k}=x(1:lengths(k),:,k)';
        end
    else
        for k=1:o
            xx=trial{k}';
            xx=xx(1:lengths(k),:);
            xx(:,channels)=x(:,:,k);
            trial{k}=xx';
        end
    end
end
