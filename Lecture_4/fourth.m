clear;clc;
warning off;
a = imread('hindu.bmp');
%a = imread('Miss.bmp');
%img = im2double(a);
img = im2double(rgb2gray(a));
[m,n] = size(img);
img_log= log(img+1);

fourier = (fft2(img_log));

c_1 = round(m/2);
c_2 = round(n/2);

r_h = 1;
r_l = 0.3;
c = 3;
d_0 = 90;

for i=1:m
    for j=1:n
        D(i,j)=((i-c_1).^2+(j-c_2).^2);
        H(i,j)=(r_h-r_l)*(exp(c*(-D(i,j)./(d_0^2))))+r_l;
    end
end

fourier_1 = fourier.*H;
img_2 = (ifft2(fourier_1));
img_3 = (exp(img_2));
imshow(img_3,[])

subplot(2,3,1)
imshow(img)
title('original image')
subplot(2,3,2)
imshow(real(img_3),[])
title('Homomorphic Filtered')
subplot(2,3,3)
imshow(histeq(img))
title('Histeq Original')
subplot(2,3,4)
imshow(histeq(real(img_2)))
title('Histeq Homomorphic Filtered')
subplot(2,3,5)
imshow(img_log)
title('Log')
subplot(2,3,6)
imshow(H)
title('Frequency Filter')
