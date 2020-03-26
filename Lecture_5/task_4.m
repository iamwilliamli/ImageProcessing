clc;clear;
img = imread(['img.jpg']); %Read Image
img = im2double(rgb2gray(img));

[cA,cH,cV,cD] = dwt2(img,'Haar');
subplot(221)
imshow(cA)
subplot(222)
imshow(cH,[])
title('ºá')
subplot(223)
imshow(cV,[])
title('×Ý')
subplot(224)
imshow(cD,[])
title('¶Ô½Ç')