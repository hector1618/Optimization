function f = evaluate(problem,x);
% function evaluate(problem,x);
% TSP/EVALUATE - Evaluates a point x in the domain
% of the combinatorial optimization problem.
%

f=0;
x=[x x(1)];
for i=1:problem.n;
  f=f+problem.c(x(i),x(i+1));
end;

