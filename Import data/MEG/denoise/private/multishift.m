function z=multishift(x,shifts,amplitudes)
%z=multishift(x,shifts,amplitudes) - apply multiple shifts to matrix
%
%   y: result
%
%   x: matrix to shift
%   shifts: array of shifts (must be nonnegative)
%   amplitudes: array of amplitudes
% 
% X is shifted columnwise (all shifts of 1st column, then all
% shifts of second column, etc)
% 
% X may be 1D, 2D or 3D. 

if nargin<3; amplitudes=[]; end

if min(shifts)<0; error('shifts should be nonnegative'); end
shifts=shifts(:)';
nshifts=numel(shifts);

% array of shift indices
N=size(x,1)-max(shifts); 
shiftarray=vecadd(vecmult(ones(N,nshifts),shifts),(1:N)');
[m,n,o]=size(x);
z=zeros(N,n*nshifts,o);

if ~isempty(amplitudes)
    for k=1:o
        for j=0:n-1
            y=x(:,j+1);
            z(:,j*nshifts+1: j*nshifts+nshifts,k)=vecmult(y(shiftarray),amplitudes);
        end
    end
else
    for k=1:o
        for j=0:n-1
            y=x(:,j+1);
            z(:,j*nshifts+1: j*nshifts+nshifts,k)=y(shiftarray);
        end
    end
end

