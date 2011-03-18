function [child1,child2] = breed(problem,mother,father);
% function [child1,child2] = breed(problem,mother,father);
% VIGCRYPTO/BREED - Breed the points mother and father
% in the domain of the combinatorial optimization problem
% to obtain two new points child1 and child2
% also in the domain of the optimization problem.
%

pcross=1.0; % Probability of crossing.
pm=0.01;    % Probability of gene mutation
% Genfördelning
 if rand<pcross,
  klipp=floor(rand*(problem.n-1)+1);
  child1=[father(1:klipp) ];
  mm=mother;
  mm(find(ismember(mother,child1)))=[];
  child1=[child1 mm];
  child2=[mother(1:klipp)];
  mm=father;
  mm(find(ismember(father,child2)))=[];
  child2=[child2 mm];
 else
  child1=father;
  child2=mother;
 end;
% Mutationer
 mutation1=rand(1,problem.n)<pm;
 massa=randomindomain(problem);
 if sum(mutation1)>0,
%  child1(find(mutation1))=massa(find(mutation1));
 end;
 mutation2=rand(1,problem.n)<pm;
 if sum(mutation2)>0,
%  child2(find(mutation2))=massa(find(mutation2));
 end;
