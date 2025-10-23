function outputInfo = sqdDenoise(...
    sizeOfBlocks,...
    shifts,...
    nearNeighbors,...
    sourceFile,...
    excludedChannels,...
    doWeZeroSaturatedChannels,...
    channelForSaturatingChannels,...
    doWeUseVibrationalChannels,...
    outputFile...
    )
% This function reads in from a sqd file: 157 neuronal channels, 3 reference 
% channels, optionally 3 vibrational reference channels as well as 32
% trigger and all other information channels. It filters the 
% neuronal channels based on the 3 (or 6, if vibrational sensors are used) 
% reference channels, then creates a new sqd file with the filtered neuronal
% data and everything else unmodified. 
% The method is the TSPCA (tsr) and SNS.
%
% -----------------------------------------------------------------------------------
% The function can be called with 0, 3, 8 or 9 arguments.
% If 0 inputs are specified, the sourcefile is selected through the pop-up
% window. The following inputs are then prompted for:
%
% Enter the channels to be excluded from analysis (MEG number scheme), 
% e.g. [55 79 125]: 
%       At the prompt enter a list of channels to exclude from the noise
%       reduction and instead set equal to zero for all times because they
%       are dead or too noisy. The format of these channels must be 
%       [a b c d]. The channels are numbered as in MEG160 so that the first
%       channel number is 0. If a channel is dead and is not included in 
%       this list, sqdDenoise will return an error.
%
% Do you want saturating channel values set to zero? (yes or no):
%       At the prompt, enter either 'yes' or 'no' (without quotation 
%       marks). 'yes' means that saturating channels are set equal to zero
%       for times at which they are saturating. 'no' means that they are 
%       left at their saturating values.
%
% Enter the MEG trigger channel to which the presence of a saturating
% channel is written (e.g. 161): 
%       At the prompt enter the trigger line (160-188) you wish to use to
%       store the times when clipping channels are present. Do not enter a
%       trigger line which you use for your analysis, as the content of
%       that line will be overwritten.
%
% Do you want to use vibrational reference channels? (yes or no): 
%       At the prompt enter either 'yes' or 'no' (without quotation
%       marks). 'yes' indicates that vibrational reference sensors will be
%       used for denoising purposes. 'no' indicates that they will not. For
%       data taken since October 1 2010 it is recommended that users select
%       'yes'. For data taken prior to that date you MUST use 'no'. 
%
%
% The output file will be the same as the input with the suffix '-Filtered'
% appended.
% Default values will be used for sizeOfBlocks, shifts and nearNeighbors
% (see below).
% -----------------------------------------------------------------------------------
% If 3 arguments are used, they must be (in order)
%
% sizeOfBlocks : size of the block to be processed at a time. 
%                The default of this is 25k, corresponding to 50s for a 1kHz
%                sample frequency.
% shifts       : the amount by which we will allow the TSPCA time shift 
%                regression to move. The default is -50:50.
% nearNeighbors: the values used for the nearest neighbors for the SNS 
%                filtering. The default is 10. If this is set equal to 0,
%                SNS will not be used in the denoising.
%
% The same prompts will occur as if no arguments were specified.
% Again, the output file is the same as the input with the suffix
%'-Filtered' appended.
% -----------------------------------------------------------------------------------
% If 8 arguments are specified, they must be (in order):
% sizeOfBlocks                 : see above
% shifts                       : see above
% nearNeighbors                : see above
% sourceFile                   : the complete path and filename of the
%                                input file.
% excludedChannels             : In the format [a b c d] this is a list of
%                                channels to exclude from noise reduction
%                                and set to zero. The numbering of channels
%                                follows the MEG160 convention (starting at
%                                0). If a channel is dead and is not included
%                                in this list, sqdDenoise will return an error.
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
% doWeUseVibrationalChannels   : This argument must be either 'yes' or 'no'
%                                (including quotation marks). 'yes' means
%                                that vibrational sensor channels will be
%                                used for denoising. 'no' means that they
%                                will not. For data taken at UMD since October 
%                                1 2010 it is advised that users use 'yes'.
%                                For data taken elsewhere or prior to this 
%                                date you MUST use 'no'.
%
% The output file is the same as the input with the suffix 
% '-Filtered' appended.
% -----------------------------------------------------------------------------------
% If 9 arguments are specified, they must be (in order):
% sizeOfBlocks                 : see above
% shifts                       : see above
% nearNeighbors                : see above
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
% doWeUseVibrationalChannels   : This argument must be either 'yes' or 'no'
%                                (including quotation marks). 'yes' means
%                                that vibrational sensor channels will be
%                                used for denoising. 'no' means that they
%                                will not. For data taken at UMD since October 
%                                1 2010 it is advised that users use 'yes'.
%                                For data taken elsewhere or prior to this 
%                                date you MUST use 'no'.
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
% Version 4.1.1 Sep 19 2011

