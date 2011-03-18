function problem = demoproblem(problem);
% Generates a demonstration problem

n=10;
c=floor(rand(n,n)*9)+1;
c=c/80;

problem = tsp(c);
 
