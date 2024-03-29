function [out] = noise_hist(num,ori,char)
figure(num)
img = imnoise(ori,char);
subplot(2,2,1)
imshow(ori)
title('原图')
subplot(222)
imshow(img)
title(['加入',char,'噪声图像'])
subplot(222)
imshow(img)
title(['加入',char,'噪声图像'])
subplot(223)
bar(imhist(ori))
title(['原图直方图'])
subplot(224)
bar(imhist(img))
title(['加入',char,'噪声直方图'])
imwrite(img,[char,'.bmp'])
end

