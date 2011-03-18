function [xout,lokmin]=steepdescstep(problem,xin);
% function [xout,lokmin]=steepdescstep(problem,xin);
% One step in local search

% Generate all neighbours to xin.
neighbours=getneighbours(problem,xin);
lokmin=1;
f=evaluate(problem,xin);
xout=xin;
for ii=1:size(neighbours,1);
 y=neighbours(ii,:);
 fnew=evaluate(problem,y);
 ...
 add apropriate code here.
 ...
end;
