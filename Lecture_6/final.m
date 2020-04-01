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
        low(:,:,i,j) = im_dct(1:2:8,1:2:8,i,j);
        middle = im_dct(:,:,i,j);
        middle_2 = middle(:);
        next_1 = middle_2;
        [~,idx] = maxk(abs(middle_2),16);
        [new,idx_1] = sort(abs(next_1),'descend');
        idx = sort(idx);
        middle_2 = middle_2(idx);
        middle = middle.*[abs(middle)>=new(16)];     
        next_1 = reshape(next_1,[8,8]);
        middle_3 = reshape(middle_2 ,[4,4]);
        im_sort_dct2(:,:,i,j)  = middle_3;
        im_sort(:,:,i,j) = idct2(im_sort_dct2(:,:,i,j));
        low_r(:,:,i,j) = idct2(low(:,:,i,j));
        low_freq(:,:,i,j) = idct2(middle);
    end
end

img_new = zeros(m/2,n/2); 
img_low = zeros(m/2,n/2); 
for i = 1:m/2
    for j = 1:n/2
        img_new(i,j) = im_sort(mod(i-1,4)+1,mod(j-1,4)+1,floor((i-1)/4)+1,floor((j-1)/4)+1) ;
        img_low(i,j) = low_r(mod(i-1,4)+1,mod(j-1,4)+1,floor((i-1)/4)+1,floor((j-1)/4)+1) ;
    end
end

img_freq = zeros(m,n); 
for i = 1:m
    for j = 1:n
        img_freq(i,j) = low_freq(mod(i-1,8)+1,mod(j-1,8)+1,floor((i-1)/8)+1,floor((j-1)/8)+1) ;
    end
end

subplot(221)
imshow(img)
title('原图')
subplot(222)
imshow(img_new)
title('压缩图 128*128')
imwrite(img_new,'new.bmp')
subplot(223)
imshow(img_low)
title('dct降采样 128*128')
subplot(224)
imshow(img_freq)
title('压缩结果，保留最大的16个数')
imwrite(img_freq,'final.bmp');
