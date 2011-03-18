% MAXFLOW is an interactive workbench for a maxflow problem.
% Needs initiations of xpos(i), ypos(i) and cap(i,j).
% Uses MAXFLOWDATA.M, RITA.M and TEXTA.M.
maxflowdata
nrnod=length(xpos);
mflow=0;
done=0;
figure(1)
rita;
while ~done,
  fprintf(' When finished, input new path = []');
  path=input('Input new path (e.g. [10 5 6 7 8 9]) = ');
  if (length(path)~=0),
    minflow=Inf;
    for i=1:length(path)-1,
      minflow=min(minflow,cap(path(i),path(i+1)));
    end
    if (path(1)~=start|path(length(path))~=stop | min(path)<1|max(path)>nrnod)
       disp(' Error in path')
    else
      if minflow<=0, 
        disp(' No flow possible')
      else
        for i=1:length(path)-1, 
          from=path(i);
          to=path(i+1);
          cap(from,to)=cap(from,to)-minflow;
          cap(to,from)=cap(to,from)+minflow;
        end;
        mflow=mflow+minflow
        rita;
      end;
    end;
  else  
    disp(' Now you are to find a "minimal cut" by dividing the nodes')
    disp(' into two sets M and IM such that the nodes in M can be')
    disp(' reached from the start node.')
    I=input('M = ');
    J=input('IM = ');
    if (length([I J])~=nrnod | (sort([I'; J'])~=(1:nrnod)'))
      fprintf('error in M,IM\n');
      done=0;
    else
      done=1;
      mcut=0;
      for i=I,
        for j=J,
          if (cap(i,j)>0),
            fprintf('flow between node %g and %g\n',i,j);
            done=0; 
          else
            mcut=mcut+max([startcap(i,j) 0]);
          end;
        end;
      end;
    end;
  end;  
end
disp(['maxflow = ',int2str(mflow)]);
disp(['min-cut = ',int2str(mcut)]);
hold off
