% This script cleans up a few trials of 'ArtifactMEG.ds'.
%
% These data are contaminated by a large glitch: the baseline switches
% suddenly from one value to another. 
%
% fix_step_glitch() is first called to remove the glitch.
%
% TSPCA is then called using the 28 MEG reference channels
% to remove environmental noise by time-shifted regression.  
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
cfg.trl=cfg.trl(15:20,:);

% load reference sensors
cfg.channel=chan.ref;
ref=preprocessing(cfg);

% load data sensors
cfg.channel=chan.brain;
brain=preprocessing(cfg);

figure(1)
x=trial2mat(brain.trial); 
disp('Apply fix_step_glitch()...');
p00=wpwr(x);
x=fix_step_glitch(x);
p01=wpwr(x);
disp(['done, remains ',num2str(100*p01/p00), '% of power']);
brain.trial=mat2trial(x,brain.trial);


% remove mean from each channel (should be option in preprocessing...)
brain.trial=mat2trial(demean(trial2mat(brain.trial)),brain.trial);

p0=wpwr(trial2mat(brain.trial));

% cfg parameters for wrap_tsr
cfg.shifts=-10:10;      % shifts to apply to refs
clean=wrap_tsr(cfg,brain,ref);

p1=wpwr(trial2mat(clean.trial));

% cfg parameters for wrap_sns
cfg.nneighbors=10;      % number of closest channels to project on
cfg.skip=3;             % number of closest channels to skip
disp('Warning: calling SNS with skip=3 (to remove sensor glitch correlated across 4 channels)');
clean2=wrap_sns(cfg,clean);

p2=wpwr(trial2mat(clean2.trial));

disp(['Starting from the raw, de-meaned, data,'])
disp(['TSPCA removed ', num2str(100*(p0-p1)/p0),'% of power corresponding to environmental noise,']);
disp(['SNS removed ', num2str(100*(p1-p2)/p0),'% of power corresponding to sensor noise,']);
disp(['leaving ', num2str(100*p2/p0),'% of power corresponding to cleaned data.']);

figure(2)
clf
ch=1;
pwelch(unfold(trial2mat(brain.trial,ch)),1024,[],[],brain.fsample); hold on
c=get(gca,'children'); set(c(1),'color',[1 0 0]);
pwelch(unfold(trial2mat(clean.trial,ch)),1024,[],[],brain.fsample);
c=get(gca,'children'); set(c(1),'color',[0 1 0]);
pwelch(unfold(trial2mat(clean2.trial,ch)),1024,[],[],brain.fsample);
set(gca,'xscale','log'); legend('raw', 'TSPCA', 'TSPCA+SNS'); legend boxoff

