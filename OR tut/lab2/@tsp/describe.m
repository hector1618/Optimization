function f = describe(problem,x);
% function describe(problem,x);
% TSP/DESCRIBE - Describe the solution x in the domain
% of the combinatorial optimization problem by writing
% information about the problem with this solution.
%

f=evaluate(problem,x);

disp(['x (the key): ',  num2str(x), ' f: ', num2str(f)]);
