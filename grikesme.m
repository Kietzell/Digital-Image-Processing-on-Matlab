function [BW]=grikesme(im);
level=graythresh(im);
BW=im2bw(I,level);
end