function [c, hc, hm] = megtopoplot(data,topocolormap,phasorscale,channel_config,topomask)

%MEGTOPOPLOT Creates an MEG topographic plot.
%
%    MEGTOPOPLOT(...) creates a topographic plot of MEG data on a
%    flatttened head. It plots ordinary magnetic fields data, positive-only
%    data (e.g. power or SNR), and complex data.
%
%    MEGTOPOPLOT(DATA) creates a topographic plot (contour map) of the data
%    on a flatttened head. DATA must be an array of 157 values.
%
%    A bad channel will be ignored if its value is a NaN.
%
%    If DATA is complex, then the phasor values are plotted as arrows and
%    the contour map is created from the projection of the data onto a line
%    in the complex plane that maximizes the variance of the projection.
%
%    The color axis limits are set to +/- the maximum absolute value of the
%    contour map, unless the the data is positive only, in which case the
%    lower limit is set to zero.
%
%    The default colormap is red for positive values and green for negative
%    values (saturating to white for zeros values), unless the data is
%    positive only, in which case the default is 1-gray (so that data
%    near zero blends smoothly into a white background).
%
%    MEGTOPOPLOT(DATA, TOPOCOLORMAP) uses TOPOCOLORMAP as the colormap.
%
%    MEGTOPOPLOT(DATA, TOPOCOLORMAP, PHASORSCALE) or
%    MEGTOPOPLOT(DATA, [], PHASORSCALE) can be used if DATA is a complex
%    array. The phasor arrows are divided by PHASORSCALE before being
%    plotted. The default phasorscale is twice the maxium magnitude of the
%    complex data. Larger values give smaller arrows.
%
%    MEGTOPOPLOT(DATA, TOPOCOLORMAP, PHASORSCALE, CHANNEL_CONFIG) or
%    MEGTOPOPLOT(DATA, [], [], CHANNEL_CONFIG) can be used if the data was
%    collected when the physical channel configuration was different
%    than the current configuration. The default is 'current', but
%    'original' should be used for data collected before 1 October 2004.
%
%    MEGTOPOPLOT(DATA, TOPOCOLORMAP, PHASORSCALE, CHANNEL_CONFIG, TOPOMASK)
%    or MEGTOPOPLOT(DATA, [], [], [], TOPOMASK) to continuously and
%    transparently mask out sections fo the topo plot. The main use of this
%    is to apply an "SNR mask" (a mask proportional to the Signal-to-Noise
%    Ratio), which would cause low SNR regious to fade. This use allows
%    strong but noisy regions to be de-emphasized appropriately. TOPOMASK
%    must be the same size as DATA and range from 0 (totally masked) to 1
%    (totally transparent). This might be SNR/max(SNR) if SNR is not in dB.
%
%
%    C = MEGTOPOPLOT(...) returns contour matrix C (as described in
%    CONTOURC and used by CLABEL).
%
%    [C,HC] = MEGTOPOPLOT(...) also returns a handle HC to a CONTOURGROUP
%    object.
%
%    [C,HC,HM] = MEGTOPOPLOT(...) also returns a handle HM to the mask's
%    'surf' object.
%

%    Version 1.2beta
%    4 August 2014
%
%    by Jonathan Z. Simon
%    Based on draw_topo by Jonathan Simon, Yadong Wang, and others in the
%    Simon Group.
%
%    Changes from Version 1.1
%       Renamed coordinate systems:
%       'mmh1', formerly 'original' at Marie Mount Hall
%       'mmh2', formerly 'current' at Marie Mount Hall
%       'mnc', new coordinate system at Maryland Neuroimaging Center
%
%    Changes from Version 1.1beta:
%        reverse colormap for historical consistency (red+ greeen-).
%
%    Changes from Version 1.0beta:
%        Added topomask optional input to visually fade, e.g., low SNR regions.


% Error checking
if length(data) ~= 157
    error('Error: MEG data must be an array of length 157.')
end

dataIsReal = ~any(imag(data(:)));
dataIsNonNegative =  dataIsReal && all(min(data)>0);

% Create colormap if not supplied or if equal to [].
%    The default colormap is red for positive values and greeen for negative
%    values saturating to white for zeros values, unless the data is
%    positive only, in which case the default is 1 - gray (so that data
%    near zero blends smoothly into a white background).

if ~exist('topocolormap','var')
    topocolormap = [];
end
if isempty(topocolormap)
    if dataIsNonNegative
        topocolormap = 1-gray;
    else
        topocolormap = toporedgreen;
    end
end

% Create phasorscale if data is complex and if not supplied or if equal to [].
if ~dataIsReal
    if ~exist('phasorscale','var')
        phasorscale = [];
    end
    if isempty(phasorscale)
        phasorscale = max(abs(data))*2;
    end
end

% Determine channel_config
%    channel_config can be used if the data was
%    collected when the channel configuration over the head was different
%    than the current configureation. The default is 'current', but
%    'original' should be used for data collected before 1 October 2004.

channel_config_options = {'mnc','mmh2','mmh1'};
if ~exist('channel_config','var')
    channel_config = [];
end
if isempty(channel_config)
    channel_config = 'mnc';
