clc;clear;
raw = imread('image.bmp');
BW_1 = rgb2gray((imread('image.bmp')));
BW = imgaussfilt(BW_1,0.5);
BW = im2bw(BW,0.5);
imwrite(BW,'bw.bmp');
im_2 = opening(BW,'disk',7,'disk',6);
imshow(BW_1)
stats = regionprops('table',im_2,'Centroid','MajorAxisLength','MinorAxisLength')
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
hold on
viscircles(centers,radii);
title(strcat('大球个数:',num2str(length(stats.MajorAxisLength))))
hold off


figure(5)
subplot(2,2,1)
imshow(raw)
title('原图')
subplot(2,2,2)
imshow(BW)
title('二值化处理')
subplot(2,2,3)
imshow(im_2);
title('opening')












% 
% subplot(211)
% imshow(im_2);
% subplot(212)
% imshow(BW)
% % 
% s  = regionprops(BW,'centroid');
% centroids = cat(1, s.Centroid);

% hold on
% plot(centroids(:,1), centroids(:,2), 'b*')
% hold off