%if all arguments are specified
if nargin == 0 || nargin == 4 %the condition nargin == 4 has been added to remove the input function, and at the same time to preserve thedefault values
    
    excludedChannels = sizeOfBlocks;

    doWeZeroSaturatedChannels_temp = shifts;
if (doWeZeroSaturatedChannels_temp == 1)
   
    doNotZeroSaturatedChannels = 0;
    
else
    
    doNotZeroSaturatedChannels = 1;
    
end

channelForSaturatingChannels = nearNeighbors;

doWeUseVibrationalChannels_temp = sourceFile;
if (doWeUseVibrationalChannels_temp == 1)
    
    useVibrationalChannels = 1;
    
else
    
    useVibrationalChannels = 0;
    
end

    % Prompt for input
    sizeOfBlocks = 25000;
	shifts = -50:50; 
    nearNeighbors = 10;
    disp(['Setting default sizeOfBlocks of ', num2str(sizeOfBlocks)]);
	disp(['Setting default shifts of to be in range of ',...
        num2str(min(shifts)), ' to ', num2str(max(shifts))]);
	disp(['Setting default nearNeighbors of ', num2str(nearNeighbors)]);
    useSNS = 1;
    [fn, pn] = uigetfile('*.sqd','Select your SQD file source');
    if sum(fn==0)&&sum(pn==0),return,end
    sourceFile = fullfile(pn,fn);
    disp('');
%     % Prompt for excluded channels, clipping parameters
%     excludedChannels = ...
%         input(['Enter the channels to be excluded from'...
%         ' analysis (MEG number scheme), e.g. [55 79 125]: ']);
%     doWeZeroSaturatedChannels = ...
%         input('Do you want saturating channel values set to zero? (yes or no) ','s');
%     if strcmp(doWeZeroSaturatedChannels, 'yes') == 1
%         doNotZeroSaturatedChannels = 0;
%     elseif strcmp(doWeZeroSaturatedChannels, 'no') == 1
%         doNotZeroSaturatedChannels = 1;
%     else
%         error('Invalid response for zeroing saturated channels');
%     end    
%     channelForSaturatingChannels = ...
%         input(['Enter the MEG trigger channel to which'...
%         ' the presence of a saturating channel is written (e.g. 161): ']);
%     
%     doWeUseVibrationalChannels = ...
%         input('Do you want to use vibrational reference channels? (yes or no) ','s');
%     if strcmp(doWeUseVibrationalChannels, 'yes') == 1
%         useVibrationalChannels = 1;
%     elseif strcmp(doWeUseVibrationalChannels, 'no') == 1
%         useVibrationalChannels = 0;
%     else
%         error('Invalid response for use of vibrational denoising channels');
%     end
    customOutputFile = 0;

    % denoising parameters specified
