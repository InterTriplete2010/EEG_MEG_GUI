% This script cleans up the 'FIC' condition of 'Subject01.ds'.
%
% TSPCA is called using the 33 MEG reference channels
% to remove environmental noise by time-shifted regression.  
%
% Then SNS is called to remove sensor noise.  
%
% Before processing, outlier samples are flagged so that their (typically
% very large) values do not dominate the solutions. 
%
% In the raw data a very large glitch affects two channels.  The glitches remain after
% TSPCA, but SNS removes them completely.  [Note: success here depends on
% the cfg.skip=1 setting].
%
% The effect of denoising is quantified in terms of power.  We can assume
% that denoising does not affect brain activity, so these figures reflect 
% the reduction in noise.



% channels
chan.stim=1;
chan.sclk=2;
chan.ref=3:35;      
chan.brain=36:186;
chan.eog=187;

cfg = [];
cfg.dataset = '/DATA/MEG/FIELDTRIP_TUTORIALDATA/Subject01/Subject01.ds';
if 7 ~= exist(cfg.dataset);
    error('Data not found: correct path or download Subject01.ds from http://www.ru.nl/fcdonders/fieldtrip/.'); 
end
cfg.trialdef.eventtype      = 'backpanel trigger';
cfg.trialdef.eventvalue     = 3; % the value of the stimulus trigger for fully incongruent (FIC).
cfg.trialdef.prestim        = 1;
cfg.trialdef.poststim       = 2;
cfg = definetrial(cfg);

% load reference sensors
cfg.channel=chan.ref;
ref=preprocessing(cfg);

% load data sensors
cfg.channel=chan.brain;
brain=preprocessing(cfg);

% remove mean from each channel (should be option in preprocessing...)
brain.trial=mat2trial(demean(trial2mat(brain.trial)),brain.trial);

p0=wpwr(trial2mat(brain.trial));

% cfg parameters for wrap_tsr
cfg.toobig1=40*10^-12;   %  ignore brain absolute values greater than this
cfg.toobig2=10;         %  ignore brain mean/normalized values greater than this
cfg.toobig3=[];         %  ignore ref absolute values greater than this
cfg.toobig4=10;         %  ignore ref mean/normalized values greater than this
cfg.shifts=-10:10;      % shifts to apply to refs
clean=wrap_tsr(cfg,brain,ref);

p1=wpwr(trial2mat(clean.trial));

% cfg parameters for wrap_sns
cfg.toobig1=4*10^-12;   %  ignore absolute values greater than this
cfg.toobig2=10;         %  ignore mean/normalized values greater than this
cfg.nneighbors=10;      % number of closest channels to project on
cfg.skip=1;             % number of closest channels to skip
cfg.repeat=3;           % number of iterations
clean2=wrap_sns(cfg,clean);

x=trial2mat(clean2.trial);

p2=wpwr(x);

% apply DSS using the average over epochs as a bias function
[todss,fromdss,ratio,pwr]=dss1(demean(x)); 
z=fold(unfold(demean(x))*todss,size(x,1));   % DSS components


% suppose we keep 10 components 
keep=1:10;
zz=fold(unfold(z(:,keep,:))*fromdss(keep,:),size(z,1));

p3=wpwr(zz)

% suppose we keep 1 component
keep=1;
zz=fold(unfold(z(:,keep,:))*fromdss(keep,:),size(z,1));
p4=wpwr(zz)

[a,b]=bsmean(z(:,1,:));

p5=wpwr(a*fromdss(1,:))*size(z,3);
p6=wpwr(b*fromdss(1,:))*size(z,3);

fliplr (10*log10([p5/p6 p5/p4 p5/p3 p5/p2 p5/p1 p5/p0]))


disp(['Starting from the raw, de-meaned, data,'])
disp(['TSPCA removed ', num2str(100*(p0-p1)/p0),'% of power corresponding to environmental noise,']);
disp(['SNS removed ', num2str(100*(p1-p2)/p0),'% of power corresponding to sensor noise,']);
disp(['leaving ', num2str(100*p2/p0),'% of power corresponding to cleaned data.']);

clf
ch=1;
pwelch(unfold(trial2mat(brain.trial,ch)),1024,[],[],brain.fsample); hold on
c=get(gca,'children'); set(c(1),'color',[1 0 0]);
pwelch(unfold(trial2mat(clean.trial,ch)),1024,[],[],brain.fsample);
c=get(gca,'children'); set(c(1),'color',[0 1 0]);
pwelch(unfold(trial2mat(clean2.trial,ch)),1024,[],[],brain.fsample);
set(gca,'xscale','log'); legend('raw', 'TSPCA', 'TSPCA+SNS'); legend boxoff

