% Verktygsl�da f�r kombinatorisk optimering
%  samt f�r maximalfl�desalgoritm
%  och f�r transportproblemet
%  speciellt utformad f�r lab 2 i kursen Linj�r och Kombinatorisk Optimering
% Copyright Kalle �str�m, centre for mathematical sciences, 1999-02-11
%         
%
% DEL A - Transportproblemet
%   transportmovie.m  Used in transportmovie
%   cycle.m            "
%   multipliers.m      "
%   northwest.m        "
%   example511.m -
%   example512.m -
%   example513.m -
%
% DEL B - Maximalfl�desalgoritmen
%   maxflow.m         Maximal flow algorithm
%   maxflowdata.m     Used in maxflow
%   rita.m
%
% DEL C - Allm�nt paket f�r demonstration av algoritmer
%         f�r kombinatorisk optimering.
% I paketet �r alla problemen minimeringsproblem.
% dvs vi vill l�sa min_{x \in D} f(x)
% d�r D �r en diskret m�ngd
% Vidare f�ruts�tts f�r den genetiska algoritmen att
% funktionsv�rdena �r positiva och ligger mellan 0 och 1.
%
% Problems and problem classes
%  @vigcrypto - Vigenere Crypto Analysis
%  @tsp - Travelling Salesman Problem
%
% These routines are needed for each combinatorial optimization
% problem. The routines are specific for each problem.
%   'CONSTRUCTOR'  - with the same name as the problem. Generates object.
%   demoproblem    - Generates demo problem.
%   randomindomain - Generate point x in domain
%   getneighbours  - Get list of neighbours to x.
%   evaluate       - Evaluate goal function f at x.
%   breed          - Generate offspring to two points x and y.
%   describe       - Describe the solution x of the problem.
%   pickaneighbour - Get a random neighbour to x.
%   branch         - Branch a set S of points into a listofsubsets.
%   bound          - Bound the optimal value of a subset.
%   getdomain      - Get a description of the domain of the problem.
%
% These routines can be used for combinatorial optimization.
% The routines are general (not specific) for each problem.
% They are based on the problem-specific routines above.
%   steepdesc       - local search
%    steepdescstep  - one step of local search
%   islocalminimum  - unders�k om punkter �r ett lokalt minimum
%   branchandbound  - Branch and bound
%   fixedwidthsearch - Branch and bound with fixed width.
% More Routines will follow in 'Inl�mningsuppgift 4'.
%
% Exemples and testscripts
%  test_a_problem  - exempel p� hur rutinerna kan anv�ndas.
%
