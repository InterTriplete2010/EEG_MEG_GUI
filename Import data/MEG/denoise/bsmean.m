function [mn,sd,bsmn,all]=bsmean(x,N)
%[mn,sd,bsmn,all]=bsmean(x,N) - calculate mean, estimate sd using bootstrap
%
%  mn: mean over x
%  sd: standard deviation from mn calculated by bootstrap
%  bsmn: bootstrap mean
%  all: matrix of all trials
%  
%  x: matrix of observations (time X repetitions)
%  N: number of bootstrap trials [default: 100]

if nargin <2; N=100; end

x=squeeze(x); 

[m,n]=size(x);
all=zeros(m,N);
for k=1:N
    idx=ceil(n*rand(1,n));
    all(:,k)=mean(x(:,idx),2);
end

mn=mean(x,2);
sd=sqrt(mean((all-repmat(mn,1,N)).^2,2));
bsmn=mean(all,2);


