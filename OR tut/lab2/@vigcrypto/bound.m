function [fl,f,fu]=bound(problem,subset);

nalfabet = size(problem.alphabet,2);
iklar=viginerekryptera(problem.cryptotext,subset,nalfabet);

pos1=1:(size(iklar,2)-2); pos2=pos1+1; pos3=pos2+1;
f=sum(problem.trigramstat((iklar(pos1)-1)*nalfabet^2+ ...
                  (iklar(pos2)-1)*nalfabet+iklar(pos3)));
f=-f/(size(iklar,2)-2);
fl=sum(problem.utrigramstat((iklar(pos1)-1)*nalfabet^2+ ...
                  (iklar(pos2)-1)*nalfabet+iklar(pos3)));
fl=-fl/(size(iklar,2)-2);
fu=sum(problem.ltrigramstat((iklar(pos1)-1)*nalfabet^2+ ...
                  (iklar(pos2)-1)*nalfabet+iklar(pos3)));
fu=-fu/(size(iklar,2)-2);

fl=fl/16;
fu=fu/16;
f=f/16;
