clc;clear;
img = imread([pwd,'/Miss.bmp']); %Read Image
noise_hist(1,img,'gaussian');
noise_hist(2,img,'poisson');
noise_hist(3,img,'speckle');
noise_hist(4,img,'salt & pepper');