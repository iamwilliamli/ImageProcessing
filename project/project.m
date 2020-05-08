%% Grayscale to Binary
clc;clear;warning off;
raw = imread('image.jpeg');
figure(12)
imshow(raw)
BW_1 = rgb2gray((imread('image.jpeg')));
BW_2 = imgaussfilt(BW_1,0.5);
BW = im2bw(BW_2,0.5);
imwrite(BW,'bw.bmp');
im_2 = closing(BW,'square',2,'disk',7);
SD = strel('square',8);
im_3 = imdilate(im_2,SD);
BW = edge(im_3,'Canny');

%% Find circle using Hough example
[centers, radii, metric] = imfindcircles(im_3,[15 60]);
% figure(1)
% imshow(BW)
% hold on
% viscircles(centers, radii,'EdgeColor','b');
% radii
% title(strcat('球个数:',num2str(length(centers))))
% hold off

%% Standard Hough transform
% figure(2)
% img_hough(im_3);

%% Algorithm implementation
BW = edge(im_3,'Canny');

[m,n] = size(BW);
vot_mat = zeros(m,n,60); % Create voting matrix

for x=1:m
    for y=1:n
        if BW(x,y) == 1
            for r = 10:60
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

sav_mxv = 140;% Threshold
iter = 1;
a_remain = 0; % Distance Threshold
num = 0;
for i = 17:55
    vot_mat_l = vot_mat(:,:,i);
    [length, width] = size(vot_mat_l); 
    [mxv,idx] = max(vot_mat_l(:));
    if mxv >= sav_mxv
        banjing = i;
        [a,b,r] = ind2sub(size(vot_mat),idx);
        if abs(a-a_remain)>10 && iter ~= 1
            a_remain = a;
            viscircles([b,a], i,'EdgeColor','b');
            num = num + 1;
            hold on;
        end
    end
    iter = iter+1;
end
hold off
title(strcat('Number of circles:',num2str(num)))
%% Algorithm Visualization
% pl = vot_mat(:,:,banjing);
% banjing
% for 
% figure(10);
% mesh(pl);
% view(2)
% h = figure(10)
% saveas(h,'FIG','png');
% pl = vot_mat(:,:,banjing);
banjing
%% export image
% for i = 17:55
%     figure(i);
%     pl = vot_mat(:,:,i);
%     mesh(pl);
%     view(2)
%     h = figure(i)
%     saveas(h,['R = ', num2str(i)],'jpg');
% end
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

