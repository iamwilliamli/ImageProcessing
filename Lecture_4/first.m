clc; clear;
a = 1/9*[1 1 1;1 1 1;1 1 1];
b = 1/16*[1 2 1;2 4 2;1 2 1];
c = [0 1 0;1 -4 1;0 1 0];
d = [1 1 1;1 -8 1;1 1 1];
e = [0 -1 0;-1 4 -1;0 -1 0];
subplot(1,5,1)
freqz2(a);
subplot(1,5,2)
freqz2(b);
subplot(1,5,3)
freqz2(c);
subplot(1,5,4)
freqz2(d);
subplot(1,5,5)
freqz2(e);
