function problem = vigcrypto(cryptotext,alphabet,ltri,tri,utri,keylength,correctkey);
% function problem = vigcrypto(cryptotext,alphabet,trigramstat,keylength,correctkey);
%
%  VIGCRYPTO/CONSTRUCTOR
%   cryptotext   -
%   alphabet     -
%   ltrigramstat -
%   trigramstat  -
%   utrigramstat -
%   keylength    -

if nargin == 0,
 problem.cryptotext = [];
 problem.alphabet = [];
 problem.ltrigramstat = [];
 problem.trigramstat  = [];
 problem.utrigramstat = [];
 problem.keylength = NaN;
 problem.correctkey = NaN;
 problem = class(problem,'vigcrypto');
elseif isa(cryptotext,'vigcrypto');
 problem = cryptotext;
else
 problem.cryptotext = cryptotext;
 problem.alphabet = alphabet;
 problem.ltrigramstat = ltri;
 problem.trigramstat  = tri;
 problem.utrigramstat = utri;
 problem.keylength = keylength;
 if nargin==7, problem.correctkey = correctkey; else problem.correctkey = NaN; end;
 problem = class(problem,'vigcrypto');
end;
