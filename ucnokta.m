function [T,L,S]=ucnokta(a,b,c)
x1=a(1,1);
y1=a(1,2);
x2=b(1,1);
y2=b(1,2);
x3=c(1,1);
y3=c(1,2);

m1=(y2-y1)/(x2-x1);
m2=(y3-y1)/(x3-x1);
m3=(y3-y2)/(x3-x2);

d1=sqrt(((x2-x1)^2)+((y2-y1)^2));
d2=sqrt(((x2-x3)^2)+((y2-y3)^2));
d3=sqrt(((x3-x1)^2)+((y3-y1)^2));

r1=(m1-m2)/(1+(m1*m2));
r2=(m1-m3)/(1+(m1*m3));
r3=(m2-m3)/(1+(m2*m3));

a1=abs(atan(r1)*(180/3.14));
a2=abs(atan(r2)*(180/3.14));
a3=abs(atan(r3)*(180/3.14));

T=[a1 a2 a3]'
L=[d1 d2 d3]'
S=round(0.5*abs(((x1*y2)+(x2*y3)+(x3*y1))-((x2*y1)+(x3*y2)+(x1*y3))))
end


