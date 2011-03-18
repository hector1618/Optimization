
function [io im] = bb(type,A,B,C,S)
global I
I =0;
global O
O=[];
global M;
M=[];
global zmax ;
zmax = -10000000;
global zmin;
zmin = 10000000;
bnb(type,A,B,C,S,I,O,M,zmax,zmin)
[io ind]=max(O);

im=M(:,ind);

io
im

end


function bnb(type,A,B,C,S,I,O,M,zmax,zmin)% 1 for max, -1 for min

I=I+1;
I
O
M
zmax
zmin
keyboard 
fprintf('Table number :%.0f',I)
keyboard
type
A
B
C
S
[opt mat] = simplex(type,A,B,C,S);
keyboard
o=opt;
m=mat;

if sign(o) == -1 || min(m) < 0 
            disp('sign is -1 or m is less than 0')
            keyboard             
            return
end
  
 index = find ( ceil(m)~=m)
 keyboard
    if length(index)==0
        disp('length of index is 0')
        O(1,I) = o                                                   % global storage  
        M(1:length(m) :I) = m(1:length(m))         % global storage
        keyboard
        return
    end

        
 
       
        
           
    switch type
        case 1
            
            if o<zmax
                fprintf('%.0f is not better than %.0f',o,zmax)
                keyboard
                return
            end
        case -1
            
            if o>zmin
                fprintf('%.0f is not better than %.0f',o,zmin)
                keyboard
                return
            end
    end
    
      index(1,1)
A1(1,size(A,2))=0;
A1(1,index(1,1))=1;
A=[A;A1]

B=[B;ceil(m(index(1,1)))]
S=[S;-1] 
disp('goinginto bnb')
keyboard
bnb(type,A,B,C,S,I,O,M,zmax,zmin);
   
B(length(B),:)=[];
S(length(S),:)=[];
B=[B;floor(m(index(1,1)))]
S=[S;1]
disp('goinginto bnb')
keyboard
bnb(type,A,B,C,S,I,O,M,zmax,zmin);


end

