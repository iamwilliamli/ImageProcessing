function [img] = opening(im_in,ero_type,ero_num,dila_type,dila_num)

SE = strel(ero_type, ero_num); % Erosion
SD = strel(dila_type,dila_num);% Dilation
im_1 = imerode(im_in,SE);
im_2 = imdilate(im_1,SD);
img = im_2;

end