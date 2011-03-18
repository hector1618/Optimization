function [u,v]=multipliers(x,c,b)
% [u,v]=multipliers(x,c,b)
% x: current solution  (m*n)
% b: 1 for each basic variables 0 for nonbasic (m*n)
% c: costs (m*n)
% u: lagrange multipliers for rows (m*1)
% v: lagrange multipliers for columns (n*1)
[m,n]=size(x);
if sum(sum(b))< m+n-1
  disp('Error in multipliers')
  return
else
  u=Inf*ones(m,1);
  v=Inf*ones(n,1);
  u(1)=0;   % choose an arbitrary multiplier = 0
  nr=1;
  while nr<m+n  % until all multipliers are assigned
    for row=1:m
      for col=1:n
        if b(row,col)>0
          if (u(row)~=Inf) & (v(col)==Inf)
            v(col)=c(row,col)-u(row);
            nr=nr+1;
          elseif (u(row)==Inf) & (v(col)~=Inf)
            u(row)=c(row,col)-v(col);
            nr=nr+1;
          end
        end
      end
    end
  end
end        