elseif nargin == 3,
    disp('Using user-specified values for TSPCA and SNS parameters');
    disp(['sizeOfBlocks is ', num2str(sizeOfBlocks)]);
    disp(['Shifts are in range of ', ...
        num2str(min(shifts)), ' to ',...
        num2str(max(shifts))]);
    if nearNeighbors < 1
        useSNS = 0;
        disp('nearNeighbors is less than 1, SNS will not be used');
    else
        useSNS = 1;
        disp(['nearNeighbors is ', num2str(nearNeighbors)]);
    end
    % prompt for source file and excluded channels
    [fn, pn] = uigetfile('*.sqd','Select your SQD file source');
    if sum(fn==0)&&sum(pn==0),return,end
    sourceFile = fullfile(pn,fn);
    disp('');
    excludedChannels = ...
        input(['Enter the channels to be excluded from'...
        ' analysis (MEG number scheme), e.g. [55 79 125]: ']);
    doWeZeroSaturatedChannels = ...
        input('Do you want saturating channel values set to zero? (yes or no) ','s');
    if strcmp(doWeZeroSaturatedChannels, 'yes') == 1
        doNotZeroSaturatedChannels = 0;
    elseif strcmp(doWeZeroSaturatedChannels, 'no') == 1
        doNotZeroSaturatedChannels = 1;
    else
        error('Invalid response for zeroing saturated channels');
    end
    
    channelForSaturatingChannels = ...
        input(['Enter the MEG trigger channel to which'...
        ' the presence of a saturating channel is written (e.g. 161): ']);
    doWeUseVibrationalChannels = ...
        input('Do you want to use vibrational reference channels? (yes or no) ','s');
    if strcmp(doWeUseVibrationalChannels, 'yes') == 1
        useVibrationalChannels = 1;
    elseif strcmp(doWeUseVibrationalChannels, 'no') == 1
        useVibrationalChannels = 0;
    else
        error('Invalid response for use of vibrational denoising channels');
    end

    customOutputFile = 0;

elseif nargin == 8,
    % All arguments specified 
    disp('Script-mode: User-specified values for all parameters');
    disp(['sizeOfBlocks is ', num2str(sizeOfBlocks)]);
    disp(['Shifts are in range of ', ...
        num2str(min(shifts)), ' to ', ...
        num2str(max(shifts))]);
    if nearNeighbors < 1
        useSNS = 0;
        disp('nearNeighbors is less than 1, SNS will not be used');
    else
        useSNS = 1;
        disp(['nearNeighbors is ', num2str(nearNeighbors)]);
    end
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

    if strcmp(doWeUseVibrationalChannels, 'yes') == 1
        useVibrationalChannels = 1;
        disp('Using vibrational channels for denoising');
    elseif strcmp(doWeUseVibrationalChannels, 'no') == 1
        useVibrationalChannels = 0;
        disp('Not using vibrational channels for denoising');
    else
        error('Invalid response for use of vibrational denoising channels');
    end
    
    customOutputFile = 1;
elseif nargin == 7,
    % All arguments specified except output file suffix 
    disp('Script-mode: User-specified values for all parameters');
    disp(['sizeOfBlocks is ', num2str(sizeOfBlocks)]);
    disp(['Shifts are in range of ', ...
        num2str(min(shifts)), ' to ', ...
        num2str(max(shifts))]);
    if nearNeighbors < 1
        useSNS = 0;
        disp('nearNeighbors is less than 1, SNS will not be used');
    else
        useSNS = 1;
        disp(['nearNeighbors is ', num2str(nearNeighbors)]);
    end
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
    
    if strcmp(doWeUseVibrationalChannels, 'yes') == 1
        useVibrationalChannels = 1;
        disp('Using vibrational channels for denoising');
    elseif strcmp(doWeUseVibrationalChannels, 'no') == 1
        useVibrationalChannels = 0;
        disp('Not using vibrational channels for denoising');
    else
        error('Invalid response for use of vibrational denoising channels');
    end

    customOutputFile = 0;
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
copyfile(sourceFile,destinationFile,'f');
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
outputInfo.directory = pn;
outputInfo.nearNeighbors = nearNeighbors;
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
    newIndex,shifts,nearNeighbors,combinedInput,...
    goodChannels,totalNumChans,...
    doNotZeroSaturatedChannels,channelForSaturatingChannels,useSNS,...
    useVibrationalChannels);
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
      newIndex,shifts,nearNeighbors,combinedInput,...
    goodChannels,totalNumChans,...
    doNotZeroSaturatedChannels,channelForSaturatingChannels,useSNS,...
    useVibrationalChannels);

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
    newIndex,shifts,nearNeighbors,combinedInput,...
    goodChannels,totalNumChans,...
    doNotZeroSaturatedChannels,channelForSaturatingChannels,useSNS,...
    useVibrationalChannels);

