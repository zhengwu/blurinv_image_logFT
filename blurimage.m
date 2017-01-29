function [smooth smoothF log_F log_smoothF] = blurimage(I,delta)

%blur image
%input  I:2D image metric
%       delta: blurring amount
%output smooth: blurred image metric.
%       smoothF: blurrred image Fouier Transform
%       log_F: 
%       log_smoothF

F = fft2(I);

nx = size(F, 2);
ny = size(F, 1);


cxrange = [0:nx/2, -nx/2+1:-1];        % cycles across the image
cyrange = [0:ny/2, -ny/2+1:-1];
[cx, cy] = meshgrid(cxrange, cyrange);

fxrange = cxrange * 2*pi/nx;           % radians per pixel
fyrange = cyrange * 2*pi/ny;
[fx, fy] = meshgrid(fxrange, fyrange);


%blur with sd=sigma;
g_blur = exp(-(fx.^2 + fy.^2)*(pi*delta^2));

%..........do bluring..............
smoothF = F .* g_blur;          % multiply FT by mask


smooth = ifft2(smoothF);    % do inverse FT

log_F = log(F);
log_smoothF = log(smoothF);


