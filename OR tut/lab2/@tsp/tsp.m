function problem = tsp(c);
% function problem = tsp(c);
%
%  TSP/CONSTRUCTOR - Constructs a travelling salesman problem.
%  c              - cost matrix Element c(i,j) contains the 
%  cost of travelling from city i to city j.


if nargin == 0,
 problem.c = [];
 problem.n = 0;
 problem = class(problem,'tsp');
elseif isa(c,'tsp');
 problem = c;
else
 n=size(c,2); 
 if (size(c,1)==2) & (size(c,2)~=2);
   for i=1:n;
     for j=1:n;
       cc(i,j)=norm(c(:,i)-c(:,j));
     end;
   end;
   c=cc;
 end;
 problem.c = c;
 problem.n = n;
 problem = class(problem,'tsp');
end;
