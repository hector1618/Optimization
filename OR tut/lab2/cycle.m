function [y,bout]=cycle(x,row,col,b)
% [y,bout]=cycle(x,row,col)
% x: current solution (m*n)
% b: entering basic variables (m*n)
% row,col: index for element entering basis
% y: solution after cycle of change (m*n)
% bout: new basic variables after cycle of change (m*n)
bout=b;
y=x;
[m,n]=size(x);
loop=[row col]; % describes the cycle of change
x(row,col)=Inf; % do not include (row,col) in the search
b(row,col)=Inf;
rowsearch=1;    % start searching in the same row
while (loop(1,1)~=row | loop(1,2)~=col | length(loop)==2),
  if rowsearch, % search in row
    j=1;
    while rowsearch 
       if (b(loop(1,1),j)~=0) & (j~=loop(1,2))  
         loop=[loop(1,1) j ;loop]; % add indices of found element to loop
         rowsearch=0;  % start searching in columns
       elseif j==n,    % no interesting element in this row
         b(loop(1,1),loop(1,2))=0;
         loop=loop(2:length(loop),:); % backtrack
         rowsearch=0;
       else
         j=j+1; 
       end
    end
  else  % column search
    i=1;
    while ~rowsearch
       if (b(i,loop(1,2))~=0) & (i~=loop(1,1)) 
         loop=[i loop(1,2) ; loop];
         rowsearch=1;
       elseif i==m
         b(loop(1,1),loop(1,2))=0;
         loop=loop(2:length(loop),:);
         rowsearch=1;
       else
         i=i+1;
       end
     end
  end
end
% compute maximal loop shipment
l=length(loop);
theta=Inf;
minindex=Inf;
for i=2:2:l
 if x(loop(i,1),loop(i,2))<theta,
  theta=x(loop(i,1),loop(i,2));
  minindex=i;
 end;
end
% compute new transport matrix
y(row,col)=theta;
for i=2:l-1
  y(loop(i,1),loop(i,2))=y(loop(i,1),loop(i,2))+(-1)^(i-1)*theta;
end
bout(row,col)=1;
bout(loop(minindex,1),loop(minindex,2))=0;
