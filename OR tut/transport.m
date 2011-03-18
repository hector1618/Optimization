function transport(r,S,D,C)     %%% transport(r,S,D,C)
                                                %%%r=1 for northwest corner method
                                                

%%%   Error checking starts
if size(S,1)~=size(C,1) || size(D,2)~=size(C,2) || size(S,2)~=1 || size(D,1)~=1 || length(find(S<=0))~=0 || length(find(D<=0))~=0
    
    if size(S,1)~=size(C,1)
            disp('Size of C and S do not match')
    end
    if size(D,2)~=size(C,2)
            disp('Size of C and D do not match')
    end
    if size(S,2)~=1
            disp('S should be a column matrix')
    end
    if size(D,1)~=1
            disp('D should be a row matrix')
    end
    if length(find(S<=0))~=0
        disp('Supply values have to be positive')
    end
    if length(find(D<=0))~=0
        disp('Demand values have to be positive')
    end
    return
end

%%% Error checking ends. Start building XX, the matrix which holds all the
%%% data. Layer 1 holds the supply, demand and the costs. Layer 2 holds the
%%% current solution and the u-v multipliers. Layer 3 holds the NER values.
%%% Layer 4 holds the description of the basic variables.
       

[cm cn ] = size(C);            %%% Get the dimensions of the system.
XX(1,1,1) = 0 ;                  %%% Layer 1 being original problem.Initializing Layer 1....

XX(2:cm+1,1,1)=S(1:cm,1);
XX(1,2:cn+1,1)=D(1,1:cn);

for k = 1 : cn
    XX(2:cm+1,1+k,1)=C(1:cm,k);
end


%%% XX, layer 1 built. Adding a dummy source or destination, if needed

switch sign(sum(S)-sum(D))
    case 1
        disp('Adding dummy destination')
        XX(1,cn+2,1)=sum(S)-sum(D);
        XX(2:cm+1,cn+2,1)=zeros(cm,1);
        cn = cn+1;
    case 0
        disp('Balanced supply and demand')
    case -1
        disp('Adding dummy source')
        XX(cm+2,1,1)=sum(D)-sum(S);
        XX(cm+2,2:cn+1,1)=zeros(1,cn);
        cm = cm+1;
        
end
%%% XX layer 1 complete with dummy source or destination
%%% We shall now work out a basic feasible solution in Layer2

switch r
    case 1                                                               %%% North-West Corner Method 
        XX(1:cm+1,1,2)=XX(1:cm+1,1,1);            %%% initialize layer 2
        XX(1,1:cn+1,2)=XX(1,1:cn+1,1) ;            %%% with the supply and demand values
        temp=0;
        i=2;
        j=2;
        q=1;
        while temp==0
            q;
            switch sign(XX(1,j,2)-XX(i,1,2))
                case 1
                    
                   XX(i,j,2)= XX(i,1,2);
                   
                   XX(1,j,2)=XX(1,j,2)-XX(i,1,2);
                   XX(i,1,2)=0;
                   i=i+1;
                case -1
                    
                    XX(i,j,2)= XX(1,j,2);
                   
                   XX(i,1,2)=XX(i,1,2)-XX(1,j,2);
                   XX(1,j,2)=0;
                   j=j+1;
                case 0

                    XX(i,j,2)= XX(1,j,2);
                   
                   XX(i,1,2)=XX(i,1,2)-XX(1,j,2);
                   XX(1,j,2)=0;
                   j=j+1;
            end
            if i>cm+1 || j>cn+1
                temp=1;
            end
            q=q+1;
            
        end
                XX(1:cm+1,1,2)=XX(1:cm+1,1,1);             %%% initialize layer 2 supply and demand  
        XX(1,1:cn+1,2)=XX(1,1:cn+1,1) ;                       %%% again after modifying values.





end  %%% switch r loop ends
cont=1;
poi=XX(:,:,2);
poi=degeneracycorrect(poi);  %%% removing degeneracy
XX(:,:,2)=poi;

[e r ]=find(XX(2:cm+1,2:cn+1,2)~=0);
e=e+1;
     r=r+1;
     for p =1:length(e)
         
            XX(e(p,1),r(p,1),4)=1;                 %%% Layer 4 Initialized
         
     end
     


while cont==1
  
    XX;
    [u v]=multipliers(XX(2:cm+1,2:cn+1,2),XX(2:cm+1,2:cn+1,1),XX(2:cm+1,2:cn+1,4));
                         %%%%%% Calculating uv multipliers
    XX(2:cm+1,1,3)=u;
    XX(1,2:cn+1,3)=v';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Calculating u +v - c for each i,j 
[g h]=find(XX(2:cm+1,2:cn+1,2)==0);
g(1:length(g),1)=g(1:length(g),1)+1;
h(1:length(h),1)=h(1:length(h),1)+1;

