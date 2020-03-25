clear;clc;
f = im2double(checkerboard(8)); % �½����̸�
h = fspecial('motion',10);  % �˶�ģ����
img = imfilter(f,h);
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(img,'gaussian',noise_mean,noise_var);
wnr1 = deconvwnr(blurred_noisy,h);
title('ά���˲�')
signal_var = var(f(:));
NSR = noise_var / signal_var;
wnr3 = deconvwnr(blurred_noisy,h,NSR); % ��������Ⱥ��˲�
subplot(221)
imshow(img)
title('�˶�ģ��ͼ��')
subplot(222)
imshow(blurred_noisy)
title('�˶�ģ��ͼ��Ӹ�˹����')
subplot(223)
imshow(wnr1)
title('ά���˲�')
subplot(224)
imshow(wnr3)
title('ά���˲�������ȥ��')
imwrite(f,'origin.bmp')
