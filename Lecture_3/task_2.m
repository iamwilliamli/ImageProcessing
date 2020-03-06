% image filtration
% Chengqi Li 1120170852
% Date 3/6/2020
clc;clear;
a = pwd;
b = '/cameramen.bmp'
img = imread([a,b]);
F = [0 1 0;1 -4 1;0 1 0];
im = imfilter(img, F);
imwrite(im,'sharpening.jpg');