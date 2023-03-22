function [todss,fromdss,ratio,pwr]=dss0(c1,c2,keep1,keep2)
%[todss,fromdss,ratio,pwr]=dss0(c1,c2,keep1,keep2) - dss from covariance
%
% todss: data-to-dss matrix
% fromdss: dss-to-data matrix
% ratio: power ratio of dss components relative to baseline
% pwr: power per component
%
% c1: baseline covariance
% c2: biased covariance
% keep1: number of PCs to retain (default: all)
% keep2: ignore PCs smaller than keep2 (default: 10.^-12)

% See:
% de Cheveign\'e, A. and Simon J.Z. (2008, in preparation), "Denoising 
% based on spatial filtering".
% and:
% J. S\"arel\"a, J. and Valpola, H. (2005), Denoising source separation. 
% Journal of Machine Learning Research 6, 233-272.


if nargin<4||isempty(keep2); keep2=10.^-12; end
if nargin<3; keep1=[]; end
if nargin<2; error('needs at least two arguments'); end

if size(c1)~=size(c2); error('C1 and C2 should have same size'); end
if size(c1,1)~=size(c1,2); error('C1 should be square'); end

% derive PCA and whitening matrix from the unbiased covariance
[topcs1,evs1]=pcarot(c1);
if ~isempty(keep1); topcs1=topcs1(:,1:keep1); evs1=evs1(1:keep1); end
if ~isempty(keep2); idx=find(evs1/max(evs1)>keep2); topcs1=topcs1(:,idx); evs1=evs1(idx); end

% apply whitening and PCA matrices to the biased covariance (== covariance
% of biased whitened data)
N=diag(sqrt(1./evs1));      % whitening matrix
c3=N'*topcs1'*c2*topcs1*N;

% derive the dss matrix
[topcs2,evs2]=pcarot(c3);
todss=topcs1*N*topcs2;
fromdss=pinv(todss);

% dss to data projection matrix
cxy=c1*todss;                                   % covariance between unbiased data and selected DSS components

% estimate power per DSS component 
pwr=zeros(size(todss,2),1);
for k=1:size(todss,2)
    %c=cxy(:,k);
    %z=regcov(c,1);  % matrix to apply to this DSS component to model data
    to_component=todss(:,k)*fromdss(k,:);
    cc=to_component'*c1*to_component;
    cc=diag(cc);
    %pwr(k)=sum(z.^2);
    pwr(k)=sum(cc.^2);
end

% power ratio
ratio=diag(todss'*c2*todss) ./ diag(todss'*c1*todss);   

