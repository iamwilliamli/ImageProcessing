a = [pwd,'\cameraman.bmp'];
img = uint8(imread(a));
a = imhist(img);
x = 0:255;
stem(x,a);
xlabel('Pixel Value')
ylabel('Pixel Number')
title('Image Histogram')
new = histeq(img);
imwrite(new, 'regular.jpg');