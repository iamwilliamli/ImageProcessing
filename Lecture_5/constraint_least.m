clear;clc;
f = im2double(checkerboard(8)); % 新建棋盘格
h = fspecial('motion',10);  % 运动模糊器
img = imfilter(f,h);
noise_mean = 0;
noise_var = 0.01;
blurred_noisy = imnoise(img,'gaussian',noise_mean,noise_var);
F = fft2(f);
IMG = fft2(img);
H = (IMG+1)./(F+1);
G = fft2(blurred_noisy);
p = [0 -1 0;-1 4 -1;0 -1 0]; % Laplacian Filter
c = padarray(p,[30,30]);
p = zeros(64,64);
p(1:63,1:63) = c;
P = fft2(p);
gamma = 0.7;
F = (conj(H)./((abs(H)).^2+ gamma*(abs(P)).^2)).*(G);
f = ifft2(F);
subplot(121)
imshow(blurred_noisy)
title('加噪图片')
subplot(122)
imshow(f)
title('constriant least squares filtering')