%%%% 
%%lll=0;
XX(2:cm+1,2:cn+1,3)=zeros(cm,cn);
A=[];
%%%while(lll==0)
    disp('start');
for p=1:size([g h ],1)
    i=g(p,1);
    j=h(p,1);
    yyy=XX(1,j,3)+XX(i,1,3)-XX(i,j,1);
    XX(i,j,3)=XX(i,j,3)+yyy;
end
%%% NER calculated for each box
   XX(:,:,2)
   XX(:,:,3)
   if sign(max(max(XX(2:cm+1,2:cn+1,3))))<=0 %%%% condition for transportation algorithm to stop
                                                                               
       disp('in breakloop');
       cont=0;
       %%%lll=1;
       break
   end
[i j] = find(XX(2:cm+1,2:cn+1,3)==max(max(XX(2:cm+1,2:cn+1,3))));
%i=i+1;
%j=j+1;
%illl=i;
%jlll=j;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A(size(A,1)+1,1) = i+1;
A(size(A,1),2) = j+1;
disp('Max Value at')
[i j ]
[y2 bout2 loop2] =cycle(XX(2:cm+1,2:cn+1,2),A(size(A,1),1)-1,A(size(A,1),2)-1,XX(2:cm+1,2:cn+1,4));
disp('The loop is given by')
loop2
XX(2:cm+1,2:cn+1,4) = bout2;
XX(2:cm+1,2:cn+1,2)= y2;
XX(:,:,2)
   
%%lll==1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%end
end
disp('In the end')
XX(:,:,2)
   XX(:,:,3)
function jj = longestcontinuous( e, r)
jj=1;lc=1;lcmax=1;j=[1];jtemp=1;
    for p= 1:size(e,1)-1
    
    if e(p,1)==r(p+1,1) || r(p,1)==e(p+1,1) || e(p,1)==e(p+1,1) ||r(p,1)==r(p+1,1)
        lc=lc+1;
        
    else
        j=[j;p+1];
        if lcmax<lc
            lcmax=lc;
            jtemp=j(size(j,1)-1,1);
        end
    end
end
jj=jtemp;
            
        
end
    function X=degeneracycorrect(X)
        
        
        [m n] = size(X);
        m=m-1;
        n=n-1;
        x(3:m+2,3:n+2)=X(2:m+1,2:n+1);
        x(1:2,1:2)=0;
        x(1,:)=0;x(:,1)=0;
        if sum(sum(x))~=sum(X(1,:))
            disp('not balanced')
            return
        end
        
        N=m+n-1-length(find(x(3:m+2,3:n+2)~=0));
        if N>0
            for p=1:m
                x(p+2,2)=length(find(x(p+2,3:n+2)~=0));
                end
                for p=1:n
                x(2,p+2)=length(find(x(3:m+2,p+2)~=0));
                end
         
            while(sum(x(2,:))>0&&sum(x(:,2))>0)  
                
               
                
                h=find(x(2,3:n+2)==max(x(2,3:n+2)))+2;
                v=find(x(3:m+2,2)==max(x(3:m+2,2)))+2;
                if x(2,h(1,1))>x(v(1,1),2) 
                    
                        x(1,h(1,1))=1;
                        x(2:n+2,h(1,1))=0;
                    
                    
                    else
                    if x(v(1,1),2)>1
                        x(v(1,1),1)=1;
                        x(v(1,1),2:n+2)=0;
                    else
                        if sum(x(1,:))>sum(x(:,1))
                             x(v(1,1),1)=1;
                             x(v(1,1),2:n+2)=0; 
                             x(2:n+2,h(1,1))=0;
                        else
                            H=find(x(v(1,1),3:n+2)==max(x(v(1,1),3:n+2)))+2;
                            x(v(1,1),H)=0;
                            x(1,H)=1;
                            x(2:m+2,H)=0;
                        end
                    end
                end
                for p=1:m
                x(p+2,2)=length(find(x(p+2,3:n+2)~=0));
                end
                for p=1:n
                x(2,p+2)=length(find(x(3:m+2,p+2)~=0));
                end
            end
           
            
           h=find(x(1,:)==1)-1;
           v=find(x(:,1)==1)-1;
            p=(length(v));
           p1=(length(h));
           for pqqq=1:length(h)
               
               for pqqq1 = 1:length(v)
                   
                   
                   if N>0
                       if X(v(p,1),h(1,p1))==0
                       X(v(p,1),h(1,p1))=0.01;
                       N=N-1;
                       end                   
                   end
                   p1=p1-1;
               end
               p=p-1;
           end
               
            
            
            
        end
 
        return  
            
end
         
            
end

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
end






        
        
        
        
        
        