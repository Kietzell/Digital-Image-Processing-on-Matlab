function exploreRGB(input, mode)
% Explore RGB imagery, plane by plane, and as grayscale
%
% ExploreRGB facilitates the viewing of all color planes, and grayscale and
% RGB versions, of input RGB image. The different colorplanes or
% conversions can be "selected" for export to the base workspace.
%
% exploreRGB(input)
%     Simplest syntax: Simply view grayscale and color-plane options.
%
% exploreRGB(input, mode)
%     Mode can be specified as either 'simple','normal', or 'advanced.'
%     (Default is 'normal', and is equivalent to using the simpler syntax
%     above.)
%
%     'simple' suppresses the output radio buttons, and is nice for quick
%     visualization.
%
%     'advanced' includes the export options (like 'normal'), but also
%     shows visualization of the RGB image as HSV, YCbCr, and LAB
%
%     Alternatively, 'mode' may be specified as:
%     1 (= 'normal'), 2 (= 'simple'), or 3 (= 'advanced').
%
%%% EXAMPLE:
% rgbImg = imread('peppers.png');
% exploreRGB(rgbImg)
%
% exploreRGB(rgbImg,'advanced')
% exploreRGB(rgbImg,1)
%
% Written by Brett Shoelson, PhD
% brett.shoelson@mathworks.com
% 4/24/08
%
% Modified 2/18/2010 to provide more 'mode' control. Implemented 'simple'
% mode, and 'normal' as a default.
%
% Copyright 2008--2010 The MathWorks, Inc." 

if ischar(input)
    input = imread(input);
end

if nargin < 2
    mode = 'normal';
elseif isnumeric(mode)
    if mode == 1, mode = 'normal';
    elseif mode == 2, mode = 'simple';
    elseif mode == 3, mode = 'advanced';
    else mode = 'none';
    end
end
if ~ismember(lower(mode),{'normal','simple','advanced'})
    error('ExploreRGB: If specified, ''mode'' must be one of: ''normal'',''simple'',''advanced''.')
end

% Clear the current figure
figure('numbertitle','off','name','ExploreRGB',...
    'color',[0.1 0.1 0.1],'windowstyle','normal',...
    'units','normalized','position',[0.2 0.2 0.6 0.6]);

% Subplots
if strcmp(mode,'advanced')
    nrows = 5;
else
    nrows = 2;
end
ax(1) = subplot(nrows,3,1.5);
imshow(input);
setappdata(gca,'currIm',input);
title('Original (RGB)','color','w','fontsize',14);

ax(2) = subplot(nrows,3,2.5);
img = rgb2gray(input);
imshow(img);
setappdata(gca,'currIm',img);
title('Grayscaled','color',[0.4 0.4 0.4],'fontsize',14);

ind = 3;
ax(ind) = subplot(nrows,3,ind+1);
img = input(:,:,1);
imshow(img);
setappdata(gca,'currIm',img);
title('Red Plane','color',[0.7 0 0],'fontsize',14);

ind = ind+1;
ax(ind) = subplot(nrows,3,ind+1);
img = input(:,:,2);
imshow(img);
setappdata(gca,'currIm',img);
title('Green Plane','color',[0 0.7 0],'fontsize',14);

ind = ind+1;
ax(ind) = subplot(nrows,3,ind+1);
img = input(:,:,3);
imshow(img);
setappdata(gca,'currIm',img);
title('Blue Plane','color','b','fontsize',14)

if strcmp(mode,'advanced')
    hsv = rgb2hsv(input);
    titleColor = [1 0 1]*0.6;
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = hsv(:,:,1);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('Hue','color',titleColor,'fontsize',14)
    
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = hsv(:,:,2);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('Saturation','color',titleColor,'fontsize',14)
    
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = hsv(:,:,3);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('Value','color',titleColor,'fontsize',14)
    
    ycbcr = rgb2ycbcr(input);
    titleColor = [0 1 1]*0.6;
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = ycbcr(:,:,1);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('Luminance','color',titleColor,'fontsize',14)
    
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = ycbcr(:,:,2);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('Red Chrominance','color',titleColor,'fontsize',14)
    
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = ycbcr(:,:,3);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('Blue Chrominance','color',titleColor,'fontsize',14)
    
    %LAB
    cform = makecform('srgb2lab');
    lab = applycform(input,cform);
    titleColor = [1 1 0]*0.6;
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = lab(:,:,1);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('L*a*b* -> L*','color',titleColor,'fontsize',14)
    
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = lab(:,:,2);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('L*a*b* -> a*','color',titleColor,'fontsize',14)
    
    ind = ind+1;
    ax(ind) = subplot(nrows,3,ind+1);
    img = lab(:,:,3);
    imshow(img);
    setappdata(gca,'currIm',img);
    title('L*a*b* -> b*','color',titleColor,'fontsize',14)
end
expandAxes(ax)
shg

if 0 && ~strcmp(mode,'simple')
    radBut = zeros(size(ax));
    if strcmp(mode,'advanced')
        mult = 0.95;
    else
        mult = 1.0;
    end
    for ii = 1:length(ax)
        pos = get(ax(ii),'pos');
        radBut(ii) = uicontrol('style','radio','units','normalized',...
            'pos',[pos(1) pos(2)*mult pos(3) 0.025],'backgroundcolor',[0.1 0.1 0.1],...
            'foregroundcolor','w','string','Select','callback',@useThis);
    end
end

    function imgOut = useThis(varargin)
        set(radBut,'value',0);
        set(varargin{1},'value',1);
        imgOut = getappdata(ax(varargin{1}==radBut),'currIm');
        assignin('base','imgOut',imgOut);
        disp('Selected image written to base workspace variable ''imgOut''.');
        try
            [wav,freq] = wavread('notify.wav');
            sound(wav,freq);
        end
    end

end
