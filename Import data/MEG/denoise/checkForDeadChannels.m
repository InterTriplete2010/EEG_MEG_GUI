function output = checkForDeadChannels(sqdFile)
% This function looks through an entire sqd file and checks to see what
% channels in it are clipping/saturating or dead somewhere in the file. The
% output of the function is an array of bad channels.
% Arguments of the function are: 
% sqdFile: This is full path and name of the sqd File to be examined. If
% this variable is not specified, you will be prompted for it.
% -----------------------------------------------------------------------------------
% Author: Dan Hertz dbhertz@umd.edu
% for the Computational Sensorimotor Systems Lab (CSSL) UMCP
% http://www.isr.umd.edu/Labs/CSSL/
% Version 1.0 May 25 2010

if nargin < 1
    % Prompt for a sqdFile
    [fn, pn] = uigetfile('*.sqd','Select your SQD file source');
    if sum(fn==0)&&sum(pn==0)
        return
    end
    sqdFile = fullfile(pn,fn);
end;

% 05/25/11
% Change to using a blocksize of 25k to deal with lack of memory on old
% computers.

blockSize = 25000;
% Get the info from the sqdFile
info = sqdread(sqdFile,'info');
sampleRate = info.SampleRate;
numSamples = info.SamplesAvailable;
totalBlocks = floor((numSamples-1)/blockSize);
thisBlockMax = 0;
disp('Checking for dead channels in file:');
disp(sqdFile);
% disp(['using a block size of ', num2str(blockSize)]);
% Put a loop over the blocks here
for thisBlock = 1:totalBlocks,
	% Start at entry 1 because there is no sample 0
%     disp(['blockNumber is ', num2str(thisBlock)]);
    thisBlockMin = (thisBlock-1)*blockSize + 1;
    thisBlockMax = (thisBlock)*blockSize;
    % read in the data
    data = sqdread(sqdFile,...
        'Channels',[0:156],...
        'Samples',[thisBlockMin thisBlockMax]) ;

    findClips(data,thisBlockMin, thisBlockMax,sampleRate);

    % end the loop over the blocks here
end;

% Add the final block here, if needed
if thisBlockMax < numSamples,
% 	disp('Need one more block');
	thisBlockMin = blockSize*totalBlocks + 1;
	thisBlockMax = numSamples;
    data = sqdread(sqdFile,...
        'Channels',[0:156],...
        'Samples',[thisBlockMin thisBlockMax]);

    findClips(data,thisBlockMin, thisBlockMax,sampleRate);
% end the extra block here
end


function findClips(data,thisBlockMin, thisBlockMax, sampleRate)

clippingChannelsThreshold = 4;
numberExtraZeros = 0;

goodChannels = 1:157;

[timeOfData,numChannels] = size(data);

diffOfChannels = diff(data);
clips = diffOfChannels==0;

newClips = zeros(size(clips,1)+2,size(clips,2));
newClips( 2:end-1, :) = clips;
diffOfClips = diff(newClips);
[dummy,clipChannelEnd] = find(diffOfClips== -1);
[dummy,clipChannelBegin] = find(diffOfClips== 1);

if clipChannelEnd ~= clipChannelBegin
    error('problem');
end;

clipStart = find(diffOfClips== 1);
clipEnd = find(diffOfClips== -1);
lengthOfClips = clipEnd-clipStart;
longClips = (lengthOfClips>clippingChannelsThreshold);

clipsStartToFilter = clipStart(longClips);
clipsEndToFilter = clipEnd(longClips);

fullweights = ones(timeOfData,numChannels);
for thisClip = 1:size(clipsStartToFilter)
    fullweights(clipsStartToFilter(thisClip):clipsEndToFilter(thisClip)) = 0;
end
shiftedWeights = ones(timeOfData+numberExtraZeros*2,numChannels,numberExtraZeros*2);
for loop = 1:numberExtraZeros*2+1
    shiftedWeights(loop:end-numberExtraZeros*2-1+loop,:,loop) = fullweights;
end
paddedWeights = min(shiftedWeights,[],3);
output = paddedWeights(numberExtraZeros+1:end-numberExtraZeros,:);
totalClips = sum(output ==0,1);
fractionOfTimeClipping = totalClips/timeOfData;

badlyClippingChannels = fractionOfTimeClipping >0.5;

%%Saving the bad channels;
bad_channels = goodChannels(badlyClippingChannels > 0) -1 ;

message = (['The following bad channels have been identified: ' num2str(bad_channels)]);

        msgbox(message,'Bad channels','warn','replace');

if sum(badlyClippingChannels) ~=0
    timeOfBlockStart = floor(thisBlockMin/sampleRate);
    timeOfBlockEnd = floor(thisBlockMax/sampleRate);
    disp(['Bad channels from ', num2str(timeOfBlockStart), ' to ', num2str(timeOfBlockEnd),...
        ' seconds: ', num2str(goodChannels(badlyClippingChannels > 0) -1 )]);
    %         disp(['The following channels are clipping or dead more
    %         than half the time: ' num2str(goodChannels(badlyClippingChannels > 0) -1 )]);
end;

