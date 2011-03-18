function xlist = getneighbours(problem,x);
% function xlist = getneighbours(problem,x);
% VIGCRYPTO/GETNEIGHBOURS - Get all neighbours to
% the point x in the domain
% of the combinatorial optimization problem.
%

nalfabet = size(problem.alphabet,2);

xlist=[];
for ii=1:problem.keylength,
 gra=(0:(nalfabet-2))';
 gra(find(gra==x(ii)))=[];
 someneighbours=ones(size(gra,1),1)*x;
 someneighbours(:,ii)=gra;
 xlist=[xlist;someneighbours];
end;
