function [out] = dft(img)

im3=im2double(img);
[n,m]=size(im3);
c1=0;
k=1;l=1;
for l=0:1:m-1
    for k=0:1:n-1
        for x=0:1:n-1
            for y=0:1:m-1
                a=x+1;b=y+1;
                c= im3(a,b) * exp(-1i*2*pi*(k*x/n + l*y/m));
                c1=c1+c;
            end
        end
        aa=l+1;bb=k+1;
        im(bb,aa)=c1;
        c1=0;
    end
    waitbar(l / m);
end
out = uint8(im);

end

