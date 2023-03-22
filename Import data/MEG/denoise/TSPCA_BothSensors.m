function outputInfo = TSPCA_BothSensors(...
    sizeOfBlocks,...
    shifts,...
    sourceFile,...
    excludedChannels,...
    doWeZeroSaturatedChannels,...
    channelForSaturatingChannels,...
    outputFile...
    )
% This function reads in from a sqd file: 157 neuronal channels, 3 reference 
% channels, 32 trigger and all other information channels, including 3
% vibrational sensors channels. It filters the neuronal channels based on
% the 3 reference channels AND the 3 vibrational channels combined and then
% creates a new sqd file with the filtered neuronal data and everything else
% unmodified. The method is the TSPCA (tsr).
% -----------------------------------------------------------------------------------
% If 8 arguments are specified, they must be (in order):
% sizeOfBlocks : size of the block to be processed at a time. 
%                The default of this is 50k, corresponding to 50s for a 1kHz
%                sample frequency.
% shifts       : the amount by which we will allow the TSPCA time shift 
%                regression to move. The default is -50:50.
% sourceFile                   : the complete path and filename of the
%                                input file.
% excludedChannels             : In the format [a b c d] this is a list of
%                                channels to exclude from noise reduction
%                                and set to zero. The numbering of channels
%                                follows the MEG160 convention (starting at
%                                0). If a channel is dead and is not included
%                                in this list, sqdDenoise will return an
%                                error.
% doWeZeroSaturatedChannels    : This argument must be either 'yes' or
%                                'no' (including quotation marks). 
%                                'yes' means that saturating channels
%                                are set equal to zero for times at which
%                                they are saturating. 'no' means that they
%                                are left at their saturating values.
% channelForSaturatingChannels : This is the trigger line (160-188) you wish
%                                to use to store the times when clipping 
%                                channels are present. Do not enter a
%                                trigger line which you use for your analysis,
%                                as the content of that trigger line will
%                                be overwritten.
% outputFile                   : The complete path and filename of the
%                                output file.
% -----------------------------------------------------------------------------------
%
% If an output argument is specified, it will contain a list of
% parameters used and the time taken to run the denoising.
% -----------------------------------------------------------------------------------
% Author: Dan Hertz dbhertz@umd.edu
% for the Computational Sensorimotor Systems Lab (CSSL) UMCP
% http://www.isr.umd.edu/Labs/CSSL/
% Version 1.0 Sep 15 2010

%if all arguments are specified

if nargin == 7,
    % All arguments specified 
    disp('Script-mode: User-specified values for all parameters');
    disp(['sizeOfBlocks is ', num2str(sizeOfBlocks)]);
    disp(['Shifts are in range of ', ...
        num2str(min(shifts)), ' to ', ...
        num2str(max(shifts))]);
    disp(['sourceFile is ', sourceFile]);
    disp(['excludedChannels are ', num2str(excludedChannels)]);
    if strcmp(doWeZeroSaturatedChannels, 'yes') == 1
        doNotZeroSaturatedChannels = 0;
        disp('Channels which are saturating are set to zero for saturated times');
    elseif strcmp(doWeZeroSaturatedChannels, 'no') == 1
        doNotZeroSaturatedChannels = 1;
        disp('Channels which are saturating are left at saturating values for saturated times');
    else
        error('Invalid response for zeroing saturated channels');
    end
    disp(['Trigger line to which the presence of a saturating channel is written is ',...
        num2str(channelForSaturatingChannels)]);
    disp(['Using custom output file ', outputFile]);
    customOutputFile = 1;

else
    error('sqdDenoise being called with an incorrect number of arguments!');
end;


[pathstr,name,ext] = fileparts(sourceFile);
if customOutputFile == 0
    destinationFile = fullfile(pathstr,[name '-Filtered' ext ]);
else
    destinationFile = outputFile;
end;
    disp(['destinationFile is ', destinationFile]);

if exist(destinationFile,'file'),
    delete(destinationFile);
end;

%extract info
info = sqdread(sourceFile,'info');

t0 = clock;
% Create a copy of the source file as the destination file
copyfile(sourceFile,destinationFile);
fileattrib(destinationFile,'+w');

%Input parameters
%--------------------------------------------------------------
offset1 = max(0,-min(shifts));
offset2 = max(0,max(shifts)); 
blockIncrement = sizeOfBlocks - offset1 - offset2;

%total number of samples and channels
numSamples = info.SamplesAvailable;
totalNumChans = info.ChannelCount;
allChannels = 0:totalNumChans-1;

totalBlocks = floor((numSamples-1)/blockIncrement);


%Put stuff into outputInfo
outputInfo.numSamples = numSamples;
outputInfo.sampleFreq = info.SampleRate;
outputInfo.sizeOfBlocks = sizeOfBlocks;
outputInfo.sourceFile = sourceFile;
outputInfo.destinationFile = destinationFile;
outputInfo.shifts = shifts;
outputInfo.excludedChannels = excludedChannels;
outputInfo.channelForSaturatingChannels = channelForSaturatingChannels;

% Change to using info-block as the sqdTemplate
sqdTemplate = sourceFile;
% sqdTemplate = info;

% shift excluded channels by 1 so that they match up with Matlab numbering
% scheme instead of MEG160 numbering.
excludedChannels = excludedChannels + 1;
goodChannels = setdiff((1:157),excludedChannels);

thisBlockMin = 0;
thisBlockMax = 0;

