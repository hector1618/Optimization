function f = evaluate(problem,x);
% function evaluate(problem,x);
% VIGCRYPTO/EVALUATE - Evaluates a point x in the domain
% of the combinatorial optimization problem.
%

nalfabet = size(problem.alphabet,2);

iklar=viginerekryptera(problem.cryptotext,x,nalfabet);

pos1=1:(size(iklar,2)-2); pos2=pos1+1; pos3=pos2+1;
poang=sum(problem.trigramstat((iklar(pos1)-1)*nalfabet^2+ ...
                  (iklar(pos2)-1)*nalfabet+iklar(pos3)));
poang=-poang/(size(iklar,2)-2);
f = poang/16;
