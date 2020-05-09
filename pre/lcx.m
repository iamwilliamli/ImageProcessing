clear all;clc;close all;
RGB = imread('image.jpeg');
subplot(2,3,1);imshow(RGB);title("ԭͼ");
%% ��ֵ��ͼ��
I = rgb2gray(RGB);
bw = imbinarize(I);
subplot(2,3,2);imshow(bw);title("��ֵ����ͼ��");
%% �ṹԪ��ΪԲ�Σ���ͼ�����һ�θ�ʴ���Ͳ���
SE=strel('disk',6);  % ��1�θ�ʴ
bw=imerode(bw,SE); 
subplot(2,3,3);imshow(bw);title('��ʴ��ͼ��')
SE2=strel('disk',6); % ��1������
I4=imdilate(bw,SE2);
subplot(2,3,4);imshow(I4);title('���ͺ�ͼ��')
%% �ҵ��߽�
[B,L] = bwboundaries(I4,'noholes');% ͨ�������ҵ��߽�
subplot(2,3,5);imshow(L);
hold on
%% ����Բ�Ƚ����ж�
stats = regionprops(L,'Area','Centroid');  % �������
% regionprops(Ӣ��get the properties of region)��Matlab����������ͼ���������Եĺ�����
threshold = 0.9;    % ���Կ�����ֵ
% ѭ���ҵ�����ͼ�εı߽�
i=0;
for k = 1:length(B)
  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};
  % ��ñ߽����ص�����õ��ܳ����Լ�����Χ�����
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  area = stats(k).Area;
  yuandu = 4*pi*area/perimeter^2; % Բ�ȵļ���
  yuandu_string = sprintf('%2.2f',yuandu); 
  % ��������ֵ��ͼ���ж�ΪԲ
  if yuandu > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'c*');  % ��Բ���*��
    i=i+1;
  end
  title(["����ע��ΪԲ��,ͼ��Բ�ĸ���Ϊ",num2str(i)]);
end

