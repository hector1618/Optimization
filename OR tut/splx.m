function [opt mat] =splx(r,A,B,C,S)
[am,an] = size(A);
[bm,bn] = size(B);
[cm,cn] = size(C);
M = 100*max(max(max(A)),max(C));% this value of M will be used in this algo
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
if size(S) ~= [ am,1]
    disp(' Pls check the sign matrix')
    return
end

%forming initial tebula
X = [ ];
X(1,1) = 0;%this cell will correspod to Z
X(2:bm+1,1) = B;
X(1,2:cn+1) = - C;%indication row
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
        switch r 
            case 1
                X(1,j+i+1)= M;
            case -1
                X(1,j+i+1)= -M;
        end
        j = j+1;
        case 0
        X(i+1,j+i)=1;
        switch r 
            case 1
                X(1,j+i)= M;
            case -1
                X(1,j+i)= -M;
        end
        
    end
end

%starting of the big-M method

%Removing the inconsistency in representation.
I= find(S<=0);
 switch r 
            case 1
                J= find(M == X(1,:));
            case -1
                J= find(-M == X(1,:));
        end

[ im in ] = size(I);
for k= 1:im
    i = I(k,1);
    j = J(1,k);
    X = elimination(X,i+1,j);
end
% the inconsistancy has been removed.

% We can proceed with normal simplex method
[xm xn] = size(X);
switch r 
            case 1
                [z_v z_i ] = min(X( 1,2:xn));
            case -1
              [z_v z_i ] = max(X( 1,2:xn));
end

        switch r 
            case 1
                r1=1;
            case -1
              r1=-1;
        end
        

             
             
      