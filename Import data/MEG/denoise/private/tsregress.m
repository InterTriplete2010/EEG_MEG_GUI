function [z,idx]=tsregress(x,y,shifts,keep,threshold,toobig1,toobig2)
%[z,idx]=tsregress(x,y,shifts,keep,threshold,toobig1,toobig2) - time-shift regression
%
%  z: part of x modeled by time-shifted y
%  idx: x(idx) maps to z
%
%  x: data to model
%  y: regressor
%  shifts: array of shifts to apply (default: [0])
%  keep: number of components of shifted regressor PCs to keep (default: all)
%  threshold: discard PCs with eigenvalues below this (default: 0)
%  toobig1: ignore samples with absolute value above this
%  toobig2: ignore samples with relative value above this
%
% Data X are regressed on time-shifted versions of Y. X and Y are initially 
% time-aligned, but because of the shifts, Z is shorter than X.  Z is
% time-aligned with X(IDX).


if nargin<2; error('!'); end
if nargin<3||isempty(shifts); shifts=[0]; end
if nargin<4; keep=[]; end
if nargin<5; threshold=[]; end
if nargin<6; toobig1=[]; end
if nargin<7; toobig2=[]; end

% shifts must be non-negative
mn=min(shifts);
if mn<0; 
    shifts=shifts-mn; 
    x=x(-mn+1:end,:,:);
    y=y(-mn+1:end,:,:);
end
nshifts=numel(shifts);

% flag outliers in x and y
if ~isempty(toobig1) || ~isempty(toobig2)
    xw=find_outliers(x,toobig1,toobig2);
    yw=find_outliers(y,toobig1,toobig2);
else
    xw=[];yw=[];
    %xw=ones(size(x)); yw=ones(size(y));
end

% subtract weighted means

if ndims(x)==3    
    [Mx,Nx,Ox]=size(x);
    [My,Ny,Oy]=size(y);
    x=unfold(x);
    y=unfold(y);
    [x,xmn]=demean(x,xw);
    [y,ymn]=demean(y,yw);
    x=fold(x,Mx);
    y=fold(y,My);
else
    [x,xmn]=demean(x,xw);
    [y,ymn]=demean(y,yw);
end


% covariance of y
[cyy,totalweight]=tscov(y,shifts',yw);
cyy=cyy./totalweight;

% cross-covariance of x and y
[cxy, totalweight]=tscov2(x,y,shifts',xw,yw);
cxy=cxy./totalweight;

% regression matrix
r=regcov(cxy,cyy,keep,threshold);
    
% regression
if ndims(x)==3
    x=unfold(x);
    y=unfold(y);
    [m,n]=size(x);
    mm=m-max(shifts);
    z=zeros(size(x));
    for k=1:nshifts
        kk=shifts(k);
        idx1=kk+1:kk+mm;
        idx2=k+(0:size(y,2)-1)*nshifts;
        z(1:mm,:)=z(1:mm,:)+y(idx1,:)*r(idx2,:);
    end
    z=fold(z,Mx);
    z=z(1:end-max(shifts),:,:);
else
    [m,n]=size(x);
    z=zeros(m-max(shifts),n);
    for k=1:nshifts
        kk=shifts(k);
        idx1=kk+1:kk+size(z,1);
        %idx2=k*size(y,2)+1:(k+1)*size(y,2);
        idx2=k+(0:size(y,2)-1)*nshifts;
        z=z+y(idx1,:)*r(idx2,:);
    end
end

% idx allows x to be aligned with z
offset=max(0,-mn);
idx=offset+1:offset+size(z,1);

%elseif ndims(x)==3
    
%end

