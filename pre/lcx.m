clear all;clc;close all;
RGB = imread('image.jpeg');
subplot(2,3,1);imshow(RGB);title("原图");
%% 阈值化图形
I = rgb2gray(RGB);
bw = imbinarize(I);
subplot(2,3,2);imshow(bw);title("二值化后图像");
%% 结构元素为圆形，对图像进行一次腐蚀膨胀操作
SE=strel('disk',6);  % 第1次腐蚀
bw=imerode(bw,SE); 
subplot(2,3,3);imshow(bw);title('腐蚀后图像')
SE2=strel('disk',6); % 第1次膨胀
I4=imdilate(bw,SE2);
subplot(2,3,4);imshow(I4);title('膨胀后图像')
%% 找到边界
[B,L] = bwboundaries(I4,'noholes');% 通过函数找到边界
subplot(2,3,5);imshow(L);
hold on
%% 根据圆度进行判断
stats = regionprops(L,'Area','Centroid');  % 获得质心
% regionprops(英文get the properties of region)是Matlab中用来度量图像区域属性的函数。
threshold = 0.9;    % 调试可行阈值
% 循环找到各个图形的边界
i=0;
for k = 1:length(B)
  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};
  % 获得边界像素点进而得到周长，以及所包围的面积
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  area = stats(k).Area;
  yuandu = 4*pi*area/perimeter^2; % 圆度的计算
  yuandu_string = sprintf('%2.2f',yuandu); 
  % 将大于阈值的图形判定为圆
  if yuandu > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'c*');  % 将圆标出*号
    i=i+1;
  end
  title(["被标注的为圆形,图中圆的个数为",num2str(i)]);
end

