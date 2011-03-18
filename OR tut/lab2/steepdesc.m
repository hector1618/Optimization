function [xout,steps,locmin]=steepdesc(problem,xin);
% function [xout,steps,locmin]=steepdesc(problem,xin);

if nargin < 2,
	xin = randomindomain(problem);
end;

steps=0;
locmin=0;
xout=xin;
while ~locmin,
 [xout,locmin]=steepdescstep(problem,xout);
 steps=steps+1;
% f = evaluate(problem,xout)
end;

