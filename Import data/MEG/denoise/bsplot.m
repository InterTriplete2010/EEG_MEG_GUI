function bsplot(x,sds,style);
%bsplot(x,sds,style) - plot average with bootstrap standard deviations
%
%  x: data to plot (time * trials, or time * 1 * trials)
%  sds: number of standard deviations to plot (default: 2)
%  style: 'zerobased' (default) or 'meanbased'

if nargin<3 || isempty(style); style='zerobased'; end
if nargin<2 || isempty(sds); sds=2; end

x=squeeze(x);
if ndims(x)>2; error('X should have at most 2 singleton dimensions'); end
[m,n]=size(x);
if n<2; error('bootstrap resampling requires more than 1 column'); end


[a,b]=bsmean(x);

b=b*sds;
if strcmp(style,'zerobased');
    b=[b,-b]';
elseif strcmp(style,'meanbased');
    b=[b+a,-b+a]';
else
    error('!');
end

b=b(:);

plot(0.5:0.5:m,b,'g');
c=get(gca,'children'); set(c(1),'color',[.7 .7 .7])
hold on;
plot(a,'b');
plot(0*a,'k');
c=get(gca,'children'); set(c(1),'color',[.5 .5 .5])
set(gca,'xlim',[1 m])
hold off
