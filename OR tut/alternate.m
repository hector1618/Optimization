%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if  XX(2,2,2)~=0 
XX(2,1,3)=XX(2,2,1);
i=2;j=2;uv=2;
 else
     [e r ] = find(XX(2:cm+1,2:cn+1,2)~=0);
     e=e+1;
     r=r+1;
     jj=longestcontinuous(e,r)
     XX(e(jj,1),1,3)=XX(e(jj,1),r(jj,1),1);
     i=e(jj,1);j=r(jj,1);
 end
temp=0;uv=2;%% uv is ki u and v me se agla kya set karna hai

while temp==0
           switch uv
               
               case 1
                   XX(i,1,3)=XX(i,j,1)-XX(1,j,3);
                   
               case 2
                   XX(1,j,3)=XX(i,j,1)-XX(i,1,3);
           end
                uv = 0;
                   if i<cm +1
                       if XX(i+1,j,2)~=0
                       uv=1;
                       end
                   end
                   if j<cn+1
                       if XX(i,j+1,2)~=0
                       uv=2;
                       end
                   end
                   if uv==2
                       j=j+1;
                   end
                   if uv==1
                       i=i+1;
                   end
                   
                   if uv==0
                       temp=1;
                   end
                   
            if i>cm+1 || j>cn+1
                temp=1;
            end
end %%while loop ends
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%