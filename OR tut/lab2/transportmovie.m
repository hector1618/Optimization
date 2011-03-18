function [x,cost]=transportmovie(s,d,c);
% function [x,cost]=transportmovie(s,d,c)
%
% s = supplies         (m*1)
% d = demands          (n*1)
% c = costs            (m*n)
% x = optimal solution (m*n)
% cost = minimal transport cost

cost=[];
% Introduce b as a matrix with ones for the basic variables
% and zeros for the non basic variables.
%clc
disp(' The northwest rule gives an initial basic solution.');
disp(' Transport tableau [x s;d'' 0]')
[x,b]=northwest(s,d);
%[x s;d' 0]
disp(' ')
pause
disp([' Transport cost = ',num2str(sum(sum(c.*x)))]);
disp(' ')
while 1
  [u,v]=multipliers(x,c,b);
  disp(' Tableau of costs [c u;v'' 0]');
  %[c u;v' 0]
  [c u]
  [v' 0]
  
  pause
  disp(' ')
  disp(' Reduced costs')
  r=c-u*ones(size(v'))-ones(size(u))*v'
  if any(any(r<0))
    disp(' ')
    disp(' Choose row and column to enter the basis.')
    i=input('row = ');
    j=input('column = ');
  else
    break
  end;
%  clc
  disp(' Transport tableau [x s;d'' 0]');
  [x,b]=cycle(x,i,j,b);
  [x s]
  
  
  
  %[x s;d' 0]
  disp(' ')
  pause
  cost=[cost ; sum(sum(c.*x))];
  fprintf('Transport cost = %g\n\n',cost(length(cost)));
end
disp(' ')
pause
fprintf('Transport costs for all iterations:\n');
cost
