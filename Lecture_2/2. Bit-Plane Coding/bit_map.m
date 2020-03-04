% 比特面分层 include autofill.m binary_img.m
% author: 李成琦 1120170852


clc;clear;
a = [pwd,'\miss.bmp'];
a = imread(a);
img = a;
[x,y] = size(img);
for i = 1:x
    for j = 1:y
        sta = img(i,j);
        stack = autofill(de2bi(sta));
        one(i,j) = binary_img(stack(8));
        two(i,j) = binary_img(stack(7));
        three(i,j) = binary_img(stack(6));
        four(i,j) = binary_img(stack(5));
        five(i,j) = binary_img(stack(4));
        six(i,j) = binary_img(stack(3));
        seven(i,j) = binary_img(stack(2));
        eight(i,j) = binary_img(stack(1));
    end
end
imwrite(one,'1.jpg')
imwrite(two,'2.jpg')
imwrite(three,'3.jpg')
imwrite(four,'4.jpg')
imwrite(five,'5.jpg')
imwrite(six,'6.jpg')
imwrite(seven,'7.jpg')
imwrite(eight,'8.jpg')

