function [x,b]=northwest(s,d)
% [x,b]=northwest(s,d)
% x: shipments using nw-rule (m*n)
% b: 1 for each basic variables 0 for nonbasic (m*n)
% s: supplies (m*1)
% d: demands (n*1)
if (sum(s)~=sum(d)), 
  disp('ERROR: The total supply is not equal to the total demand.');
  return; 
end
m=length(s);
n=length(d);
i=1;
j=1;
x=zeros(m,n);
b=zeros(m,n);
while ((i<=m) & (j<=n))
   if s(i)<d(j)
      x(i,j)=s(i);
      b(i,j)=1;
      d(j)=d(j)-s(i);
      i=i+1;
    else
      x(i,j)=d(j);
      b(i,j)=1;
      s(i)=s(i)-d(j);
      j=j+1;
    end
end
