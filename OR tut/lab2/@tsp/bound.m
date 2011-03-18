function [fl,f,fu]=bound(problem,subset);

cmin=min(min(problem.c));
cmax=max(max(problem.c));
f=0;
fu=0;
fl=0;
x=[subset subset(1)];
for i=1:problem.n;
  if (x(i)>0) & (x(i+1)>0)
   fu=fu+problem.c(x(i),x(i+1));
   f=f+problem.c(x(i),x(i+1));
   fl=fl+problem.c(x(i),x(i+1));
 else
   fu=fu+cmax;
   f=f+0;
   fl=fl+cmin;   
 end;
end;
