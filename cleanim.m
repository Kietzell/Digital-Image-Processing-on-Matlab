function [im lbl]=cleanim(resim);
r=rgb2gray(resim);
r2=imadjust(r, [0 1], [1 0]);
r3=medfilt2(r2, [24 24]);
r4=im2bw(r3, graythresh(r3));
g1=im2bw(r2);
im=r4-g1;
lbl=r4;
figure, imshow(im);
figure, imshow(lbl);
end