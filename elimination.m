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
