function [B] = sobell(A)
[m,n] = size(A);
k = floor(3/2); 

maske=zeros(1:3,1:3);
maske(1,1)=-1;
maske(1,2)=-2;
maske(1,3)=-1;
maske(2,1)=0;
maske(2,2)=0;
maske(2,3)=0;
maske(3,1)=1;
maske(3,2)=2;
maske(3,3)=1;
maskey=zeros(1:3,1:3);
maskey(1,1)=-1;
maskey(1,2)=0;
maskey(1,3)=1;
maskey(2,1)=-2;
maskey(2,2)=0;
maskey(2,3)=2;
maskey(3,1)=-1;
maskey(3,2)=0;
maskey(3,3)=1;

for i = 1:m-2
  for j = 1:n-2
       
        
        yeni =A(i:i+2*k,j:j+2*k);   
       c=0;
         for f=1:3
            for d=1:3
                 e=yeni(f,d);
                u=maske(f,d);
                sayi=double(double(e)*double(u));
                c=c+sayi;
            end;
        end;
       
	    t=abs(c);
          yeni =A(i:i+2,j:j+2);   
       c=0;
         for f=1:3
            for d=1:3
                e=yeni(f,d);
                u=maskey(f,d);
                sayi=double(double(e)*double(u));
                c=c+sayi;
            end;
        end;
     if (t>abs(c))
	  
         B((i+i+2)/2,(j+j+2)/2)=abs(t);
    else
         B((i+i+2)/2,(j+j+2)/2)=abs(c);
      end
     % s=abs(A((i+i+2)/2,(j+j+2)/2)^2)+(c^2);
      
     %A((i+i+2)/2,(j+j+2)/2)=sqrt(uint8(s));
  end;
end;



B = uint8(B);   
   imshow(B);         

end
