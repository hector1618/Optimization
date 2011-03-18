function [listofsubsets,sizes]=branch(problem,domain)
% function [listofsubsets,sizes]=branch(problem,domain)
% VIGCRYPTO/BRANCH - Branch a subset into a smaller
% pieces (subsets)
%

period = problem.keylength;
nalfabet = size(problem.alphabet,2);
aendra=find(domain==-1);

if size(aendra,2)==0,
  noder=[];
  storlek=[];
  error('Branch has nothing more to do');
else,
 aendra=aendra(1);
 mojliga=0:nalfabet-2;
 noder=zeros(size(mojliga,2),period);
 storlek=ones(size(mojliga,2),1)*(nalfabet-1)^(sum(domain==-1)-1);
 kk=0;
 for ii=mojliga;
  nod=domain;
  nod(aendra)=ii;
  kk=kk+1;
  noder(kk,:)=nod;
 end;
end;

listofsubsets = noder;
sizes = storlek;
