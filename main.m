%author: Zhengwu Zhang
%email: zhengwustat@gmail.com

%see reference:
%Z. Zhang, E. Klassen, A. Srivastava, P.K. Turaga, R. Chellappa, 
%"Blurring-Invariant Riemannian Metrics for Comparing Signals and Images", 
%ICCV 2011:1770-1775, Barcelona, Spain, 2011

clear all;
close all;

%%%%%% read image  %%%
I1 = imread('test1.png','png');
I2 = imread('test2.png','png');

I1 = rgb2gray(I1); 
I2 = rgb2gray(I2);

%display image;
imagesc(I1); colormap(gray);

%%%% blure the image1 %%%
delta = 1;
[smooth smoothF log_F log_smoothF] = blurimage(I1,delta);
BlurredI1= smooth;
imagesc(BlurredI1); colormap(gray);

%%%%%% compare images %%%%%%
qD1 = ComputeimageDistance_logFT(I1,BlurredI1,6,1);
qD2 = ComputeimageDistance_logFT(I2,BlurredI1,6,1);
qD3 = ComputeimageDistance_logFT(I2,I1,6,1);