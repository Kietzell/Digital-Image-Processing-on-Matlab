function [A,B,C]=bul(a)

h=fspecial('gaussian', 25, 25);
blurred=imfilter(a, h, 'replicate');
bw=im2bw(blurred,1.27*graythresh(a));            % 0.98
figure, imshow(bw);
hold on;

b=bwboundaries(bw);

k=1;
M=cell(3,1);



for i=2:(numel(b)-1);
    if(160<length(b{i}) && length(b{i})<500)
    plot(b{i}(:,2),b{i}(:,1),'r','LineWidth',3);
    M(k,1)={[b{i}]};
    k=k+1;
    end
end

f1=sum(M{1,1});
f2=sum(M{2,1});
f3=sum(M{3,1});

y1=round((f1(1,1))/length(M{1,1}));
x1=round((f1(1,2))/length(M{1,1}));
y2=round((f2(1,1))/length(M{2,1}));
x2=round((f2(1,2))/length(M{2,1}));
y3=round((f3(1,1))/length(M{3,1}));
x3=round((f3(1,2))/length(M{3,1}));

A=[x1 y1];
B=[x2 y2];
C=[x3 y3];
end
