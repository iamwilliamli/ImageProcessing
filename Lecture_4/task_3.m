clear;clc;
a = imread('task_3.png');
imwrite(a,'img.bmp');
img = im2double(rgb2gray(imread('img.bmp')));
[m,n] = size(img);


fourier = (fft2(img));
c_1 = round(m/2);
c_2 = round(n/2);

d_0 = 200;

for i=1:m
    for j=1:n
        D(i,j)=((i-c_1).^2+(j-c_2).^2);
        H(i,j)=(exp((-D(i,j)./(2*d_0^2))));
    end
end

fourier_1 = fourier.*H;
img_2 = real(ifft2(fourier_1));
min1=min(min(img_2));
max1=max(max(img_2));
img_2 = uint8((img_2-min1).*50)./(max1-min1);
img_4 = im2uint8(img);
img_3 = img_2 + img_4;
subplot(141)
imshow(img_3)
subplot(142)
imshow(H)
subplot(143)
imshow(img,[])
subplot(144)
imshow(real(img_2),[])

imwrite(img_3,'change.png')
