function qD = ComputeimageDistance_logFT(I1,I2,b,e)
%input: I1,I2 input images
%       b parameter of the metric
%       e choice of the metric
%output:
% qD:   blurring-invariant distance between orbits


ccx = size(I1,1);
ccy = size(I1,2);

ccx2 = size(I2,1);
ccy2 = size(I2,2);

%check if two images have the same size;
if(ccx ~= ccx2 || ccy ~= ccy2)
    %end the function if they have different dims;
    display('Images size are not the same.');
    return;
end;

%Check the image dimension. Need to be even.
if (mod(ccx,2))
    ccx =ccx-1;
end;
if (mod(ccy,2))
    ccy =ccy-1;
end;

I1 = double(I1(1:1:ccx, 1:1:ccy));
I2 = double(I2(1:1:ccx, 1:1:ccy));


%Fourier transform
F1 = fft2(I1);
F2 = fft2(I2);

% preprocess and prevent log(F)= Inf;
F1(F1==0) = 0.01;
F2(F2==0) = 0.01;

% Log transfrom
log_F1 = log(abs(F1));
log_F2 = log(abs(F2));



nx = size(F1, 2);
ny = size(F2, 1);
cxrange = [0:nx/2, -nx/2+1:-1];        % cycles across the image
cyrange = [0:ny/2, -ny/2+1:-1];
[cx, cy] = meshgrid(cxrange, cyrange);
fxrange = cxrange * 2*pi/nx;           % radians per pixel
fyrange = cyrange * 2*pi/ny;
[fx, fy] = meshgrid(fxrange, fyrange);


Q1 = ComputeImageQDirect(fx,fy,log_F1,b,e);
Q2 = ComputeImageQDirect(fx,fy,log_F2,b,e);
Q0 = ComputeImageQDirect(fx,fy,-pi*(fx.^2+fy.^2),b,e);

[tmp,id] = min([Q1,Q2]);
[tmpm,idm] = max([Q1,Q2]);
c = max(Q1,Q2);
d0 = (c-tmp)/Q0;

%blur the one with small Q to match the blurring level;
sigma = d0;
g_blur = exp(-(fx.^2 + fy.^2)*(pi*sigma));
str = sprintf('smoothF = F%d .* g_blur;',id);
eval(str); 

% calculate their difference
str=sprintf('d_real = log(abs((smoothF))) - log(abs((F%d)));',idm);
eval(str)
qD = InnProdPolyImage(fx,fy,d_real,d_real,b,e);
