clc;clear;
a = pwd;
b = '/cameramen.bmp'
img = imread([a,b]);

tic
b = fft2(img);
toc

tic
a = dft_1(img);
toc

figure(1)
imshow(b);
figure(2)
imshow(a);
%'Result shows: Elapsed time is 0.001082 seconds', 'Elapsed time is 680.035744 seconds.'
% This partly result from the large amount of calculation, and also could
% be result from the programming language as fft is written in C.