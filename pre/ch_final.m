clear 
clc
%-----------��ȡ��ʾԭͼ-------------%
A=imread('image.jpeg');
subplot(2,2,1)
imshow(A);
title('ԭͼ')
%-------------��ֵ��----------------%
A=im2double(rgb2gray(A));
bw=graythresh(A); 
%ͼ���Ӧλ������,�Զ�ȷ����ֵ����ֵ����
A=imbinarize(A,bw); 
%���ж�ֵ��

%---------------ȥ��----------------%
i1=bwmorph(A,'clean',Inf); 
%ȥ����
i1=bwmorph(i1,'fill',1); 
%ȥ�����������ڵ�1��
se=strel('diamond',10);
i1=imerode(i1,se);
%���и�ʴ����
subplot(2,2,2),imshow(i1);
title('ȥ���');

%---------------ʶ����-----------%
%��ȡ����Ŀ��ļ�������
[B,L]=bwboundaries (i1,'noholes');%����ͼ�����߽���ڱ߽�
subplot(2,2,3);
%imshow(label2rgb(L,@jet,[.5 .5 .5]));
imshow(L);


%--------------����ʶ��-----------%
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
    %Բ��=4��*���/�ܳ�?
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
title(['Բ��metricԽ�ӽ�1����״Խ�ӽ�Բ']);

%---------- �����ı�����ʾ���-------------%
h = dialog('Name','�����ʾ','position',[700 300 220 140]);  % ����һ���Ի��򴰿�
uicontrol('Style','text','units','pixels','position',[55 50 120 85],'fontsize',13,'parent',h,'string',strcat('Բ�ĸ���Ϊ',num2str(n),'�� ''��ɫ����Ϊ��������Բ��ӦԲ��')); % �����ı�����
uicontrol('units','pixels','position',[80 10 50 20],'fontsize',10,'parent',h,'string','ȷ��','callback','delete(gcf)'); % ������ȷ������ť
