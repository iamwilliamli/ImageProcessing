% Assignment 2
% Author: Chengqi Li
% Date 2/21/2020
clc;clear;
a = pwd;
b = '/Fig0219(rose1024).bmp'
a = strcat(a,b);
img = imread(a);
img_us = img(1:2:1024,1:2:1024,:);
imwrite(img_us,'under_sampling.bmp');
for i = 1:512
    img_copy_1(2*i-1,:,:) = img_us(i,:,:);
    img_copy_1(2*i,:,:) = img_us(i,:,:);
end

for i = 1:512
    img_copy(:,2*i-1,:) = img_copy_1(:,i,:);
    img_copy(:,2*i,:) = img_copy_1(:,i,:);
end

imwrite(img_copy,'img_cp.bmp');