function [dmin,fumin,res]=fixedwidthsearch(problem,maxwidth,domain);
% [dmin,fumin,res]=fixedwidthsearch(problem,maxwidth,domain);
% 
if nargin<2,
 maxwidth=20;
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

while (size(L,1)>0),
 Ln=[];
 ffn=[];
 ssn=[];
 for kodnr=1:size(L,1);
  kod=L(kodnr,:);
  [noder,ssnya]=branch(problem,kod);
  ffnya=zeros(size(noder,1),3);
  for i=1:size(noder,1);
   kod=noder(i,:);
   [fl,f,fu]=bound(problem,kod);
   ffnya(i,:)=[fl f fu];
  end;
  Ln=[Ln;noder];
  ffn=[ffn;ffnya];
  ssn=[ssn;ssnya];
 end;
 L=Ln;
 ff=ffn;
 ss=ssn;

 [nyfumin,jjj]=min([ff(:,3)]);
 if nyfumin<fumin,
  sprintf('***Nytt fumin %f8.5',nyfumin)
  kodmin=L(jjj,:);
%  eval([skriv,'(kod)']);
  fumin=nyfumin;
 end;

 [nyfumin,jjj]=min([ff(:,3)]);
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

 if size(L,1)>0,
  [fmin,sorti]=sort(ff(:,3)');
  L=L(sorti,:);
  ff=ff(sorti,:);
  ss=ss(sorti,:);
 end;

 steps=steps+1;
% SLÄNG DE SÄMSTA
  if size(L,1)>maxwidth,
   slangde=slangde+sum(ss(51:size(ss,1)));
   L=L(1:maxwidth,:);
   ff=ff(1:maxwidth,:);
   ss=ss(1:maxwidth,:);
  end;
 slangt=slangt+slangde;

 res=[res; steps size(L,1) sum(ss) slangde];
end;

fumin
[fl,f,fu]=bound(problem,kodmin)
dmin=kodmin;
