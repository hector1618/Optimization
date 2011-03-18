function oneneighbour=pickaneighbour(problem,x);
% function pickaneighbour(problem,x);
% TSP/PICKANEIGHBOUR - Picks a random neigbouring solution
% to the solution x of the domain of the optimization prolem.
%


 i=ceil(rand*problem.n);
 j=ceil(rand*problem.n);
 gra=x;
 slask=gra(j);
 gra(j)=gra(i);
 gra(i)=slask;
 oneneighbour = gra;
