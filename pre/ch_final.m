clear 
clc
%-----------读取显示原图-------------%
A=imread('image.jpeg');
subplot(2,2,1)
imshow(A);
title('原图')
%-------------二值化----------------%
A=im2double(rgb2gray(A));
bw=graythresh(A); 
%图像对应位置做差,自动确定二值化阈值函数
A=imbinarize(A,bw); 
%进行二值化

%---------------去噪----------------%
i1=bwmorph(A,'clean',Inf); 
%去亮点
i1=bwmorph(i1,'fill',1); 
%去亮点后进行填充黑点1次
se=strel('diamond',10);
i1=imerode(i1,se);
%进行腐蚀操作
subplot(2,2,2),imshow(i1);
title('去噪后');

%---------------识别处理-----------%
%提取各种目标的几何特征
[B,L]=bwboundaries (i1,'noholes');%搜索图像的外边界和内边界
subplot(2,2,3);
%imshow(label2rgb(L,@jet,[.5 .5 .5]));
imshow(L);


%--------------计算识别-----------%
hold on;
stats=regionprops(L,'Area','Centroid');
threshold=0.9;
n=0;
for k=1:length(B)
    boundary=B{k};
    delta_sq=diff(boundary).^2
    perimeter=sum(sqrt(sum(delta_sq,2)));
    area=stats(k).Area;
    metric=4*pi*area/perimeter^2;
    %圆度=4π*面积/周长?
    metric_string=sprintf('%2.2f',metric);
    if metric>threshold
        centroid=stats(k).Centroid;
        plot(centroid(1),centroid(2),'ko');
    end
    if metric>0.8
        n=n+1
        text(boundary(1,2)-35,boundary(1,1)+13,metric_string, 'Color','y','FontSize',12, 'FontWeight','bold');
     end
end

for k=1:length(B)
    if metric>threshold&&metric>0.8
    boundary=B{k};
    plot(boundary(:,2),boundary(:,1),'w','LineWidth',2);
    end 
end
title(['圆度metric越接近1，形状越接近圆']);

%---------- 创建文本框，显示结果-------------%
h = dialog('Name','结果显示','position',[700 300 220 140]);  % 创建一个对话框窗口
uicontrol('Style','text','units','pixels','position',[55 50 120 85],'fontsize',13,'parent',h,'string',strcat('圆的个数为',num2str(n),'个 ''黄色数字为搜索出的圆对应圆度')); % 创建文本内容
uicontrol('units','pixels','position',[80 10 50 20],'fontsize',10,'parent',h,'string','确定','callback','delete(gcf)'); % 创建【确定】按钮
