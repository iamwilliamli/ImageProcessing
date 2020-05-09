%% Grayscale to Binary
clc;clear;warning off;
img = 'image.jpeg';
raw = imread(img);
figure(12)
imshow(raw)
%% Image dilation
BW_1 = rgb2gray((imread(img)));
BW_2 = imgaussfilt(BW_1,0.5);
BW = im2bw(BW_2,0.5);
imwrite(BW,'bw.bmp');
im_2 = closing(BW,'square',2,'disk',7);
SD = strel('square',8);
im_3 = imdilate(im_2,SD);
%% Canny find edge
BW = edge(im_3,'Canny');

%% Find circle using existing Hough circle finding function
%[centers, radii, metric] = imfindcircles(im_3,[15 60]);
% figure(1)
% imshow(BW)
% hold on
% viscircles(centers, radii,'EdgeColor','b');
% radii
% title(strcat('Çò¸öÊý:',num2str(length(centers))))
% hold off

%% Standard Hough transform for lines
% figure(2)
% img_hough(im_3);

%% Hough Circle Algorithm implementation

[m,n] = size(BW);
vot_mat = zeros(m,n,60); % Create voting matrix

for x=1:m
    for y=1:n
        if BW(x,y) == 1
            for r = 10:60
                for theta = 0:360
                    % finding local maximum
                    a = round(x - r*cos(theta*pi/180));
                    b = round(y - r*sin(theta*pi/180));
                    if a>0 && b> 0 && a<m && b<n % Restrict boundary of voting matrix
                        vot_mat(a,b,r) = vot_mat(a,b,r) + 1;
                    end
                end
            end
        end
    end
end
figure(2)
imshow(im_3)
hold on;

sav_mxv = 140;% Maximum value threshold
iter = 1;
a_remain = 0; % Distance Threshold
num = 0;
for i = 10:55
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
% figure(10);
% mesh(pl);
% view(2)
% h = figure(10)
% saveas(h,'FIG','png');
% pl = vot_mat(:,:,banjing);
% banjing
%% export image
for i = 13:55
   h = figure(3);
   pl = vot_mat(:,:,i);
   mesh(pl);
   title(['R = ', num2str(i)])
   set(gca,'XColor', 'none','YColor','none')
   grid off
   view(2)
   saveas(h,['R = ', num2str(i)],'jpg');
end
system('python save_gif.py'); % Convert images to gif
%% Functions
function [img] = img_hough(raw)
%   Input: GrayScale Image
%   Output: Standard Hough Transformation
[H,T,R] = hough(raw,'RhoResolution',0.5,'Theta',-90:0.5:89);
img = (imadjust(rescale(H)));
imshow(img,'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of image');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);
end
