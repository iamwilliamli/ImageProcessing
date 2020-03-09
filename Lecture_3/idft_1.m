function [out] = idft_1(img)

im3=im2double(img);
[m,n]=size(im3);
out = double(zeros(m,n));
for u = 1:1:m
    for v = 1:1:n
        sum = double(0);
        for x = 1:m
            for y = 1:n
                sum = sum + 1/(m*n)*im3(x,y)* exp(1i*2*pi*((u-1)*(x-1)/m + (v-1)*(y-1)/n));
            end
        end
        out(u,v) = sum;
    end
    
end

end




