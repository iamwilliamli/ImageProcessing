%% Grayscale to Binary
clc;clear;warning off;
raw = imread('image.jpg');
BW_1 = rgb2gray((imread('image.jpg')));
BW_2 = imgaussfilt(BW_1,0.5);
BW = im2bw(BW_2,0.5);
imwrite(BW,'bw.bmp');
im_2 = closing(BW,'square',2,'disk',7);
SD = strel('square',8);
im_3 = imdilate(im_2,SD);

%% Find circle using Hough example
[centers, radii, metric] = imfindcircles(im_3,[15 60]);
figure(1)
imshow(im_3)
hold on
viscircles(centers, radii,'EdgeColor','b');
title(strcat('球个数:',num2str(length(centers))))
hold off

%% Hough transform
%figure(2)
%img_hough(im_3);

%% Algorithm implementation
BW = edge(im_3,'Canny');
[m,n] = size(BW);
vot_mat = zeros(m,n,60); % Create voting matrix

for x=1:m
    for y=1:n
        if BW(x,y) == 1
            for r = 30:60
                for theta = 0:360
                    a = round(x - r*cos(theta*pi/180));
                    b = round(y - r*sin(theta*pi/180));
                    vot_mat(a,b,r) = vot_mat(a,b,r) + 1;
                end
            end
        end
    end
end
figure(2)
imshow(BW)
hold on;
for i = 10:60 
    vot_mat_l = vot_mat(:,:,i);
    [mxv,idx] = max(vot_mat_l(:));
    [a,b,r] = ind2sub(size(vot_mat_l),idx)
    viscircles([a,b], i,'EdgeColor','b');
    hold on;
end
hold off


%% Functions
function [img] = img_hough(raw)
%   输入灰度图
%   输出Hough变换图
[H,T,R] = hough(raw,'RhoResolution',0.5,'Theta',-90:0.5:89);
img = (imadjust(rescale(H)));
imshow(img,'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of image');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);
end

