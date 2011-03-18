function [io im] = bb(type,A,B,C,S)
bnb(type,A,B,C,S);
[io ind]=max(O);

im=M(:,ind);

io
im

end

global I=1;
global O=[];
global M=[];
global zmax = -10000000;
global zmin = 10000000;
function bnb(type,A,B,C,S)% 1 for max, -1 for min
fprintf('Table number :%.0f',I)
[o m] = simplex(type,A,B,C,S)


if sign(o) == -1 || min(m) < 0 
            
             I=I+1;
            return
end
  
 index = find ( ceil(m)~=m);
    if length(index)==0
        I=I+1;
        O(1,I) = o;                                                   % global storage  
        M(1:length(m) :I) = m(1:length(m)) ;        % global storage
        return
    end

        
 
       
        
           
    switch type
        case 1
            
            if o<zmax
                fprintf('%.0f is not better than %.0f',o,zmax)
                I=I+1;
                return
            end
        case -1
            
            if o>zmin
                fprintf('%.0f is not better than %.0f',o,zmin)
                I=I+1;
                return
            end
    end
    
    
A1(1,size(A,2))=0;
A1(1,index(1,1))=1;
A=[A;A1];

B=[B;ceil(m(index(1,1)))];
S=[S;-1];

bnb(type,A,B,C,S);
B(length(B),:)=[];
S(length(S),:)=[];
B=[B;floor(m(index(1,1)))];
S=[S;1];
bnb(type,A,B,C,S);

I=I+1;   
end

