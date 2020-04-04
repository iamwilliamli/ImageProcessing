clc;clear;
raw = imread('image.bmp');
BW_1 = rgb2gray((imread('image.bmp')));
BW_2 = imgaussfilt(BW_1,0.5);
BW = im2bw(BW_2,0.5);
imwrite(BW,'bw.bmp');
im_2 = closing(BW,'square',2,'disk',8);
SD = strel('disk',5)
im_3 = imdilate(im_2,SD);
imshow(raw)
stats = regionprops('table',im_3,'Centroid','MajorAxisLength','MinorAxisLength');
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
hold on
viscircles(centers,radii);
title(strcat('大球个数:',num2str(length(stats.MajorAxisLength))))
hold off

figure(5)
subplot(2,2,1)
imshow(BW_2)
title('高斯模糊')
subplot(2,2,2)
imshow(BW)
title('二值化处理')
subplot(2,2,3)
imshow(im_2);
title('closing')
subplot(2,2,4)
imshow(im_3);
title('扩展')



