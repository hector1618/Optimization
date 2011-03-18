function [child1,child2] = breed(problem,mother,father);
% function [child1,child2] = breed(problem,mother,father);
% VIGCRYPTO/BREED - Breed the points mother and father
% in the domain of the combinatorial optimization problem
% to obtain two new points child1 and child2
% also in the domain of the optimization problem.
%

nalfabet = size(problem.alphabet,2);

pcross=1.0; % Probability of crossing.
pm=0.01;    % Probability of gene mutation
% Genfördelning
 if rand<pcross,
  klipp=floor(rand*(problem.keylength-1)+1);
  child1=[father(1:klipp) mother((klipp+1):problem.keylength)];
  child2=[mother(1:klipp) father((klipp+1):problem.keylength)];
 else
  child1=father;
  child2=mother;
 end;
% Mutationer
 mutation1=rand(1,problem.keylength)<pm;
 massa=randomindomain(problem);
 if sum(mutation1)>0,
  child1(find(mutation1))=massa(find(mutation1));
 end;
 mutation2=rand(1,problem.keylength)<pm;
 if sum(mutation2)>0,
  child2(find(mutation2))=massa(find(mutation2));
 end;