%--------------------------------------------------------------
thisWaitBar = waitbar(0,'Please wait...');
% for thisBlock = totalBlocks,
for thisBlock = 1:totalBlocks,
	% Start at entry 1 because there is no sample 0
    disp(['blockNumber is ', num2str(thisBlock)]);
    thisBlockMin = (thisBlock-1)*blockIncrement + 1;
    thisBlockMax = (thisBlock-1)*blockIncrement + sizeOfBlocks;
    newIndex = 1+offset1:sizeOfBlocks-offset2;
    % where are we putting this into the sqd file array
    insertLow = thisBlockMin + offset1;
    insertHigh = thisBlockMax - offset2;

    combinedInput = sqdread(sourceFile,...
        'Channels',allChannels,...
        'Samples',[thisBlockMin thisBlockMax]) ;
    
combinedOutput = bodyOfSqdDenoise(...
    newIndex,shifts,combinedInput,...
    goodChannels,totalNumChans,...
    doNotZeroSaturatedChannels,channelForSaturatingChannels);
    %sqdwrite goes here
    sqdwrite(sqdTemplate,destinationFile,...
        'Action','Overwrite',...
        'Channels',allChannels,...
        'Samples',[insertLow insertHigh],...
        'Data', combinedOutput);

    waitbar(thisBlock/totalBlocks,thisWaitBar);
end %thisBlock
%--------------------------------------------------------------
%append last fraction of a block if there is any
if thisBlockMax < numSamples,
	disp('Need one more block');
    
	thisBlockMin = blockIncrement*totalBlocks + 1;
	thisBlockMax = numSamples;
    lastBlockSamples = thisBlockMax - thisBlockMin + 1;
    newIndex = 1+offset1:lastBlockSamples-offset2;
    % where are we putting this into the sqd file array
    insertLow = thisBlockMin + offset1;
    insertHigh = thisBlockMax - offset2;

    % read in the data
    combinedInput = sqdread(sourceFile,...
        'Channels',allChannels,...
        'Samples',[thisBlockMin thisBlockMax]);
 
  combinedOutput = bodyOfSqdDenoise(...
      newIndex,shifts,combinedInput,...
    goodChannels,totalNumChans,...
    doNotZeroSaturatedChannels,channelForSaturatingChannels);

    %sqdwrite goes here
    sqdwrite(sqdTemplate,destinationFile,...
        'Action','Overwrite',...
        'Channels',allChannels,...
        'Samples',[insertLow insertHigh],...
        'Data', combinedOutput);

end

% Zero the first and last SHIFT of the destinationFile
zeroFirstAndLastShifts(sqdTemplate, destinationFile, offset1, offset2, numSamples);

close(thisWaitBar);
timeTaken = etime(clock,t0);

outputInfo.processtime = timeTaken;


function combinedOutput = bodyOfSqdDenoise(...
    newIndex,shifts,combinedInput,...
    goodChannels,totalNumChans,...
    doNotZeroSaturatedChannels,channelForSaturatingChannels)

cleanOut = zeros(size(newIndex,2), 157);

% demean the data channels here (but not reference or trigger)
%Edited 9/9/09 to the following:
rawSensors = combinedInput(newIndex, goodChannels);
sensorChannelsIn = demean(combinedInput(:, goodChannels));
refChannelsIn = combinedInput(:, 158:160);
vibChannelsIn = combinedInput(:, 190:192);
denoiseChannelsIn = [refChannelsIn vibChannelsIn];
triggerChannelsIn = combinedInput(:, 161:totalNumChans);
% Calculate a weight matrix for tspca based on the channels
% that may be clipping
weightsForTSPCA = deweightClippedChannels(sensorChannelsIn, goodChannels);
weightsByTimeTSPCA = min(weightsForTSPCA,[],2);
weightsForSNS = weightsByTimeTSPCA(newIndex,:);
weightsToRestore = weightsForTSPCA(newIndex,:);
weightsAreZero = weightsToRestore==0;
%--------------------------------------------------------------

tspca_out = tsr_dan(sensorChannelsIn,denoiseChannelsIn, shifts, weightsByTimeTSPCA);
sns_out = tspca_out;
% Write back the value for saturating times and channels
% Data before demeaning is:
sns_out(weightsAreZero) = rawSensors(weightsAreZero)*doNotZeroSaturatedChannels;
cleanOut(:, goodChannels) = sns_out;

% clip the length of the reference and trigger
refChannelsOut = refChannelsIn(newIndex, : );
triggerChannelsOut = triggerChannelsIn(newIndex, : );
% set the contents of a trigger channel to be when channels are
% saturating. 4000 = baseline of 4 V.
triggerChannelsOut(:,channelForSaturatingChannels-159) = 4000*min(weightsForSNS,[],2);

% Combine the output back into one array
combinedOutput = [cleanOut refChannelsOut triggerChannelsOut];

function zeroFirstAndLastShifts(sqdTemplate, destinationFile, offset1, offset2, numSamples)

zeroOut = zeros(offset1, 157);
insertLow = 1;
insertHigh = offset1;

sqdwrite(sqdTemplate,destinationFile,'Action','Overwrite','Channels',...
    [0:156],'Samples',[insertLow insertHigh], 'Data', zeroOut);

zeroOut = zeros(offset2, 157);
insertLow = numSamples - offset2 + 1;
insertHigh = numSamples;
sqdwrite(sqdTemplate,destinationFile,'Action','Overwrite','Channels',...
    [0:156],'Samples',[insertLow insertHigh], 'Data', zeroOut);
