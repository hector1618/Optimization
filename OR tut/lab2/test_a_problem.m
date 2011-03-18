echo on
% Choose optimization problem.
path(path,pwd);

problem = demoproblem(tsp);
x = randomindomain(problem);
f = evaluate(problem,x);


% These routines are needed for each combinatorial optimization problem
% demoproblem eller namnet på klassen.
% randomindomain
% getneighbours
% evaluate
% breed
% describe
% pickaneighbour
% branch
% bound
% getdomain

%*************************************************************
% When this is done the following uses are defined:

% Initialize an instance of a problem
%problem = demoproblem(vigcrypto);

% Generate a random point x in the domain
x=randomindomain(problem);

% display the instance of the problem
display(problem)
% or 
problem

% display the solution x to the problem¬
describe(problem,x);

% Breed new solutions.
% Two parents x1 and x2 are used to generate
% two childred x3 and x4
x1=randomindomain(problem);
x2=randomindomain(problem);
[x3,x4]=breed(problem,x1,x2);

% Generate a the set representing the whole domain.
domain=getdomain(problem);

% Branch a set into smaller subsets
[listofsubsets,sizes]=branch(problem,domain)

% Bound a subset
asubset=listofsubsets(1,:);
[fu,f,fl]=bound(problem,asubset)

% Generate a random neigbour
x5=pickaneighbour(problem,x4);


%*****************************************************************
%
% Here comes some examples of simple algorithms
% that uses these routines


% A. One step in local search
%
% Generate random starting point xin.
xin=randomindomain(problem);  
% Generate all neighbours to xin.
neighbours=getneighbours(problem,xin);
lokmin=1;
f=evaluate(problem,xin);
xout=xin;
for ii=1:size(neighbours,1);
 y=neighbours(ii,:);
 fnew=evaluate(problem,y);
 if (fnew < f),
   % If a neighbour has a lower value then
   % we were not at a local minima.
   lokmin=0;
   % Assign xout to this new position
   f=fnew;
   xout=y;
 end;
end;
describe(problem,xout);
xin=xout;

% B. En routine for local search (or steepest descent).
%
xin = randomindomain(problem);
describe(problem,xin);
[xlocmin,steps,locmin]=steepdesc(problem,xin);
describe(problem,xlocmin);

% B. A routine for detecting local minima.
lokmin=islocalminimum(problem,xlocmin)

% C. A routine for branch and bound
%
[dmin,fumin,res]=branchandbound(problem);
fobmin=fumin;
fobkod=dmin;
describe(problem,fobkod);

% D. A routine for fixed width search
[dmin,fumin,res]=fixedwidthsearch(problem);
fobmin=fumin;
fobkod=dmin;
describe(problem,fobkod);

% E. A routine for fixed width search followed by branch and bound
[dmin,fumin,res]=branchandbound2(problem);
fobmin=fumin;
fobkod=dmin;
describe(problem,fobkod);

% F. A routine for simulated annealing
L=30;
t=1:50;
cschema=exp(-t/10)
[xmin,fmin,res]=sim_ann(problem,cschema,L);
describe(problem,xmin);

% G. A genetic algorithm
[xgen,fgen,res]=genetic(problem,40,200); 
describe(problem,xgen);

% H. Tabu search.
% I hope this will be implemented in a near future.

echo off;
