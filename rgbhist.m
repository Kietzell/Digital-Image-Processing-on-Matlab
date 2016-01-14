function rgbhist(image)
r1=image(:,:,1);
r2=image(:,:,2);
r3=image(:,:,3);
figure, imhist(r1);
figure, imhist(r2);
figure, imhist(r3);
end
