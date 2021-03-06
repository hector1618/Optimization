function [opt mat] = max_2phase( A,B,C)
% for miximising the given objective function C when the constraints AX <=> B is given.
% Matix A is coefficient matrix. B is right-hand side of all the
% inequality.B should hav all +ve elements.
% C should be a row matrix haivng coeficient corresponding to all the variables
% And we assume that we are working with non-negative no.s
% the method used in this algorithm is 'BIG-M' method
[am,an] = size(A);
[bm,bn] = size(B);
[cm,cn] = size(C);
R = min(min(min(A)),min(C))*10^-5;% this value of R will be used in this algo to check the accuracy
%Bcos we are working with various precision degits at various program,
%anything lesser than R is considered as a zero.

% check for matrix A and B
if am ~= bm || bn~=1
    disp('Pls check the given input.A & B matrices are inconsistent')
    return
end
% check for condition objective matix C
if cm ~= 1
    disp(' Pls check the objective matrix.It should be an row matrix');
    return
end

%check for the given constraint and objective matrix.
if an ~= cn
    disp(' Pls check the objective matrix.Matrices A & C are inconsistent ');
    return
end

%check for the elements in matix B.All of them should be +ve.
e = sign(min(B));
if e == -1
    disp('Pls check matrix B.All elements in it should be non -ve.')
    return
end

% Checking the types of constraits and formation of SIGN(S) matrx
r = menu('Pls select one of the following' , 'All constraints have <= sign',...
                 'All constraints have >= sign' , 'All constraints have = sign',...
                 'The constrarints are in mixed from');
             switch r
                 case 1
                     S = ones(am,1);
                 case 2
                     S = -ones(am,1);
                 case 3
                     S = zeros(am,1);
                 otherwise
                     disp('Pls enter the column matrix corresponding to the signs')
                     S = input('Enter 1 for <= sign , -1 for >= and 0 for = sign \n');
             end

% Check for S matrix
if size(S,1) ~= am
    disp(' Pls check the sign matrix')
    return
end

%forming initial tebula
X = [ ];
X(1,1) = 0;%this cell will correspod to Z
X(2:bm+1,1) = B;

j=an+1;% for inserting artificial variables R
for i = 1:am
    X(i+1,2:an+1) = A(i,:);
    s = S(i,1);
    switch s
        case 1
        X(i+1,j+i) = 1;
        case  -1
        X(i+1,j+i) = -1;
        X(i+1,j+i+1)=1;
        X(1,j+i+1)= -1;
        j = j+1;
        case 0
        X(i+1,j+i)=1;
        X(1,j+i)= -1;
    end
end

% the initial tebula is formed with indication row is
% corresponding to the function min(r) = { R1 + R2 + ..}

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~    PHASE - 1 ~~~~~~~~~~~~~~~~%

%For this optimisation function is min(r ) = { R1 + R2 + ..} 
%i.e to minimise the sum of all the artificial variables

%Removing the inconsistency in representation.
I= find(S<=0);
J= find(X(1,:) == -1);
im= size(I,1);
for k= 1:im
    i = I(k,1);
    j = J(1,k);
    X = elimination(X,i+1,j);
end
% the inconsistancy has been removed.


% We can proceed to get min value of 'r' using normal simplex method
[xm xn] = size(X);
[z_v z_i ] = max(X( 1,2:xn));
while z_v > R% this is the required condition for max
     % finding entering vector
    Min_R = X(2:xm,1)./X(2:xm,z_i+1);%finding min ratio
     % but we are looking for min +ve ratio hence we have to manipulate
     % Min_R
     if max(Min_R) <= 0 || max(Min_R) == inf % this is check for unboundedness
         sprintf('Unbounded solution')
         return
     end
     [m_v m_i] = min_positive(Min_R);%Pls see the function min_positive
     X = elimination(X,m_i+1,z_i+1);%Row reduce operations
     [z_v z_i ] = max(X( 1,2:xn));
end

if abs(X(1,1)) >= R
    disp(' Min value of sum of artificial variable cant be 0 and hence no feasible solution');
    return
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~    PHASE - 2 ~~~~~~~~~~~~~~~~%
%For this optimisation function is the given function i.e z = CX 

jn= size(J,2);  %J matrix is defined above as J= find(-1 == X(1,:));
%Formation of intial tebula for phase 2
for jj = 1:jn
    X(:,J(1,jj)) = [];
end

X(1,2:cn+1) = - C;%indication rowX
% Initial tabula is read but we have to remove inconsistancy in
% presentation
sol = X;
%Removing the inconsistency in representation.
for k = 2:an+1
        % looking for the colume which forms the rrel for matix A
        t = roots( [sol(2:end,k);0] );
        mt = size(t,1);
        if t == zeros(mt,1)
            X = elimination(X, am-mt+1+1 , k);
        end
end

% We can proceed with normal simplex method
[xm xn] = size(X);
[z_v z_i ] = min(X( 1,2:xn));% finding outgoing vector

while z_v < 0% this is the required condition for max
     Min_R = X(2:xm,1)./X(2:xm,z_i+1);%finding min ratio
     % but we are looking for min +ve ratio hence we have to manipulate
    % Min_R
     if sign(min(Min_R)) ~=1 
        if max(Min_R) <= 0 || max(Min_R) == inf % this is check for unboundedness
            sprintf('Unbounded solution / Infeasible solution')
            return
        end
     end
     
     
     [m_v m_i] = min_positive(Min_R);%Pls see the function min_positive
     % finding entering vector
     X = elimination(X,m_i+1,z_i+1);%Row reduce operations
     [z_v z_i ] = min(X( 1,2:xn));
end

%The final final tebula is ready. We have to extract solution from final
%tebula
% Obtaining the solution from Final tebula
opt = X(1,1);
sol = X;
for k = 2:an+1
        % looking for the colume which forms the rrel for matix A
        t = roots( [sol(:,k);0] );
        mt= size(t,1);
        if t == zeros(mt,1)
            mat(k-1,1) = X(am-mt+1+1,1);
        else
            mat(k-1,1) = 0;
        end
end 
%This is a solution for feasibility of solution
if  min(mat) < 0
    disp('No feasible solution')
    return
end
% If solution is feasible than the final result is displayed

disp('Co-efficient matrix correspond to optimum solution ')
mat
disp('and optimum value is')
opt

%There may be some alternate solution exiting.But so far we have not
%checked it.This is a check for alternate solution.
for i = 1:am
    Ratio = A(i,:)./C;
    if Ratio == Ratio(1,1)*ones(1,an);
        disp('The alternate optima exist and hence its not a unique solution')
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% defining sub-fuction elimination
function Y = elimination(Y,i,j)
% Pivoting (i,j) element of matrix X and eliminating other colume
% elements to zero
[ ym yn ] = size(Y);
a = Y(i,j);
Y(i,:) = Y(i,:)/a;
for k =  1:ym
    if k == i
        continue
    end
    Y(k,:) = Y(k,:) - Y(i,:)*Y(k,j);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%defining subfuction min_positive
function [ m_v m_i] = min_positive( Y)
%this function will take a column matrix and returns the samllest
%+ve element's value and its position.
ys = sort(Y);
k = 1;
while ys(k,1) <= 0
          k = k + 1;
end
m_v = ys(k,1);
m_i = find(Y==m_v,1,'first');