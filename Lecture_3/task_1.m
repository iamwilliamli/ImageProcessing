% image filtration
% Chengqi Li 1120170852
% Date 3/6/2020
clc;clear;
a = pwd;
b = '/noisy.bmp'
img = rgb2gray(imread([a,b]));
im = uint8(zeros(259));
for i = 2:257
    for j =2:257
        im(i,j) = uint8(img(i-1,j-1));
    end
end

for i = 2:257
    for j = 2:257
        new(i-1,j-1) = median([im(i-1,j-1),im(i-1,j-1),im(i+1,j-1),im(i+2,j-1),im(i-1,j),im(i,j),im(i+1,j),im(i+2,j),im(i-1,j+1),im(i,j+1),im(i+1,j+1),im(i+2,j+1),im(i-1,j+2),im(i,j+2),im(i+1,j+2),im(i+2,j+2)]);
    end
end

imwrite(new,'median.jpg');
subplot(1,2,1)
imshow(img)
title('raw image')
subplot(1,2,2)
imshow(new)
title('median')


% J = medfilt2(img,[4,4]);
% imshow(J)
