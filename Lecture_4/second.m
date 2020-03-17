clear;clc;
a = [2 2 2;1 2 3;1 1 1];
b = [11 2 3 3 4 1;2 3 3 4 1 5;2 7 12 22 11 11;21 22 11 3 4 5;7 8 6 2 1 2;4 5 3 32 1 21];
c = conv2(a,b);
[m,n] = size(a);
[p,q] = size(b);
a_1 = zeros(m+p-1,n+q-1);
b_1 = zeros(m+p-1,n+q-1);
a_1(4:6,4:6) = a(:,:);
b_1(2:7,2:7) = b(:,:);
a_f = fft2(a_1);
b_f = fft2(b_1);
c_f = a_f.*b_f;
c_2 = ifft2(c_f);
c_2 - c