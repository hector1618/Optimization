clf;
axis('off')
axis([0 1 0 1])
hold on;
for i=1:nrnod,
  text(xpos(i)-0.012,ypos(i)+0.002,num2str(i));
  for j=1:nrnod,
    if cap(i,j)>0,
      plot([0.925*xpos(i)+0.075*xpos(j) 0.075*xpos(i)+0.925*xpos(j)],[0.925*ypos(i)+0.075*ypos(j) 0.075*ypos(i)+0.925*ypos(j)]);
%      text(0.15*xpos(i)+0.85*xpos(j),0.15*ypos(i)+0.85*ypos(j),'*');
      text(0.15*xpos(i)+0.85*xpos(j)-0.006,0.15*ypos(i)+0.85*ypos(j)-0.008,'*');
    end;
  end;
end;
hold;

