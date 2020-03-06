% Fourier Transform
% Chengqi Li 1120170852
% Date 3/6/2020
clc;clear;warning off;
img = zeros(200,200);
for i = 70:130
    for j = 95:105
        img(i,j)=1;
    end
end
%imshow(img)
out = fftshift(fft(img));
figure(1)
imshow(out);
title('raw')
img_2 = zeros(200,200);
for i = 100:160
    for j = 95:105
        img_2(i,j)=1;
    end
end
%imshow(img)
out_2 = fftshift(fft(img_2));
figure(2)
imshow(out_2);
title('shift')
img_3 = imrotate(img,45);
out_3 = fftshift(fft(img_3));
figure(3)
imshow(out_3);
title('rotation')
