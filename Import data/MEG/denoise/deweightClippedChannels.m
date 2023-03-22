function output = deweightClippedChannels(...
    data,...
    goodChannels,...
    numberExtraZeros,...
    clippingChannelsThreshold)
%
% -----------------------------------------------------------------------------------

% -----------------------------------------------------------------------------------
% Author: Dan Hertz dbhertz@umd.edu
% for the Computational Sensorimotor Systems Lab (CSSL) UMCP
% http://www.isr.umd.edu/Labs/CSSL/
% Version 2.1 Jan 21 2008

% Always prompt for source file and excluded channels

if nargin < 4
    clippingChannelsThreshold = 4;
end;

if nargin < 3
    % Set default values
    numberExtraZeros = 0;
end;

if nargin < 2
    % Set default values
    goodChannels = [1:157];
end;

if nargin < 1
    % Set default values
    numberExtraZeros = 0;
    sourceFile =...
        '/Users/dbhertz/Documents/Matlab/dummyWeighting.sqd';
    sizeOfBlock = 10000;
    data = sqdread(sourceFile,...
        'Channels',[0:156],...
        'Samples',[1 sizeOfBlock]) ;
end;
[timeOfData,numChannels] = size(data);
diffOfChannels = diff(data);
clips = diffOfChannels==0;

newClips = zeros(size(clips,1)+2,size(clips,2));
newClips( 2:end-1, :) = clips;
diffOfClips = diff(newClips);
%diffOfClips = diffOfClips(2:end-1,:);
[endOfClips,clipChannelEnd] = find(diffOfClips== -1);
[beginOfClips,clipChannelBegin] = find(diffOfClips== 1);

if clipChannelEnd ~= clipChannelBegin
    error('problem');
end;

clipStart = find(diffOfClips== 1);
clipEnd = find(diffOfClips== -1);
lengthOfClips = clipEnd-clipStart;
longClips = (lengthOfClips>clippingChannelsThreshold);

clipsStartToFilter = clipStart(longClips);
clipsEndToFilter = clipEnd(longClips);
%lengthOfClips = endOfClips-beginOfClips;
%longClips = (lengthOfClips>clippingChannelsThreshold);
numberLongClips = sum(longClips);

%clippedChannels = clipChannelBegin(longClips);
%lengthOfClips = lengthOfClips(longClips);
%locationOfClips = beginOfClips(longClips);

fullweights = ones(size(data,1),size(data,2));
% weight = ones(size(data,1),1);
% weight(longClips) = 0;
for thisClip = 1:size(clipsStartToFilter)
    fullweights(clipsStartToFilter(thisClip):clipsEndToFilter(thisClip)) = 0;
end

shiftedWeights = ones(size(data,1)+numberExtraZeros*2,size(data,2),numberExtraZeros*2);

for loop = 1:numberExtraZeros*2+1
       shiftedWeights(loop:end-numberExtraZeros*2-1+loop,:,loop) = fullweights;
end

paddedWeights = min(shiftedWeights,[],3);
output = paddedWeights(numberExtraZeros+1:end-numberExtraZeros,:);

totalClips = sum(output ==0,1);
fractionOfTimeClipping = totalClips/timeOfData;

badlyClippingChannels = fractionOfTimeClipping >0.5;

if sum(badlyClippingChannels) ~=0
    error(['The following channels are saturating or dead more than half the time: ' num2str(goodChannels(find(badlyClippingChannels > 0)) -1 )]);   
end;