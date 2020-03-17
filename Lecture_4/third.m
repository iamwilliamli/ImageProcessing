clear;clc;
a = imread('task_3.png');
imwrite(a,'img.bmp');
img = im2double(rgb2gray(imread('img.bmp')));
[m,n] = size(img);

imageSizeX = m;
imageSizeY = n;
[columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
centerX = round(m/2);
centerY = round(n/2);
radius = 50;
circlePixels = imrotate((rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2, 90);
circlePixels = 1 - circlePixels;

img_f = (fft2(img));
mask = double(circlePixels);
img_1 = img_f.*mask;
img_2 = (ifft2(img_1));
subplot(2,3,1)
imshow(circlePixels);
title('frequency filter')
subplot(2,3,2)
imshow(img_2);
title('Filtered image');
subplot(2,3,3)
imshow(histeq(im2uint8(img_2)));
title('Filtered image Histeq');
subplot(2,3,4)
imshow(img);
title('Raw image');
subplot(2,3,5)
imshow(histeq(img));
title('Raw image histeq');
