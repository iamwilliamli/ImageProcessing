% Histogram Operation Author: Chengqi Li
% 1120170852
% 04251702
clear;clc;
a = [pwd,'\oldpicture.bmp'];
img = uint8(imread(a)); % load image from current directory
img = rgb2gray(img);
img = im2double(img);
b = imhist(img)
max_num = max(max(img));
min_num = min(min(img));
[width, height] = size(img);
for i = 1:width
    for j = 1:height
        img_new(i,j) = double(1-(1/(max_num - min_num)*((img(i,j) - min_num))));% Convert image into Double format
        img_new_log(i,j) = double(1-(log(img(i,j)+1))); % Logrithm conversion 
    end
end
img_new = im2double(img_new);
a = imhist(img_new);
imwrite(img_new, 'linear_p.jpg');
imwrite(img_new_log, 'log.jpg');
subplot(131),imshow(img);
title('raw')
subplot(132),imshow(img_new)
title('linear')
subplot(133),imshow(img_new_log)
title('log')
