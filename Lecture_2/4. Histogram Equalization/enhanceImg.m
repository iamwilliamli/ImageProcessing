
clear;clc;
a = [pwd,'\cameraman.bmp'];
img = uint8(imread(a));
img = histeq(img);
imshow(img);
imwrite(img, 'histeq.jpg')
