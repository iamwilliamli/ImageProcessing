function [img] = closing(im_in,dila_type,dila_num,ero_type,ero_num)

SD = strel(dila_type,dila_num);% Dilation
SE = strel(ero_type, ero_num); % Erosion
im_1 = imdilate(im_in,SD);
im_2 = imerode(im_1,SE);
img = im_2;

end