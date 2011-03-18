function domain = getdomain(problem);
% function domain = getdomain(problem);
% TSP/GETDOMAIN - Generates a representation of
% the domain of the problem.
%

domain=[1 -1*ones(1,problem.n-1)];
