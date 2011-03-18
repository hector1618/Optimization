function x = randomindomain(s);
% function randomindomain(s);
% VIGCRYPTO/RANDOMINDOMAIN - Generates a random element x in the domain
% of the combinatorial optimization problem
%

x=floor(rand(1,s.keylength)*(size(s.alphabet,2)-1.0000001));
