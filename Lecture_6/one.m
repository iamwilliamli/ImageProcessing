clear; clc;
img = imread('Miss.bmp');
img = im2double(img);
[m,n] = size(img);

for i = 1:m
    for j = 1:n
        im(mod(i-1,8)+1,mod(j-1,8)+1,floor((i-1)/8)+1,floor((j-1)/8)+1) = img(i,j);
    end
end

[k1,k2,o,p] = size(im);

for i = 1:o
    for j = 1:p
        im_dct(:,:,i,j) = dct2(im(:,:,i,j));
        middle = im_dct(:,:,i,j);
        middle_2 = middle(:);
        [~,idx] = maxk(abs(middle_2),16);
        idx = sort(idx);
        middle_2 = middle_2(idx);
        middle_3 = reshape(middle_2 ,[4,4]);
        
        %middle_3 = reshape(middle_2(1:64),[8,8]);
        im_sort_dct2(:,:,i,j)  = middle_3;
        im_sort(:,:,i,j) = idct2(im_sort_dct2(:,:,i,j));
    end
end
img_new = zeros(m/2,n/2); 
for i = 1:m/2
    for j = 1:n/2
        img_new(i,j) = im_sort(mod(i-1,4)+1,mod(j-1,4)+1,floor((i-1)/4)+1,floor((j-1)/4)+1) ;
    end
end
% img_new = zeros(m,n); 
% for i = 1:m
%     for j = 1:n
%         img_new(i,j) = im_sort(mod(i-1,8)+1,mod(j-1,8)+1,floor((i-1)/8)+1,floor((j-1)/8)+1) ;
%     end
% end

imshow(img_new)

% for i=1:10
%       a=rgbBlock;
%       imwrite (a,sprintf('%d.jpg',i));
% end