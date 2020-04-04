clear;clc;
t = (-1:0.01:1)';
unitstep = t>=0;
ramp = t.*unitstep;
ramp = ramp(ramp>0);
ramp_img = repmat(ramp,[1,100]);
imshow(ramp_img);
H = [-1 -1 -1;2 2 2;-1 -1 -1];
res = imfilter(ramp_img, H);
imshow(res*100000000000000000) 