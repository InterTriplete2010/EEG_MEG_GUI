function nz = mkgnoise(cf,bw,duration,fs)

%initial constants
npts = round(fs*duration);   %stimulus length
nchannels = length(cf);

% make frequency mask for filtering - take care for short duration noise
freqres = fs/npts;
bwpts = round(bw/freqres);
ledge = round((cf-(bw/2))/freqres);
hedge = min(ledge + bwpts-1,ceil(npts/2));

% generate noise
a = zeros(npts,nchannels);
b = zeros(npts,nchannels);
for ii = 1:nchannels
    a(ledge(ii):hedge(ii),ii) = randn(bwpts(ii),1);
    b(ledge(ii):hedge(ii),ii) = randn(bwpts(ii),1);
end
x = a-(1i*b);
if rem(npts,2) == 0
    x(npts:-1:(round(npts/2)+2),:) = conj(x(2:round(npts/2),:));
else
    x(npts:-1:(round(npts/2)+1),:) = conj(x(2:round(npts/2),:));
end

nz=real(ifft(x));
nz = nz .* repmat(sqrt((100*ones(1,nchannels)./sum(nz.^2,1))),npts,1);

