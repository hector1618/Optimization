function [listofsubsets,sizes]=branch(problem,domain)
% function [listofsubsets,sizes]=branch(problem,domain)
% TSP/BRANCH - Branch a subset into a smaller
% pieces (subsets)
%

remainingcities=1:problem.n;
remainingcities(domain(find(domain>0)))=[];
nextplace=find(domain<0);
if size(nextplace,2)>0,
 nextplace=nextplace(1);
 nn=size(remainingcities,2);
 ss=gamma(nn);
 sizes=ss*ones(nn,1);
 listofsubsets=zeros(nn,size(domain,2));
 for ii=1:size(remainingcities,2);
   domain(nextplace)=remainingcities(ii);
   listofsubsets(ii,:)=domain;
 end;
else
  listofsubsets=[];
  sizes=[];
  error('Branch has nothing more to do'); 
end;
