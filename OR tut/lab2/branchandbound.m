function [dmin,fumin,res]=branchandbound(problem,maxsteps,domain);
%[dmin,fumin,res]=branchandbound(problem,maxsteps,domain);
% The branch and bound method for the optimization problem problem.
%   dmin is the result of the most promising
%   domain of the branch and bound method.
%   fumin - is the lowest upper bound on the minimum.
%   res   - contains debug information about the run
%           Each step of the algorithm has a row in res.
%           Each row contains step number, the number of nodes,
%           the number of points represented by remaining nodes,
%           the number of points rejected in the last step.
% The methods 
%   getdomain
%   branch
%   bound
%   describe
% from the problem object are needed.

if nargin<2,
 maxsteps=Inf;
end;
if nargin<3,
 domain=getdomain(problem);
end;

 L=domain;

 res=[];
 [fl,f,fu]=bound(problem,L);
 ff=[fl f fu];
 ss=[NaN];

 fumin=fu;
 kodmin=L;
 steps=0;
 slangt=0;

while (steps<maxsteps) & (size(L,1)>0),
 kod=L(1,:);
 [noder,ssnya]=branch(problem,kod);
 ffnya=zeros(size(noder,1),3);
 for i=1:size(noder,1);
  kod=noder(i,:);
  [fl,f,fu]=bound(problem,kod);
  ffnya(i,:)=[fl f fu];
 end;

 L(1,:)=[];
 ff(1,:)=[];
 ss(1,:)=[];

 L=[L;noder];
 ff=[ff; ffnya];
 ss=[ss; ssnya];

 [nyfumin,jjj]=min([ff(:,3)]);
 if nyfumin<fumin,
%  sprintf('***Nytt fumin %f8.5',nyfumin)
  kodmin=L(jjj,:);
%  describe(problem,kod);
  fumin=nyfumin;
 end;
 slangi=find(ff(:,1)>=fumin);
 if size(slangi,1)>0,
%  fumin
%  ff
%  disp(sprintf('Slängde %i',sum(ss(slangi))))
  slangde=sum(ss(slangi));
  L(slangi,:)=[];
  ff(slangi,:)=[];
  ss(slangi,:)=[];
 else
  slangde=0;
 end;
 slangt=slangt+slangde;

 if size(L,1)>0,
  [fmin,sorti]=sort(ff(:,3)');
  L=L(sorti,:);
  ff=ff(sorti,:);
  ss=ss(sorti,:);
 end;

 steps=steps+1;
 if (steps/10)==round(steps/10),
  disp('       steps       width      #xleft  #throwaways')
  disp([steps size(L,1) sum(ss) slangde])
 end;
 res=[res; steps size(L,1) sum(ss) slangde];
end;

fumin
[fl,f,fu]=bound(problem,kodmin)
dmin=kodmin;
