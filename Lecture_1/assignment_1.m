% Assignment 1
% Author: Chengqi Li
% Date 2/21/2020
clc;clear;
img = imread("/Users/William/Downloads/first/image.bmp");
[rows, columns] = size(img);
disp(['Rows: ',num2str(rows), ' Columns: ',num2str(columns)]);
disp(['The pixel value at (50,130) is: ',num2str(img(50, 130))]);
a = img(5,100:130); % 
imwrite(img, 'image.jpg');
a = dir("/Users/William/Downloads/first/image.bmp");
b = dir("/Users/William/Downloads/first/image.jpg");
disp(['bmp size: ', num2str(a.bytes),' jpg size: ', num2str(b.bytes)]);


