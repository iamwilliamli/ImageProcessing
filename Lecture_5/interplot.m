% author: Chengqi Li
% Date: Mar.26 2020
clc;clear;
A = [0 0 0 0 0; 
    0 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 0;
    0 0 0 0 0];

img = A
F = griddedInterpolant(img);
[sx,sy,sz] = size(img);
xq = (1:1/2:sx)';
yq = (1:1/3:sy)';
vq_linear = F({xq,yq});
imwrite(vq_linear,'linear.jpg')

F.Method = 'cubic';
vq_cubic = F({xq,yq});
imwrite(vq_cubic,'Cubic method.jpg')

F.Method = 'spline';
vq_spline = F({xq,yq});
imwrite(vq_spline,'Spline method.jpg');
c = imresize(A,[11,16],'nearest');

subplot(231);imshow(img);title('原图')
subplot(232);imshow(vq_linear);title('线性')
subplot(233);imshow(vq_cubic);title('cubic插值')
subplot(234);imshow(vq_spline);title('样条插值')
subplot(235);imshow(c);title('nearest')


