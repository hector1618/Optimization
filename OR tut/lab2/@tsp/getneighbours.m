function xlist = getneighbours(problem,x);
% function xlist = getneighbours(problem,x);
% TSP/GETNEIGHBOURS - Get all neighbours to
% the point x in the domain
% of the combinatorial optimization problem.
%

xlist=[];
for ii=2:(problem.n-1),
 for jj=(ii+1):problem.n,
  gra=x;
  slask=gra(jj);
  gra(jj)=gra(ii);
  gra(ii)=slask;
  xlist=[xlist;gra];
 end;
end;
