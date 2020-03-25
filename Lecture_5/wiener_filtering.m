clear;clc;
f = im2double(checkerboard(8)); % 新建棋盘格
h = fspecial('motion',10);  % 运动模糊器
img = imfilter(f,h);
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(img,'gaussian',noise_mean,noise_var);
wnr1 = deconvwnr(blurred_noisy,h);
title('维纳滤波')
signal_var = var(f(:));
NSR = noise_var / signal_var;
wnr3 = deconvwnr(blurred_noisy,h,NSR); % 加入信噪比后滤波
subplot(221)
imshow(img)
title('运动模糊图像')
subplot(222)
imshow(blurred_noisy)
title('运动模糊图像加高斯噪声')
subplot(223)
imshow(wnr1)
title('维纳滤波')
subplot(224)
imshow(wnr3)
title('维纳滤波加噪声去除')
imwrite(f,'origin.bmp')
