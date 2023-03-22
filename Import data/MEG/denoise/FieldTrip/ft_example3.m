% This script cleans up the first few trials of 'ArtifactMEG.ds'.
%
% TSPCA is called using the 28 MEG reference channels
% to remove environmental noise by time-shifted regression.  
%
% TSPCA is then called again using the 4 channels that pick up (apparently)
% neck muscle, jaw muscle, eog and ecg activity again as references. This
% allows these components to be regressed out of the brain data.
%
% Then SNS is called to remove sensor noise.  
%
% The effect of denoising is quantified in terms of power.  We can assume
% that denoising does not affect brain activity, so these figures reflect 
% the reduction in noise.



% channels
chan.stim=1;
chan.sclk=2;
chan.ref=3:31;      
chan.brain=32:170;
chan.jaw=171;
chan.neck=172;
chan.eog=173;
chan.ecg=174;
chan.adc=175:176;

cfg = [];
cfg.dataset = '/DATA/MEG/FIELDTRIP_TUTORIALDATA/ArtifactMEG.ds';
if 7 ~= exist(cfg.dataset);
    error('Data not found: correct path or download ArtifactMEG.ds from http://www.ru.nl/fcdonders/fieldtrip/.'); 
end
cfg.datatype = 'continuous';
cfg.trialdef.eventtype = 'trial';
cfg = definetrial(cfg);

% subset of trials to fit memory
cfg.trl=cfg.trl(1:5,:);

% load reference sensors
cfg.channel=chan.ref;
ref=preprocessing(cfg);

% load data sensors
cfg.channel=chan.brain;
brain=preprocessing(cfg);

% load additional sensors
cfg.detrend='yes';
cfg.channel=[chan.jaw,chan.neck,chan.eog,chan.ecg];
misc=preprocessing(cfg);

% remove mean from each channel (should be option in preprocessing...)
disp('Removing environmental noise from brain sensors:')
brain.trial=mat2trial(demean(trial2mat(brain.trial)),brain.trial);

p0=wpwr(trial2mat(brain.trial));

% cfg parameters for wrap_tsr
cfg.shifts=-10:10;      % shifts to apply to refs
clean=wrap_tsr(cfg,brain,ref);

p1=wpwr(trial2mat(clean.trial));

disp('Removing environmental noise from biological noise sensors...');
misc.trial=mat2trial(demean(trial2mat(misc.trial)),misc.trial);
disp('Removing biological noise from brain sensors...');
misc_clean=wrap_tsr(cfg,misc,ref);
cfg.shifts=0;      
clean2=wrap_tsr(cfg,clean,misc_clean);


p2=wpwr(trial2mat(clean2.trial));


% cfg parameters for wrap_sns
cfg.nneighbors=10;      % number of closest channels to project on
cfg.skip=0;             % number of closest channels to skip
clean3=wrap_sns(cfg,clean2);

p3=wpwr(trial2mat(clean3.trial));

disp(['Starting from the raw, de-meaned, data,'])
disp(['TSPCA removed ', num2str(100*(p0-p1)/p0),'% of power corresponding to environmental noise,']);
disp(['TSPCA removed ', num2str(100*(p1-p2)/p0),'% of power corresponding to EOG, ECG, etc.,']);
disp(['SNS removed ', num2str(100*(p2-p3)/p0),'% of power corresponding to sensor noise,']);
disp(['leaving ', num2str(100*p3/p0),'% of power corresponding to cleaned data.']);

clf
ch=1;
pwelch(unfold(trial2mat(brain.trial,ch)),1024,[],[],brain.fsample); hold on
c=get(gca,'children'); set(c(1),'color',[1 0 0]);
pwelch(unfold(trial2mat(clean2.trial,ch)),1024,[],[],brain.fsample);
c=get(gca,'children'); set(c(1),'color',[0 1 0]);
pwelch(unfold(trial2mat(clean3.trial,ch)),1024,[],[],brain.fsample);
set(gca,'xscale','log'); legend('raw', 'TSPCA', 'TSPCA+SNS'); legend boxoff

