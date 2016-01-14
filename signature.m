function [dist,angle] = signature(b,x0,y0)
%check dimensions of b
[np, nc]=size(b);
if (np<nc || nc~=2)
    error('b must be of size np-by-2.');
end
if isequal(b(1,:),b(np,:));
    b=b(1:np-1,:);
    np=np-1;
end

if nargin==1
    x0=sum(b(:,1))/np;
    y0=sum(b(:,2))/np;
end

IN=inpolygon(x0,y0,b(:,1),b(:,2));
if ~ IN
    error('(x0,y0) or centroid is not inside the boundary');
end

b(:,1)=b(:,1)-x0;
b(:,2)=b(:,2)-y0;

xcart=b(:,2);
ycart=-b(:,1);
[theta, rho]=cart2pol(xcart, ycart);
theta=theta.*(180/pi);
j=theta==0;
theta=theta.*(0.5*abs(1+sign(theta)))...
    -0.5*(-1+sign(theta)).*(360+theta);
theta(j)=0;
theta=round(theta);
tr=[theta,rho];
[w,u]=unique(tr(:,1));
tr=tr(u,:);

if tr(end,1)==tr(1)+360
    tr=tr(1:end-1,:);
end
angle=tr(:,1);
dist=tr(:,2);


end

