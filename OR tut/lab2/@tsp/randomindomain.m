function x = randomindomain(s);
% function x=randomindomain(s);
% TSP/RANDOMINDOMAIN - Generates a random element x in the domain
% of the combinatorial optimization problem s.
%

%Generate a random permutation of 1 to n,
x=1:s.n;
for i=s.n:-1:2;
  j=floor(rand*(i-1))+2;
  slask=x(j);
  x(j)=x(i);
  x(i)=slask;
end;

  
