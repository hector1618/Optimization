function [ tot_cost , P] =  northwest_appr(C,S,D)
% This function is initial approimation to transportation problems.
% It returns the total cost (tot_cost) and suitable plan (P) for it.
% The matix C is co-efficient matrix corresponding to cost of
% transportation. 'S' is a column matix which stands for availability from
% that perticular source. 'D' is a row matrix which stands for the demand at perticular station.

 [ cm cn ] = size(C);
 [ sm sn ] = size(S);
 [ dm dn ] = size(D);
 
% check for matrix C and S
if cm ~= sm || sn ~=1
    disp('Pls check the given input.Co-efficient matrix and supply matrix are inconsistent.')
    return
end

% check for matrix C and D
if cn ~= dn || dm ~= 1
    disp('Pls check the given input.Co-efficient matrix and demand matrix are inconsistent.')
    return
end


%check for the elements in matix C, S and B.All of them should be +ve.
X = [ 0 D;S C];
e = sign(min(min(X)));
if e == -1
    disp('Pls check matrices.All elements in it should be +ve')
    return
end
% checking whether the given example is standard transporation problem or
% not. If not we will add dummy supply or dummy demand depending on the
% problem.
d_sum = sum(D);
s_sum = sum(S);

if d_sum > s_sum
    dummy = [(d_sum - s_sum) zeros(1,dn)];
    X = [ X ; dummy]
    keyboard% adding dummy supply i.e adding a row
end

if d_sum < s_sum
    dummy = [( s_sum - d_sum) ; zeros(sm,1)];
    X = [ X dummy];% adding dummy demand i.e adding a column
end
[ xm xn ] = size(X);

maxi = 10*max(max(X));% This value will be used to drop the columns / rows
R = X; % We will perform all the operations on matrix R
R(1,:) = [ ];
R(:,1) = [ ];
[ rm rn ] = size(R);
P = zeros(xm,xn); % This matrix will correspond to the final plan
P(1,:) = X(1,:);
P(:,1) = X(:,1);
[ pm pn ] = size(P);
p = 0;
while p < xm + xn -3
    [ i j ] = find(R == min(min(R)),1,'first');
    i = i +1; j = j +1;
    temp  = min( X(i,1) , X(1,j) );
    X(i,1) = X(i,1) - temp;
    X(1,j) = X(1,j) - temp;
    if X(i,1) == 0
        P(i,j) = temp;
        R(i-1,:) = maxi*ones(1,rn);
        %P(i, j+1:end) = zeros(1,pn-j);
        i = i +1;
        p = p +1;
    else
        P(i,j) = temp;
        %P(i+1:end,j) = zeros(pm-i,1);
        R(:,j-1) = maxi*ones(rm,1);
        j = j +1;
        p = p +1;
    end
    X
    keyboard
end

% The final plan is ready.This is for finding total cost.
tc = P.*X;% element wise multiplication to get the total value of transportation.
tot_cost = sum(sum(tc));% sum function operates on the column or row matrix only. Hence used twice