function f = describe(problem,x);
% function describe(problem,x);
% VIGCRYPTO/DESCRIBE - Describe the solution x in the domain
% of the combinatorial optimization problem by writing
% information about the problem with this solution.
%

nalfabet = size(problem.alphabet,2);

iklar=viginerekryptera(problem.cryptotext,x,nalfabet);

pos1=1:(size(iklar,2)-2); pos2=pos1+1; pos3=pos2+1;
poang=sum(problem.trigramstat((iklar(pos1)-1)*nalfabet^2+ ...
                  (iklar(pos2)-1)*nalfabet+iklar(pos3)));
poang=-poang/(size(iklar,2)-2);
f = poang/16;

disp(['x (the key): ', problem.alphabet(x+2), ' f: ',num2str(f), ' Decrypted text: ', problem.alphabet(iklar)]);