end
if ~ismember(channel_config,channel_config_options)
    error(['Error: The input variable channel_config must be either ''' channel_config_options{1} ''' or ''' channel_config_options{2} '''   or ''' channel_config_options{3} '''  '])
end

if ~exist('topomask','var')
    topomask = [];
end
if ~isempty(topomask)
    if min(topomask) < 0
        error('Error: the input variable topomask must be positive.')
    end
    if max(topomask) > 1
        error('Error: the input variable topomask less than or equal to 1. Please rescale it to topomask/max(topomask).')
    end
end

data = data(:);
channelGood = ~isnan(data);
goodData = data(channelGood);

if dataIsReal
    cdata = goodData;
else
    theta = (0:0.01:pi).';
    [maxVar,maxVarInd] = max(var(real(exp(1i*theta)*goodData.').',1));
    maxVarTheta = theta(maxVarInd);
    cdata = abs(goodData).*sign(angle(goodData.*exp(1i*(maxVarTheta-pi/2))));
end

[xi yi] = meshgrid((-135:135)/135*2.5, (-135:135)/135*2.5); %Creates a 2D-grid with x and y coordinates described in the arguments of the function
[xx,yy] = MEG_channel_locations(channel_config);
xx = xx(channelGood);
yy = yy(channelGood);

w = griddata(xx,yy,cdata,xi,yi); % this is the fast *and correct* method 
%Fits a surface of the form v = f(x,y) = cdata to the scattered data in the vectors (xx,yy,cdata). 
%The griddata function interpolates the surface at the query points specified by (xi,yi) and returns the interpolated values, w. 
%The surface always passes through the data points defined by xx and yy.)
headmask = (sqrt(xi.^2+yi.^2) <= 2.05); % this is a circular mask within the head.
w(headmask == 0) = NaN;

cla
hold on
[c hc] = contourf(xi, yi, w, 12); %line contours only map

%    The color axis limits are set to [-1 1] times the maximum
%    absolute value of the contour map, unless the the data is positive
%    only, in which case the lower limit is set to zero.
cLimNew = max(abs(get(gca,'CLim')));
if dataIsNonNegative
    set(gca,'CLim',cLimNew*[0 1]);
else
    set(gca,'CLim',cLimNew*[-1 1]);
end
colormap(topocolormap);

drawTopoHead(2.04)

if ~dataIsReal
    phasorArrows(xx,yy,real(goodData)/phasorscale,imag(goodData)/phasorscale,2,0.25,0.33)
end;

if ~isempty(topomask)
    wm = griddata(xx,yy,1-(topomask),xi,yi);
    hm = surf(xi,yi,wm,'edgecolor','none','FaceAlpha','flat',...
        'AlphaDataMapping','scaled','AlphaData',wm,...
        'FaceColor','white');
end

hold off;

axis('square')
axis off;
axis equal;

drawnow;

if nargout<1; clear c hc hm; end

end


function trg = toporedgreen

%   Bilinear red/green color map.
m = size(get(gcf,'colormap'),1);
top = floor(m/2);
bot = m-top;
btop = [1.0*ones(top,1),((1:top)'/top),ones(top,1)];   % 1.0 hue good red
bbot = [0.33*ones(bot,1),(1-(1:bot)'/bot),ones(bot,1)]; % 0.33 hue good green
trg=(hsv2rgb([bbot;btop]));

end

function [xx,yy] = MEG_channel_locations(channel_config)

switch channel_config
    case 'mnc'
        AxialGradioMeter = 1;
        MEG_channel_coordinates_157 = [%% Inner coil X coordinate [mm]      Inner coil Y coordinate [mm]        Inner coil Z coordinate [mm]        Alpha angle (sensor orientation from Z-axis) [deg]      Beta angle (sensor orientation from X-axis) [deg]       Inner coil radius [mm]      Baseline [mm]
            0      AxialGradioMeter      79.85      91.24      -46.38      91.02      56.43      15.50      50.00
            1      AxialGradioMeter      56.94      104.33      -43.33      90.15      64.91      15.50      50.00
            2      AxialGradioMeter      33.09      112.52      -41.45      89.95      75.47      15.50      50.00
            3      AxialGradioMeter      9.47      116.28      -39.84      88.78      84.27      15.50      50.00
            4      AxialGradioMeter      -16.42      114.09      -38.65      88.75      95.80      15.50      50.00
            5      AxialGradioMeter      -41.08      110.70      -37.50      87.38      104.92      15.50      50.00
            6      AxialGradioMeter      -63.99      102.45      -36.41      88.37      113.76      15.50      50.00
            7      AxialGradioMeter      -99.69      74.14      -8.88      86.28      136.00      15.50      50.00
            8      AxialGradioMeter      -102.51      73.71      -35.81      87.17      136.55      15.50      50.00
            9      AxialGradioMeter      -117.20      54.15      -35.96      87.49      147.44      15.50      50.00
            10      AxialGradioMeter      -127.77      31.32      -35.99      86.67      160.25      15.50      50.00
            11      AxialGradioMeter      -132.44      9.33      -36.45      87.95      176.41      15.50      50.00
            12      AxialGradioMeter      -131.23      -15.01      -37.18      87.13      188.15      15.50      50.00
            13      AxialGradioMeter      -125.08      -38.02      -38.06      89.04      200.44      15.50      50.00
            14      AxialGradioMeter      -113.69      -60.27      -39.36      89.31      215.67      15.50      50.00
            15      AxialGradioMeter      -97.88      -78.52      -40.57      89.51      225.77      15.50      50.00
            16      AxialGradioMeter      -78.84      -93.63      -41.04      89.56      235.04      15.50      50.00
            17      AxialGradioMeter      -57.91      -105.05      -42.44      90.07      245.36      15.50      50.00
            18      AxialGradioMeter      -33.82      -113.56      -44.68      88.80      254.93      15.50      50.00
            19      AxialGradioMeter      -9.93      -116.17      -45.26      91.62      263.83      15.50      50.00
            20      AxialGradioMeter      15.08      -116.80      -47.39      90.74      274.65      15.50      50.00
            21      AxialGradioMeter      42.31      -111.52      -23.05      91.13      285.39      15.50      50.00
            22      AxialGradioMeter      61.06      -103.02      -50.02      91.45      295.47      15.50      50.00
            23      AxialGradioMeter      82.43      -90.35      -50.88      92.74      302.96      15.50      50.00
            24      AxialGradioMeter      85.94      -87.75      -25.88      91.61      308.13      15.50      50.00
            25      AxialGradioMeter      -39.51      -66.83      108.87      45.15      244.76      15.50      50.00
            26      AxialGradioMeter      18.38      -115.64      -21.89      89.73      277.06      15.50      50.00
            27      AxialGradioMeter      -7.74      -117.72      -21.07      90.31      266.47      15.50      50.00
            28      AxialGradioMeter      -55.49      -106.62      -17.26      90.23      246.50      15.50      50.00
            29      AxialGradioMeter      -73.63      -31.09      115.49      38.97      205.34      15.50      50.00
            30      AxialGradioMeter      -96.84      -78.84      -13.55      89.37      224.25      15.50      50.00
            31      AxialGradioMeter      -77.13      -4.56      113.26      39.94      182.52      15.50      50.00
            32      AxialGradioMeter      -130.47      -14.06      -9.14      86.99      186.93      15.50      50.00
            33      AxialGradioMeter      -129.53      9.31      -7.66      86.84      173.24      15.50      50.00
            34      AxialGradioMeter      -114.51      53.67      -7.79      87.77      147.67      15.50      50.00
            35      AxialGradioMeter      -72.10      18.18      112.83      38.89      162.66      15.50      50.00
            36      AxialGradioMeter      -81.26      89.82      -9.32      86.64      124.28      15.50      50.00
            37      AxialGradioMeter      -59.55      103.17      -10.18      88.26      112.90      15.50      50.00
            38      AxialGradioMeter      -10.37      115.27      -12.52      87.17      93.04      15.50      50.00
            39      AxialGradioMeter      14.05      114.43      -15.06      89.55      83.59      15.50      50.00
            40      AxialGradioMeter      -45.28      58.99      116.20      42.86      120.48      15.50      50.00
            41      AxialGradioMeter      82.71      89.26      -21.44      90.95      53.14      15.50      50.00
            42      AxialGradioMeter      86.86      87.06      3.55      90.94      50.34      15.50      50.00
            43      AxialGradioMeter      63.03      101.19      6.31      89.18      64.83      15.50      50.00
            44      AxialGradioMeter      40.77      110.02      7.27      90.01      73.18      15.50      50.00
            45      AxialGradioMeter      -20.37      66.53      111.32      43.75      103.38      15.50      50.00
            46      AxialGradioMeter      -34.55      110.11      11.81      87.24      101.34      15.50      50.00
            47      AxialGradioMeter      -58.12      100.67      13.25      87.39      113.31      15.50      50.00
            48      AxialGradioMeter      -78.74      87.70      14.78      85.79      123.79      15.50      50.00
            49      AxialGradioMeter      -113.72      54.13      17.21      85.55      149.54      15.50      50.00
            50      AxialGradioMeter      -125.00      32.03      16.23      87.76      162.63      15.50      50.00
            51      AxialGradioMeter      -126.44      6.62      38.93      79.44      173.52      15.50      50.00
            52      AxialGradioMeter      30.39      69.73      106.67      46.81      71.45      15.50      50.00
            53      AxialGradioMeter      -121.08      -40.01      14.47      87.88      200.32      15.50      50.00
            54      AxialGradioMeter      -110.69      -61.44      12.67      89.99      212.48      15.50      50.00
            55      AxialGradioMeter      -74.86      -95.23      9.11      89.40      236.61      15.50      50.00
            56      AxialGradioMeter      -53.37      -107.58      7.07      90.41      247.87      15.50      50.00
            57      AxialGradioMeter      -28.80      -113.61      5.14      90.43      256.63      15.50      50.00
            58      AxialGradioMeter      72.25      43.96      106.11      46.48      38.86      15.50      50.00
            59      AxialGradioMeter      45.75      -110.83      0.68      91.30      288.50      15.50      50.00
            60      AxialGradioMeter      68.70      -99.10      1.29      90.64      298.85      15.50      50.00
            61      AxialGradioMeter      89.41      -86.44      -0.69      91.81      310.74      15.50      50.00
            62      AxialGradioMeter      90.21      -84.65      22.97      87.31      311.19      15.50      50.00
            63      AxialGradioMeter      70.05      -99.65      21.43      87.79      300.01      15.50      50.00
            64      AxialGradioMeter      61.61      29.20      119.84      35.74      33.57      15.50      50.00
            65      AxialGradioMeter      22.75      -115.28      25.25      85.63      277.49      15.50      50.00
            66      AxialGradioMeter      -2.69      -115.90      26.73      86.49      268.26      15.50      50.00
            67      AxialGradioMeter      44.90      45.72      119.79      36.12      55.92      15.50      50.00
            68      AxialGradioMeter      -78.77      -86.61      54.83      73.69      233.45      15.50      50.00
            69      AxialGradioMeter      -92.38      -79.39      34.61      83.62      226.27      15.50      50.00
            70      AxialGradioMeter      -107.76      -59.50      35.76      82.91      214.01      15.50      50.00
            71      AxialGradioMeter      2.40      54.74      123.24      34.62      86.88      15.50      50.00
            72      AxialGradioMeter      -125.82      -16.11      38.43      79.73      187.23      15.50      50.00
            73      AxialGradioMeter      -23.96      50.78      126.40      33.20      111.14      15.50      50.00
            74      AxialGradioMeter      -120.24      32.04      38.46      81.44      158.29      15.50      50.00
            75      AxialGradioMeter      -109.05      51.67      38.17      80.34      147.35      15.50      50.00
            76      AxialGradioMeter      -95.70      73.50      37.22      80.41      135.25      15.50      50.00
            77      AxialGradioMeter      -74.72      87.59      35.81      80.37      123.05      15.50      50.00
            78      AxialGradioMeter      -56.77      17.63      130.91      29.49      158.80      15.50      50.00
            79      AxialGradioMeter      -5.94      113.26      32.91      80.07      94.05      15.50      50.00
            80      AxialGradioMeter      18.55      110.74      31.26      82.47      83.18      15.50      50.00
            81      AxialGradioMeter      -39.12      -45.72      121.83      32.86      232.83      15.50      50.00
            82      AxialGradioMeter      66.75      97.62      28.75      85.43      62.29      15.50      50.00
            83      AxialGradioMeter      88.00      83.89      26.29      85.30      49.94      15.50      50.00
            84      AxialGradioMeter      82.65      82.78      50.45      76.09      51.24      15.50      50.00
            85      AxialGradioMeter      39.35      102.54      51.94      75.68      73.53      15.50      50.00
            86      AxialGradioMeter      -20.51      -61.58      124.25      35.30      253.21      15.50      50.00
            87      AxialGradioMeter      -34.93      103.95      55.79      73.34      104.12      15.50      50.00
            88      AxialGradioMeter      -58.88      94.24      57.35      72.48      116.81      15.50      50.00
            89      AxialGradioMeter      10.11      -81.73      106.35      47.58      278.41      15.50      50.00
            90      AxialGradioMeter      -77.60      79.28      58.16      71.76      126.44      15.50      50.00
            91      AxialGradioMeter      -118.98      21.02      59.67      70.00      167.00      15.50      50.00
            92      AxialGradioMeter      48.23      -51.01      117.83      38.02      308.01      15.50      50.00
            93      AxialGradioMeter      -116.00      -26.97      58.19      72.11      195.18      15.50      50.00
            94      AxialGradioMeter      -95.85      -69.23      55.82      72.34      221.20      15.50      50.00
            95      AxialGradioMeter      63.73      -33.95      118.22      38.12      327.44      15.50      50.00
            96      AxialGradioMeter      -55.41      -99.30      49.99      75.92      244.92      15.50      50.00
            97      AxialGradioMeter      -26.63      -114.44      27.61      86.04      259.23      15.50      50.00
            98      AxialGradioMeter      72.04      8.27      118.48      36.25      11.29      15.50      50.00
            99      AxialGradioMeter      40.18      -106.97      45.31      76.62      286.14      15.50      50.00
            100      AxialGradioMeter      83.12      -86.28      46.27      76.89      307.26      15.50      50.00
            101      AxialGradioMeter      101.64      -67.91      45.94      77.44      320.29      15.50      50.00
            102      AxialGradioMeter      115.21      -47.88      46.53      76.45      332.65      15.50      50.00
            103      AxialGradioMeter      122.55      -27.20      46.89      77.19      342.80      15.50      50.00
            104      AxialGradioMeter      127.25      -3.02      46.02      78.10      358.78      15.50      50.00
            105      AxialGradioMeter      123.33      22.74      47.05      76.66      14.38      15.50      50.00
            106      AxialGradioMeter      114.28      44.98      48.71      76.06      26.15      15.50      50.00
            107      AxialGradioMeter      100.95      65.30      48.50      76.51      38.37      15.50      50.00
            108      AxialGradioMeter      71.10      79.75      69.47      65.93      56.14      15.50      50.00
            109      AxialGradioMeter      50.94      6.27      131.20      24.23      14.13      15.50      50.00
            110      AxialGradioMeter      114.72      22.69      68.78      65.77      15.39      15.50      50.00
            111      AxialGradioMeter      118.54      -2.79      67.88      67.49      358.61      15.50      50.00
            112      AxialGradioMeter      116.59      -26.54      67.81      68.72      344.59      15.50      50.00
            113      AxialGradioMeter      50.55      -16.20      128.78      24.29      339.61      15.50      50.00
            114      AxialGradioMeter      93.77      -67.41      67.59      68.92      318.39      15.50      50.00
            115      AxialGradioMeter      15.87      -46.87      132.59      28.08      284.63      15.50      50.00
            116      AxialGradioMeter      54.28      -96.05      66.95      67.62      295.02      15.50      50.00
            117      AxialGradioMeter      30.14      -101.86      66.10      67.96      283.34      15.50      50.00
            118      AxialGradioMeter      8.25      -105.61      67.17      69.23      274.23      15.50      50.00
            119      AxialGradioMeter      -19.31      -105.28      69.82      68.04      260.50      15.50      50.00
            120      AxialGradioMeter      -28.66      -29.56      136.44      20.12      231.47      15.50      50.00
            121      AxialGradioMeter      -85.25      -69.42      76.84      64.09      221.53      15.50      50.00
            122      AxialGradioMeter      -98.49      -52.20      79.68      61.32      211.56      15.50      50.00
            123      AxialGradioMeter      -106.19      -29.80      80.82      59.38      197.48      15.50      50.00
            124      AxialGradioMeter      -107.20      -5.66      79.31      59.68      180.91      15.50      50.00
            125      AxialGradioMeter      -34.16      -3.92      133.41      16.56      178.97      15.50      50.00
            126      AxialGradioMeter      -104.50      18.09      81.30      58.99      164.91      15.50      50.00
            127      AxialGradioMeter      -84.61      57.82      78.81      62.27      137.75      15.50      50.00
            128      AxialGradioMeter      -31.45      20.16      132.97      21.40      142.17      15.50      50.00
            129      AxialGradioMeter      -24.67      99.30      77.17      64.40      102.39      15.50      50.00
            130      AxialGradioMeter      0.50      98.43      73.13      64.88      91.65      15.50      50.00
            131      AxialGradioMeter      25.01      100.44      73.59      66.18      81.51      15.50      50.00
            132      AxialGradioMeter      49.12      89.66      72.60      64.49      66.44      15.50      50.00
            133      AxialGradioMeter      15.66      38.99      136.10      24.72      75.54      15.50      50.00
            134      AxialGradioMeter      63.68      73.83      90.07      57.82      57.20      15.50      50.00
            135      AxialGradioMeter      40.37      82.24      90.08      57.17      69.86      15.50      50.00
            136      AxialGradioMeter      -6.96      88.86      95.08      54.46      94.02      15.50      50.00
            137      AxialGradioMeter      -51.97      72.92      98.27      52.10      118.09      15.50      50.00
            138      AxialGradioMeter      -70.11      58.24      100.65      51.02      133.91      15.50      50.00
            139      AxialGradioMeter      21.10      15.98      141.24      12.93      47.05      15.50      50.00
            140      AxialGradioMeter      -92.21      16.72      101.51      47.67      165.57      15.50      50.00
            141      AxialGradioMeter      -90.64      -28.24      99.39      48.89      197.90      15.50      50.00
            142      AxialGradioMeter      -2.79      15.45      137.65      9.03      103.52      15.50      50.00
            143      AxialGradioMeter      -67.68      -66.29      93.79      55.17      229.78      15.50      50.00
            144      AxialGradioMeter      -47.99      -79.48      91.94      55.93      244.35      15.50      50.00
            145      AxialGradioMeter      -4.98      -94.08      86.86      58.75      268.14      15.50      50.00
            146      AxialGradioMeter      -2.52      -23.87      136.09      12.36      269.20      15.50      50.00
            147      AxialGradioMeter      60.55      -79.22      86.26      59.49      301.42      15.50      50.00
            148      AxialGradioMeter      92.51      -45.52      87.79      55.77      327.74      15.50      50.00
            149      AxialGradioMeter      19.19      -22.85      139.89      12.83      304.40      15.50      50.00
            150      AxialGradioMeter      101.61      18.60      89.81      54.46      13.53      15.50      50.00
            151      AxialGradioMeter      93.46      39.51      90.16      56.06      28.44      15.50      50.00
            152      AxialGradioMeter      32.76      -77.03      102.81      49.77      287.95      15.50      50.00
            153      AxialGradioMeter      91.10      -2.48      108.78      44.91      357.53      15.50      50.00
            154      AxialGradioMeter      89.01      -27.69      106.51      46.94      338.88      15.50      50.00
            155      AxialGradioMeter      74.48      -48.88      104.18      48.38      322.13      15.50      50.00
            156      AxialGradioMeter      102.10      -26.23      86.99      56.04      343.16      15.50      50.00
            ];
        x = MEG_channel_coordinates_157(:,3);
        y = MEG_channel_coordinates_157(:,4);
        z = MEG_channel_coordinates_157(:,5);
        
    case 'mmh2'
        if exist('MEG_channel_coordinates_157.txt','file') % used to be called testcoor157.txt
            [index,name,x,y,z,alpha,beta,radius,baseline] = textread('MEG_channel_coordinates_157.txt','%d%s%f%f%f%f%f%f%f'); %#ok<NASGU>
        else
            AxialGradioMeter = 1;
            MEG_channel_coordinates_157 = [
                0        AxialGradioMeter      77.48    91.71   -58.68    97.31    58.10   15.50   50.00
                1        AxialGradioMeter      56.28   105.15   -50.77    93.99    65.04   15.50   50.00
                2        AxialGradioMeter      35.81   115.02   -43.79    87.09    73.23   15.50   50.00
                3        AxialGradioMeter      10.68   120.84   -42.69    84.97    83.73   15.50   50.00
                4        AxialGradioMeter     -18.56   119.97   -40.68    83.68    96.60   15.50   50.00
                5        AxialGradioMeter     -43.24   114.67   -39.27    84.49   106.51   15.50   50.00
                6        AxialGradioMeter     -63.44   103.22   -43.81    90.91   114.27   15.50   50.00
                7        AxialGradioMeter     -84.75    89.73   -46.47    91.68   126.94   15.50   50.00
                8        AxialGradioMeter    -103.47    71.54   -44.68    91.48   138.82   15.50   50.00
                9        AxialGradioMeter    -117.79    50.30   -42.75    90.97   152.52   15.50   50.00
                10        AxialGradioMeter    -119.79    -5.42    57.87    72.35   184.31   15.50   50.00
                11        AxialGradioMeter    -127.60     7.09   -39.99    90.53   178.08   15.50   50.00
                12        AxialGradioMeter    -127.67   -14.88   -40.66    89.67   191.27   15.50   50.00
                13        AxialGradioMeter    -127.49   -18.32    17.46    84.54   192.76   15.50   50.00
                14        AxialGradioMeter    -111.62   -59.78   -46.71    93.47   218.37   15.50   50.00
                15        AxialGradioMeter     -94.80   -78.88   -49.19    94.87   230.15   15.50   50.00
                16        AxialGradioMeter     -74.15   -93.18   -47.08    93.20   241.46   15.50   50.00
                17        AxialGradioMeter     -55.90  -105.52   -44.53    89.23   247.18   15.50   50.00
                18        AxialGradioMeter     -34.20  -115.14   -44.97    85.65   255.43   15.50   50.00
                19        AxialGradioMeter      -9.83  -123.20   -44.98    85.00   265.11   15.50   50.00
                20        AxialGradioMeter      17.77  -121.17   -48.15    86.89   277.53   15.50   50.00
                21        AxialGradioMeter      40.33  -109.33   -51.46    92.10   286.38   15.50   50.00
                22        AxialGradioMeter      58.32   -98.79   -55.70    96.21   294.14   15.50   50.00
                23        AxialGradioMeter      78.94   -87.27   -56.84    95.59   300.79   15.50   50.00
                24        AxialGradioMeter      84.69   -85.41   -30.82    95.54   304.24   15.50   50.00
                25        AxialGradioMeter     -40.40   -69.31   107.99    49.10   245.26   15.50   50.00
                26        AxialGradioMeter      17.12  -119.43   -18.13    84.69   275.29   15.50   50.00
                27        AxialGradioMeter      -4.56  -118.70   -15.56    83.22   269.24   15.50   50.00
                28        AxialGradioMeter     -55.09  -108.85   -17.95    88.13   247.15   15.50   50.00
                29        AxialGradioMeter     -72.28   -30.09   115.40    39.26   209.56   15.50   50.00
                30        AxialGradioMeter     -92.42   -79.87   -21.14    96.08   231.19   15.50   50.00
                31        AxialGradioMeter     -76.87    -5.15   117.02    36.33   183.74   15.50   50.00
                32        AxialGradioMeter    -131.13   -16.26   -12.63    90.14   190.78   15.50   50.00
                33        AxialGradioMeter    -132.20     9.78   -10.64    88.63   174.61   15.50   50.00
                34        AxialGradioMeter    -114.90    55.51   -11.51    89.50   147.25   15.50   50.00
                35        AxialGradioMeter     -72.38    17.32   117.04    35.49   164.56   15.50   50.00
                36        AxialGradioMeter     -80.92    90.85   -21.21    97.78   125.55   15.50   50.00
                37        AxialGradioMeter     -59.79   103.81   -10.02    84.23   114.49   15.50   50.00
                38        AxialGradioMeter     -10.97   118.58   -14.41    84.23    93.56   15.50   50.00
                39        AxialGradioMeter      14.43   118.19   -16.67    85.09    83.49   15.50   50.00
                40        AxialGradioMeter     -46.75    56.59   114.66    40.94   124.37   15.50   50.00
                41        AxialGradioMeter      80.48    89.58   -32.43    99.74    55.08   15.50   50.00
                42        AxialGradioMeter      85.09    89.16     2.95    87.85    52.89   15.50   50.00
                43        AxialGradioMeter      63.82   101.72     3.37    90.42    63.53   15.50   50.00
                44        AxialGradioMeter      40.57   111.80     4.88    88.60    74.09   15.50   50.00
                45        AxialGradioMeter     -24.62    70.97   113.86    42.88   111.21   15.50   50.00
                46        AxialGradioMeter     -35.02   112.97     9.21    88.46   102.04   15.50   50.00
                47        AxialGradioMeter     -58.75   104.00    11.18    85.76   113.35   15.50   50.00
                48        AxialGradioMeter     -79.84    91.10    15.85    84.81   124.79   15.50   50.00
                49        AxialGradioMeter    -113.08    55.32    17.96    84.85   150.71   15.50   50.00
                50        AxialGradioMeter    -123.85    32.75    18.26    84.16   160.89   15.50   50.00
                51        AxialGradioMeter    -129.19     7.06    18.27    85.71   175.89   15.50   50.00
                52        AxialGradioMeter      38.09    73.33   107.91    47.42    65.83   15.50   50.00
                53        AxialGradioMeter    -120.59   -43.02    15.35    86.61   206.32   15.50   50.00
                54        AxialGradioMeter    -107.44   -64.99    13.44    86.69   219.65   15.50   50.00
                55        AxialGradioMeter     -72.77   -94.31     8.57    89.87   238.40   15.50   50.00
                56        AxialGradioMeter     -52.14  -110.56     7.46    90.02   247.64   15.50   50.00
                57        AxialGradioMeter     -21.42  -117.21     3.99    89.68   265.00   15.50   50.00
                58        AxialGradioMeter      75.13    41.73   106.72    44.41    35.31   15.50   50.00
                59        AxialGradioMeter      47.29  -113.28     0.08    91.41   288.47   15.50   50.00
                60        AxialGradioMeter      70.83   -97.76    -1.33    92.65   298.60   15.50   50.00
                61        AxialGradioMeter      88.25   -85.36    -2.63    93.95   306.29   15.50   50.00
                62        AxialGradioMeter      89.21   -83.32    21.18    86.71   307.04   15.50   50.00
                63        AxialGradioMeter      71.36   -97.09    19.73    87.98   299.81   15.50   50.00
                64        AxialGradioMeter      64.70    27.68   119.12    34.80    28.14   15.50   50.00
                65        AxialGradioMeter      22.34  -118.48    21.82    89.76   275.56   15.50   50.00
                66        AxialGradioMeter      -0.29  -117.97    20.71    91.07   268.35   15.50   50.00
                67        AxialGradioMeter      51.04    46.90   120.42    38.17    49.96   15.50   50.00
                68        AxialGradioMeter     -70.71   -94.17    31.25    83.81   239.16   15.50   50.00
                69        AxialGradioMeter     -88.51   -80.25    35.76    82.15   231.81   15.50   50.00
                70        AxialGradioMeter    -105.28   -61.85    37.16    81.32   219.16   15.50   50.00
                71        AxialGradioMeter       2.41    61.68   125.77    37.33    89.65   15.50   50.00
                72        AxialGradioMeter    -123.45   -16.80    38.44    80.94   191.94   15.50   50.00
                73        AxialGradioMeter     -25.83    53.32   126.16    32.89   109.84   15.50   50.00
                74        AxialGradioMeter    -120.30    30.25    39.94    78.99   161.86   15.50   50.00
                75        AxialGradioMeter    -111.05    51.63    40.96    78.03   150.50   15.50   50.00
                76        AxialGradioMeter     -95.94    72.67    40.49    77.30   136.03   15.50   50.00
                77        AxialGradioMeter     -76.96    90.47    38.31    78.37   123.57   15.50   50.00
                78        AxialGradioMeter     -55.73    16.51   129.05    27.86   161.90   15.50   50.00
                79        AxialGradioMeter      -5.70   116.21    30.63    82.49    94.39   15.50   50.00
                80        AxialGradioMeter      19.26   115.15    29.59    84.46    83.03   15.50   50.00
                81        AxialGradioMeter     -54.06   -28.04   124.58    33.32   215.77   15.50   50.00
                82        AxialGradioMeter      66.91    99.00    26.48    84.62    61.09   15.50   50.00
                83        AxialGradioMeter      87.48    86.02    27.91    82.07    52.33   15.50   50.00
                84        AxialGradioMeter      81.94    83.88    51.40    73.56    51.91   15.50   50.00
                85        AxialGradioMeter      41.23   106.51    50.89    76.00    72.86   15.50   50.00
                86        AxialGradioMeter     -21.79   -63.13   120.35    43.27   252.65   15.50   50.00
                87        AxialGradioMeter     -35.70   106.70    54.09    74.99   105.88   15.50   50.00
                88        AxialGradioMeter     -59.54    96.81    57.11    73.43   116.69   15.50   50.00
                89        AxialGradioMeter       6.35   -69.44   118.58    45.60   273.67   15.50   50.00
                90        AxialGradioMeter     -80.24    81.70    59.28    71.07   127.49   15.50   50.00
                91        AxialGradioMeter    -117.94    18.29    58.88    71.19   169.10   15.50   50.00
                92        AxialGradioMeter      53.15   -49.61   116.71    42.18   306.03   15.50   50.00
                93        AxialGradioMeter    -115.74   -30.06    57.03    73.50   199.47   15.50   50.00
                94        AxialGradioMeter     -92.73   -70.60    54.64    74.53   225.90   15.50   50.00
                95        AxialGradioMeter      65.29   -31.85   116.79    37.40   322.80   15.50   50.00
                96        AxialGradioMeter     -54.80   -99.61    49.47    77.29   247.57   15.50   50.00
                97        AxialGradioMeter     -31.41  -112.06    49.83    77.27   257.77   15.50   50.00
                98        AxialGradioMeter      72.19     8.11   118.18    34.42     7.67   15.50   50.00
                99        AxialGradioMeter      43.48  -108.39    44.39    79.58   286.69   15.50   50.00
                100        AxialGradioMeter      82.93   -84.60    46.01    76.55   303.38   15.50   50.00
                101        AxialGradioMeter     100.65   -70.04    44.65    78.71   312.68   15.50   50.00
                102        AxialGradioMeter     116.09   -50.89    45.34    78.03   326.12   15.50   50.00
                103        AxialGradioMeter     126.15   -26.48    46.13    76.63   341.01   15.50   50.00
                104        AxialGradioMeter     130.77     0.55    47.11    75.20     0.54   15.50   50.00
                105        AxialGradioMeter     126.00    27.34    47.03    75.87    16.56   15.50   50.00
                106        AxialGradioMeter     115.57    49.65    48.86    75.56    29.47   15.50   50.00
                107        AxialGradioMeter     101.18    68.11    48.71    74.98    41.82   15.50   50.00
                108        AxialGradioMeter      89.61    67.58    71.22    64.90    44.67   15.50   50.00
                109        AxialGradioMeter      54.79     6.70   128.78    25.89     4.39   15.50   50.00
                110        AxialGradioMeter      86.50    19.28   108.47    42.69    13.24   15.50   50.00
                111        AxialGradioMeter     121.65    -0.17    70.06    65.53   358.60   15.50   50.00
                112        AxialGradioMeter     117.18   -27.51    69.17    66.62   339.63   15.50   50.00
                113        AxialGradioMeter      54.03   -15.06   127.99    26.14   335.96   15.50   50.00
                114        AxialGradioMeter      91.70   -69.21    66.57    69.73   311.37   15.50   50.00
                115        AxialGradioMeter      20.37   -48.71   131.09    33.12   284.84   15.50   50.00
                116        AxialGradioMeter      54.40   -94.98    65.60    70.88   291.34   15.50   50.00
                117        AxialGradioMeter      34.32  -103.09    65.59    70.80   285.53   15.50   50.00
                118        AxialGradioMeter      10.23  -105.39    68.36    68.80   273.64   15.50   50.00
                119        AxialGradioMeter     -17.04  -103.96    69.15    68.37   261.41   15.50   50.00
                120        AxialGradioMeter     -31.26   -30.03   135.36    25.34   232.85   15.50   50.00
                121        AxialGradioMeter     -80.50   -72.42    75.32    66.22   232.65   15.50   50.00
                122        AxialGradioMeter     -94.45   -55.06    77.76    64.18   218.31   15.50   50.00
                123        AxialGradioMeter    -105.34   -34.54    79.14    63.10   205.92   15.50   50.00
                124        AxialGradioMeter    -110.81   -11.75    80.62    61.63   191.64   15.50   50.00
                125        AxialGradioMeter     -38.85    -4.54   136.36    18.86   192.00   15.50   50.00
                126        AxialGradioMeter    -102.44    34.05    84.97    57.42   158.26   15.50   50.00
                127        AxialGradioMeter     -87.74    57.79    83.19    59.23   139.88   15.50   50.00
                128        AxialGradioMeter     -33.50    21.87   137.26    21.54   143.63   15.50   50.00
                129        AxialGradioMeter     -27.30   100.59    77.06    64.20   103.67   15.50   50.00
                130        AxialGradioMeter       2.71   103.33    74.00    65.22    88.24   15.50   50.00
                131        AxialGradioMeter      29.96   101.22    72.45    66.67    76.20   15.50   50.00
                132        AxialGradioMeter      52.42    93.93    71.82    66.52    66.70   15.50   50.00
                133        AxialGradioMeter      19.95    40.88   135.47    25.58    69.64   15.50   50.00
                134        AxialGradioMeter      64.82    75.19    90.09    56.32    58.50   15.50   50.00
                135        AxialGradioMeter      45.97    85.46    90.00    56.24    66.17   15.50   50.00
                136        AxialGradioMeter      -7.71    92.02    94.69    56.26    96.28   15.50   50.00
                137        AxialGradioMeter     -54.67    73.44    98.20    52.63   122.60   15.50   50.00
                138        AxialGradioMeter     -71.59    56.36   101.72    48.24   135.31   15.50   50.00
                139        AxialGradioMeter      26.56    18.62   140.83    17.20    38.57   15.50   50.00
                140        AxialGradioMeter     -92.22    16.12   102.62    48.07   167.86   15.50   50.00
                141        AxialGradioMeter     -90.55   -32.33   100.28    49.69   206.00   15.50   50.00
                142        AxialGradioMeter      -1.11    18.61   144.80    10.16    93.16   15.50   50.00
                143        AxialGradioMeter     -67.28   -69.80    93.37    58.23   236.68   15.50   50.00
                144        AxialGradioMeter     -48.69   -81.91    91.19    59.51   245.75   15.50   50.00
                145        AxialGradioMeter      -4.33   -95.55    85.83    62.42   267.52   15.50   50.00
                146        AxialGradioMeter      -0.90   -27.57   142.88    17.34   267.09   15.50   50.00
                147        AxialGradioMeter      61.99   -80.90    85.73    61.87   296.05   15.50   50.00
                148        AxialGradioMeter      92.90   -50.73    87.19    58.19   320.19   15.50   50.00
                149        AxialGradioMeter      25.31   -26.50   138.85    20.10   302.69   15.50   50.00
                150        AxialGradioMeter     105.58    18.70    92.26    53.45    12.34   15.50   50.00
                151        AxialGradioMeter      97.81    41.18    95.87    51.50    29.24   15.50   50.00
                152        AxialGradioMeter      38.82   -78.56   100.91    55.40   289.05   15.50   50.00
                153        AxialGradioMeter      89.52    -4.64   107.41    43.48   352.57   15.50   50.00
                154        AxialGradioMeter      85.97   -27.66   105.56    45.05   333.15   15.50   50.00
                155        AxialGradioMeter      74.98   -47.02   103.48    48.05   317.62   15.50   50.00
                156        AxialGradioMeter     -17.47   -81.12   105.10    53.26   260.86   15.50   50.00
                ];
            x = MEG_channel_coordinates_157(:,3);
            y = MEG_channel_coordinates_157(:,4);
            z = MEG_channel_coordinates_157(:,5);
        end
        
    case 'mmh1';
        AxialGradioMeter = 1;
        MEG_channel_coordinates_157_old = [
            0        AxialGradioMeter      82.83    89.29   -61.60    94.19    54.83   15.50   50.00
            1        AxialGradioMeter      60.41   103.57   -56.45    93.33    62.72   15.50   50.00
            2        AxialGradioMeter      40.34   113.63   -49.20    87.39    71.11   15.50   50.00
            3        AxialGradioMeter      17.02   120.77   -48.00    84.67    80.59   15.50   50.00
            4        AxialGradioMeter     -12.46   122.57   -46.71    82.95    93.40   15.50   50.00
            5        AxialGradioMeter     -37.99   118.27   -45.81    84.00   103.66   15.50   50.00
            6        AxialGradioMeter     -58.74   107.88   -49.35    88.86   111.40   15.50   50.00
            7        AxialGradioMeter     -80.94    95.59   -51.74    89.06   124.09   15.50   50.00
            8        AxialGradioMeter    -100.93    78.04   -51.89    89.81   136.01   15.50   50.00
            9        AxialGradioMeter    -116.44    56.41   -51.38    90.60   150.07   15.50   50.00
            10        AxialGradioMeter    -124.88    34.19   -48.84    89.65   162.19   15.50   50.00
            11        AxialGradioMeter    -128.34    12.97   -48.35    89.57   176.16   15.50   50.00
            12        AxialGradioMeter    -128.58    -8.86   -49.38    89.74   189.32   15.50   50.00
            13        AxialGradioMeter    -124.25   -28.02   -51.98    92.57   196.01   15.50   50.00
            14        AxialGradioMeter    -114.69   -51.80   -55.87    93.17   214.36   15.50   50.00
            15        AxialGradioMeter     -99.63   -72.58   -58.70    94.53   226.58   15.50   50.00
            16        AxialGradioMeter     -78.83   -88.70   -57.48    93.82   238.90   15.50   50.00
            17        AxialGradioMeter     -59.45  -100.79   -56.34    91.89   245.87   15.50   50.00
            18        AxialGradioMeter     -38.32  -109.28   -57.04    89.36   253.84   15.50   50.00
            19        AxialGradioMeter     -16.13  -118.01   -58.23    89.43   262.40   15.50   50.00
            20        AxialGradioMeter      10.21  -117.66   -60.37    90.56   273.46   15.50   50.00
            21        AxialGradioMeter      32.67  -108.56   -61.62    94.03   282.12   15.50   50.00
            22        AxialGradioMeter      52.46   -99.99   -63.73    96.16   291.00   15.50   50.00
            23        AxialGradioMeter      73.92   -89.58   -64.19    95.40   298.19   15.50   50.00
            24        AxialGradioMeter      79.32   -87.97   -40.44    97.39   301.89   15.50   50.00
            25        AxialGradioMeter     -45.69   -69.37    98.03    50.12   243.52   15.50   50.00
            26        AxialGradioMeter      12.98  -121.28   -28.35    85.28   274.55   15.50   50.00
            27        AxialGradioMeter     -11.53  -121.31   -27.06    84.32   265.96   15.50   50.00
            28        AxialGradioMeter     -59.89  -103.42   -30.52    91.24   245.43   15.50   50.00
            29        AxialGradioMeter     -76.98   -30.71   106.32    41.34   209.68   15.50   50.00
            30        AxialGradioMeter     -97.21   -74.47   -34.06    98.53   228.28   15.50   50.00
            31        AxialGradioMeter     -80.93    -4.89   108.82    37.71   184.05   15.50   50.00
            32        AxialGradioMeter    -130.75    -8.65   -24.24    92.66   186.89   15.50   50.00
            33        AxialGradioMeter    -130.58    16.02   -21.98    91.02   171.94   15.50   50.00
            34        AxialGradioMeter    -112.96    60.22   -21.77    91.09   145.38   15.50   50.00
            35        AxialGradioMeter     -75.29    18.42   109.40    36.57   163.38   15.50   50.00
            36        AxialGradioMeter     -77.40    95.34   -27.04    95.25   122.77   15.50   50.00
            37        AxialGradioMeter     -55.97   107.24   -15.88    82.78   111.96   15.50   50.00
            38        AxialGradioMeter      -5.81   119.99   -18.94    82.12    90.67   15.50   50.00
            39        AxialGradioMeter      19.97   118.24   -20.75    83.01    80.18   15.50   50.00
            40        AxialGradioMeter     -47.04    55.94   107.98    40.20   123.31   15.50   50.00
            41        AxialGradioMeter      84.68    86.47   -35.09    96.17    52.22   15.50   50.00
            42        AxialGradioMeter      88.30    85.19    -1.90    87.29    50.34   15.50   50.00
            43        AxialGradioMeter      67.46    98.40     0.05    87.87    60.83   15.50   50.00
            44        AxialGradioMeter      44.82   109.52     1.28    86.04    71.12   15.50   50.00
            45        AxialGradioMeter     -24.22    69.04   107.37    41.89   109.71   15.50   50.00
            46        AxialGradioMeter     -30.65   114.40     4.13    86.36    99.14   15.50   50.00
            47        AxialGradioMeter     -54.82   106.55     5.71    83.53   110.57   15.50   50.00
            48        AxialGradioMeter     -76.76    94.84     6.87    86.33   122.08   15.50   50.00
            49        AxialGradioMeter    -111.67    61.11     8.35    86.01   147.53   15.50   50.00
            50        AxialGradioMeter    -123.94    39.44     7.89    85.64   157.32   15.50   50.00
            51        AxialGradioMeter    -131.55    13.90     7.15    87.56   172.21   15.50   50.00
            52        AxialGradioMeter      38.02    68.95   102.87    45.64    63.96   15.50   50.00
            53        AxialGradioMeter    -124.71   -38.09     2.91    89.37   203.90   15.50   50.00
            54        AxialGradioMeter    -112.42   -60.57     0.18    90.00   217.18   15.50   50.00
            55        AxialGradioMeter     -77.41   -90.69    -5.10    94.13   236.88   15.50   50.00
            56        AxialGradioMeter     -59.14  -106.50    -4.14    91.10   244.16   15.50   50.00
            57        AxialGradioMeter     -29.55  -117.63    -5.43    88.68   260.75   15.50   50.00
            58        AxialGradioMeter      74.10    35.52   102.35    42.33    31.30   15.50   50.00
            59        AxialGradioMeter      39.31  -116.15    -8.94    91.17   284.26   15.50   50.00
            60        AxialGradioMeter      65.65  -101.67    -9.59    92.39   296.67   15.50   50.00
            61        AxialGradioMeter      83.12   -88.72   -12.01    95.86   304.53   15.50   50.00
            62        AxialGradioMeter      84.11   -87.28    12.38    87.90   305.32   15.50   50.00
            63        AxialGradioMeter      66.08  -101.72    10.69    89.18   298.08   15.50   50.00
            64        AxialGradioMeter      62.10    22.14   113.79    33.02    24.73   15.50   50.00
            65        AxialGradioMeter      13.61  -117.04    11.32    90.83   271.37   15.50   50.00
            66        AxialGradioMeter      -5.49  -115.29    11.06    91.39   267.61   15.50   50.00
            67        AxialGradioMeter      49.26    41.30   115.06    36.02    47.02   15.50   50.00
            68        AxialGradioMeter     -75.98   -91.09    20.69    84.43   237.02   15.50   50.00
            69        AxialGradioMeter     -93.76   -77.32    25.18    83.00   229.90   15.50   50.00
            70        AxialGradioMeter    -110.29   -58.14    26.99    81.76   217.02   15.50   50.00
            71        AxialGradioMeter       1.37    58.22   119.45    35.89    89.02   15.50   50.00
            72        AxialGradioMeter    -126.39   -11.74    29.51    80.80   189.31   15.50   50.00
            73        AxialGradioMeter     -26.67    50.84   119.31    31.55   109.52   15.50   50.00
            74        AxialGradioMeter    -120.57    36.43    31.57    78.87   158.17   15.50   50.00
            75        AxialGradioMeter    -109.96    57.37    32.89    77.69   146.99   15.50   50.00
            76        AxialGradioMeter     -93.57    77.15    32.83    76.69   132.89   15.50   50.00
            77        AxialGradioMeter     -74.17    93.54    30.70    78.10   120.90   15.50   50.00
            78        AxialGradioMeter     -57.45    15.89   121.44    27.53   161.98   15.50   50.00
            79        AxialGradioMeter      -1.62   115.40    25.97    80.53    91.72   15.50   50.00
            80        AxialGradioMeter      23.13   113.25    25.23    82.58    80.33   15.50   50.00
            81        AxialGradioMeter     -57.65   -28.02   115.98    33.75   214.64   15.50   50.00
            82        AxialGradioMeter      69.85    94.92    22.85    82.47    58.40   15.50   50.00
            83        AxialGradioMeter      90.25    81.49    22.55    81.83    49.72   15.50   50.00
            84        AxialGradioMeter      83.87    78.65    47.25    71.80    49.21   15.50   50.00
            85        AxialGradioMeter      44.05   103.13    46.67    74.21    70.33   15.50   50.00
            86        AxialGradioMeter     -28.38   -63.58   110.25    44.44   249.02   15.50   50.00
            87        AxialGradioMeter     -31.93   106.77    48.52    73.43   102.79   15.50   50.00
            88        AxialGradioMeter     -56.64    98.37    50.49    72.67   114.11   15.50   50.00
            89        AxialGradioMeter      -1.36   -71.58   108.67    46.80   269.13   15.50   50.00
            90        AxialGradioMeter     -77.79    84.34    52.38    70.05   124.89   15.50   50.00
            91        AxialGradioMeter    -117.97    22.91    50.23    71.02   166.16   15.50   50.00
            92        AxialGradioMeter      47.62   -55.30   109.17    43.50   301.13   15.50   50.00
            93        AxialGradioMeter    -118.29   -23.85    47.65    73.34   194.98   15.50   50.00
            94        AxialGradioMeter     -98.02   -66.76    44.93    75.13   223.25   15.50   50.00
            95        AxialGradioMeter      60.75   -37.70   110.18    37.96   317.38   15.50   50.00
            96        AxialGradioMeter     -61.20   -97.87    38.65    78.47   244.81   15.50   50.00
            97        AxialGradioMeter     -38.48  -112.51    38.22    79.60   255.03   15.50   50.00
            98        AxialGradioMeter      69.06     2.35   112.76    33.14     3.04   15.50   50.00
            99        AxialGradioMeter      35.24  -113.77    33.94    81.62   282.61   15.50   50.00
            100        AxialGradioMeter      77.60   -88.76    37.99    76.72   301.57   15.50   50.00
            101        AxialGradioMeter      95.19   -74.91    36.89    78.91   310.10   15.50   50.00
            102        AxialGradioMeter     111.20   -57.07    38.07    78.07   322.94   15.50   50.00
            103        AxialGradioMeter     122.26   -34.15    39.52    76.42   336.79   15.50   50.00
            104        AxialGradioMeter     128.40    -7.81    41.57    74.19   356.07   15.50   50.00
            105        AxialGradioMeter     125.39    19.55    42.16    74.55    12.87   15.50   50.00
            106        AxialGradioMeter     116.29    43.10    44.00    74.64    26.70   15.50   50.00
            107        AxialGradioMeter     102.67    62.59    43.87    74.05    39.35   15.50   50.00
            108        AxialGradioMeter      90.48    62.04    66.65    63.57    42.09   15.50   50.00
            109        AxialGradioMeter      51.02     1.46   122.65    24.52   358.98   15.50   50.00
            110        AxialGradioMeter     115.95    19.66    65.18    65.19    13.86   15.50   50.00
            111        AxialGradioMeter     119.19    -8.43    64.15    64.77   354.04   15.50   50.00
            112        AxialGradioMeter     113.29   -35.11    62.18    66.82   335.41   15.50   50.00
            113        AxialGradioMeter      49.62   -20.17   121.51    25.80   329.88   15.50   50.00
            114        AxialGradioMeter      86.24   -74.15    58.66    70.08   308.69   15.50   50.00
            115        AxialGradioMeter      13.42   -52.74   122.38    34.66   279.01   15.50   50.00
            116        AxialGradioMeter      48.80   -99.17    56.85    71.45   289.65   15.50   50.00
            117        AxialGradioMeter      25.85  -107.83    57.15    70.58   281.18   15.50   50.00
            118        AxialGradioMeter       2.12  -109.18    59.09    69.30   269.85   15.50   50.00
            119        AxialGradioMeter     -24.02  -105.99    59.48    69.15   259.27   15.50   50.00
            120        AxialGradioMeter     -35.70   -30.63   125.65    26.15   230.06   15.50   50.00
            121        AxialGradioMeter     -86.50   -70.22    64.04    68.58   229.84   15.50   50.00
            122        AxialGradioMeter     -99.71   -51.96    66.53    66.62   215.70   15.50   50.00
            123        AxialGradioMeter    -109.74   -28.62    68.67    64.73   201.02   15.50   50.00
            124        AxialGradioMeter    -113.52    -4.37    70.17    63.18   184.88   15.50   50.00
            125        AxialGradioMeter     -41.51    -5.71   127.35    19.10   192.45   15.50   50.00
            126        AxialGradioMeter    -102.63    39.36    75.25    59.25   153.91   15.50   50.00
            127        AxialGradioMeter     -87.14    61.03    75.03    59.72   137.47   15.50   50.00
            128        AxialGradioMeter     -35.29    19.04   128.48    20.80   146.44   15.50   50.00
            129        AxialGradioMeter     -22.64   100.31    71.80    62.65    98.79   15.50   50.00
            130        AxialGradioMeter       4.86   101.39    69.00    63.68    86.35   15.50   50.00
            131        AxialGradioMeter      30.75    98.39    68.18    64.71    75.62   15.50   50.00
            132        AxialGradioMeter      53.86    89.84    67.72    64.64    64.65   15.50   50.00
            133        AxialGradioMeter      17.65    36.65   129.13    23.78    68.81   15.50   50.00
            134        AxialGradioMeter      65.15    70.45    85.63    54.85    56.53   15.50   50.00
            135        AxialGradioMeter      46.19    81.43    85.55    54.32    64.88   15.50   50.00
            136        AxialGradioMeter      -6.21    89.65    89.21    54.56    94.49   15.50   50.00
            137        AxialGradioMeter     -53.27    74.08    91.66    51.75   120.25   15.50   50.00
            138        AxialGradioMeter     -71.56    58.08    94.44    48.31   133.33   15.50   50.00
            139        AxialGradioMeter      23.08    14.09   134.21    15.30    34.72   15.50   50.00
            140        AxialGradioMeter     -95.77    15.82    93.66    49.70   170.18   15.50   50.00
            141        AxialGradioMeter     -95.03   -33.14    89.33    52.98   207.26   15.50   50.00
            142        AxialGradioMeter      -4.98    15.02   137.20     8.88   102.47   15.50   50.00
            143        AxialGradioMeter     -72.91   -69.42    82.58    60.56   234.65   15.50   50.00
            144        AxialGradioMeter     -54.02   -81.83    81.17    60.57   244.18   15.50   50.00
            145        AxialGradioMeter     -12.32   -96.48    76.85    62.23   263.38   15.50   50.00
            146        AxialGradioMeter      -7.00   -30.70   133.70    19.12   259.71   15.50   50.00
            147        AxialGradioMeter      55.54   -85.71    77.04    62.93   292.96   15.50   50.00
            148        AxialGradioMeter      88.00   -57.23    79.45    59.02   316.51   15.50   50.00
            149        AxialGradioMeter      19.42   -31.25   131.03    21.18   293.61   15.50   50.00
            150        AxialGradioMeter     103.81    15.62    86.41    53.48    13.79   15.50   50.00
            151        AxialGradioMeter      97.21    35.88    90.70    50.96    27.23   15.50   50.00
            152        AxialGradioMeter      31.94   -82.41    91.52    56.69   286.16   15.50   50.00
            153        AxialGradioMeter      86.72   -11.35   101.53    43.27   347.67   15.50   50.00
            154        AxialGradioMeter      81.86   -35.39    98.80    45.92   326.98   15.50   50.00
            155        AxialGradioMeter      69.55   -54.45    95.95    49.44   311.63   15.50   50.00
            156        AxialGradioMeter     -25.14   -81.26    94.92    54.17   256.57   15.50   50.00
            ];
        x = MEG_channel_coordinates_157_old(:,3);
        y = MEG_channel_coordinates_157_old(:,4);
        z = MEG_channel_coordinates_157_old(:,5);
        
    otherwise
        error('Error: disallowed channel_config')
end


alphaCorr = acos(z./max(z));   % use z to get the correct alpha, which is the angle with z-axis (in spherical coordinates). Z represents the depth. Angle of 0 = top of the head. Angle of 90 = further down
betaCorr = -atan2(y,x);        % use x,y to get the correct beta, which is the angle with x-axis (in spherical coordinates)

% flatten the sphere
xx =  alphaCorr.*sin(betaCorr); %alpha is telling you how far out you are in the scalp
yy =  alphaCorr.*cos(betaCorr);

end

function drawTopoHead(R)

% R = 2.25;
step = 0.02;
headpts = -R:step:R;
plot(headpts, sqrt(abs(R.^2-headpts.^2)),'k',headpts, -sqrt(abs(R.^2-headpts.^2)),'k')
plot([-0.1 0 0.1],[R R+0.2 R],'k')

earR=0.2;
earptsL = -R-earR:step:-R+.02;
plot(earptsL,sqrt(abs(earR.^2-(earptsL+R).^2)),'k',earptsL,-sqrt(abs(earR.^2-(earptsL+R).^2)),'k')
earptsR = R-.02:step:R+earR;
plot(earptsR,sqrt(abs(earR.^2-(earptsR-R).^2)),'k',earptsR,-sqrt(abs(earR.^2-(earptsR-R).^2)),'k')

earR=0.1;
earptsL = -R-earR:step:-R+.02;
plot(earptsL,sqrt(abs(earR.^2-(earptsL+R).^2)),'k',earptsL,-sqrt(abs(earR.^2-(earptsL+R).^2)),'k')
earptsR = R-.02:step:R+earR;
plot(earptsR,sqrt(abs(earR.^2-(earptsR-R).^2)),'k',earptsR,-sqrt(abs(earR.^2-(earptsR-R).^2)),'k')

end


function phasorArrows(x,y,xlen,ylen,linewidth,headwidth,headheight)
line( [x,x+xlen].',[y,y+ylen].','LineWidth',linewidth,'Color','Black');

theta = atan2(ylen,xlen)-pi/2;
arrowLength = sqrt(xlen.^2+ylen.^2);
aHeadLength = arrowLength*headheight;
aHeadWidth = arrowLength*headwidth;

c = cos(theta);
s = sin(theta);
x0 =  (x+xlen).*c + (y+ylen).*s;                                % build head coordinats
y0 = -(x+xlen).*s + (y+ylen).*c;
for mm=1:length(x)
    R = [c(mm) -s(mm);s(mm) c(mm)];
    coords = R*[x0(mm) x0(mm)+aHeadWidth(mm)/2 x0(mm)-aHeadWidth(mm)/2; y0(mm) y0(mm)-aHeadLength(mm) y0(mm)-aHeadLength(mm)];
    patch(coords(1,:),coords(2,:),[0 0 0],'LineWidth',linewidth);
end

end
