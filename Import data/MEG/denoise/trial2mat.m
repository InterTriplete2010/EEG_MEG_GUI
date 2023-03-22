function [y,lengths,w]=trial2mat(trial,channels)
%[y,lengths,w]=trial2mat(trial,channels) - transfer data from FT trial list to 3D matrix
%
%  y: data matrix (time * channels * trials)
%  lengths: vector of trial lengths (samples)
%  w: weight matrix (time * trials)
%
%  trial: trial list (trials * (channels * time))
%  channels: list of channels to keep

if nargin<2; channels=[]; end

% We cater to the case where trials have variable length.  The number of
% samples of the matrix is set to the number of samples of the longest
% trial.  The weight matrix is used to discount parts of the matrix for
% which there are no data.

ntrials=numel(trial);
nchannels=size(trial{1},1);
if isempty(channels)
    channels=1:nchannels;
end

% find maximum trial length
max_length=0;
lengths=zeros(1,ntrials);
for k=1:ntrials
    length=size(trial{k},2);
    lengths(k)=length;
    max_length=max(max_length,length);
end

% transfer to matrix   
y=zeros(max_length,nchannels,ntrials);
w=zeros(max_length,1,ntrials);
for k=1:ntrials
    xx=trial{k};
    y(1:size(xx,2),:,k)=xx';
    w(1:size(xx,2),1,k)=1;
end