cleanOut = zeros(size(newIndex,2), 157);
% Edited to add option of using vibrational channels for denoising
% 1/13/11
if useVibrationalChannels == 0
    refChannelsUsed = [158:160];
elseif useVibrationalChannels == 1
    refChannelsUsed = [158:160 190:192];
else
    error('useVibrationalChannels is not properly set');
end

magneticRefChannels = 158:160;

% demean the data channels here (but not reference or trigger)
%Edited 9/9/09 to the following:
rawSensors = combinedInput(newIndex, goodChannels);
sensorChannelsIn = demean(combinedInput(:, goodChannels));
magneticRefChannelsIn = combinedInput(:, magneticRefChannels);
refChannelsIn = combinedInput(:, refChannelsUsed);
triggerChannelsIn = combinedInput(:, 161:totalNumChans);
% Calculate a weight matrix for tspca based on the channels
% that may be clipping
weightsForTSPCA = deweightClippedChannels(sensorChannelsIn, goodChannels);
weightsByTimeTSPCA = min(weightsForTSPCA,[],2);
weightsForSNS = weightsByTimeTSPCA(newIndex,:);
weightsToRestore = weightsForTSPCA(newIndex,:);
weightsAreZero = weightsToRestore==0;
%--------------------------------------------------------------

tspca_out = tsr_dan(sensorChannelsIn,refChannelsIn, shifts, weightsByTimeTSPCA);
if useSNS == 1
    sns_out = sns_weighted(tspca_out,nearNeighbors,0,weightsForSNS);
else
    sns_out = tspca_out;
end
    % Write back the value for saturating times and channels
% Data before demeaning is:
sns_out(weightsAreZero) = rawSensors(weightsAreZero)*doNotZeroSaturatedChannels;
cleanOut(:, goodChannels) = sns_out;

% clip the length of the reference and trigger
magneticRefChannelsOut = magneticRefChannelsIn(newIndex,:);
refChannelsOut = refChannelsIn(newIndex, : );
triggerChannelsOut = triggerChannelsIn(newIndex, : );
% set the contents of a trigger channel to be when channels are
% saturating. 4000 = baseline of 4 V.
triggerChannelsOut(:,channelForSaturatingChannels-159) = 4000*min(weightsForSNS,[],2);

% Combine the output back into one array
combinedOutput = [cleanOut magneticRefChannelsOut triggerChannelsOut];

function zeroFirstAndLastShifts(sqdTemplate, destinationFile, offset1, offset2, numSamples)

zeroOut = zeros(offset1, 158);  %Adding an additonal channel, because sqdwrite seems to skip the last channel when saving data
insertLow = 1;
insertHigh = offset1;

sqdwrite(sqdTemplate,destinationFile,'Action','Overwrite','Channels',...
    [0:157],'Samples',[insertLow insertHigh], 'Data', zeroOut);

zeroOut = zeros(offset2, 158);
insertLow = numSamples - offset2 + 1;
insertHigh = numSamples;
sqdwrite(sqdTemplate,destinationFile,'Action','Overwrite','Channels',...
    [0:157],'Samples',[insertLow insertHigh], 'Data', zeroOut);
