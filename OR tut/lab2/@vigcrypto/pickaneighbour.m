function oneneighbour=pickaneighbour(problem,x);
% function pickaneighbour(problem,x);
% VIGCRYPTO/PICKANEIGHBOUR - Picks a random neigbouring solution
% to the solution x of the domain of the optimization prolem.
%


 ii=ceil(rand*problem.keylength);
 gra=(0:(size(problem.alphabet,2)-2));
 nykod=x;
 nykod(ii)=gra(ceil(size(gra,2)*rand));
 oneneighbour = nykod;
