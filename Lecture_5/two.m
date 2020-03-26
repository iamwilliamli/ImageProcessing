clear;clc;
f = checkerboard(8);
h = fspecial('motion',10); 
img = imfilter(f,h);
figure(1)
imshow(img); % 显示motion blur 图像
img_2 = imnoise(img,'gaussian');
% figure(2)
% imshow(img_2)
img_blur = im2double(img_2); %转换为double类型与mask做乘积
%% Parameters
k = 0.00025
M = 20;
N = 20;

%% Mask Inverse Filtering
[m,n] = size(img_blur);
for i=1:m
    for j=1:n
        H(i,j) = double(1*exp(-k*((i-M/2)^2+(j-N/2)^2)^(5/6)));
    end
end
H = fftshift(H);
fourier = fft2(img_blur);
change = fourier./H;
img_3 = (ifft2(change));
figure(2)
subplot(121)
imshow(img_2)
title('加入噪声图像')
subplot(122)
imshow(img_3)
title('Inverse filtering image')

%%

