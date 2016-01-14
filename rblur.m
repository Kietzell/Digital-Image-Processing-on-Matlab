function [M] = rblur(im1)
im2=rgb2gray(im1);
ff=medfilt2(im2, [12 12]);
bw=im2bw(ff, graythresh(im2));
b=bwboundaries(bw);
i=1;
M=cell(length(b),1);
figure, imshow(bw);
hold on;
for k=2:(numel(b));
    plot(b{k}(:,2), b{k}(:,1), 'g', 'LineWidth', 3);
    M(i,1)={abs(length(b{k})/(6.28))};
    i=i+1;
end
