 function degeneracycorrect(X)
        
        
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
               
            X
            
            
        end
 
          
            
end