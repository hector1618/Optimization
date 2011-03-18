function lokmin=islocalminimum(problem,x);
% lokmin=islocalminimum(problem,x);
% true if x is a local minimum for the problem

[xout,lokmin]=steepdescstep(problem,x);
