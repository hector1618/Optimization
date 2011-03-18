function problem = demoproblem(problem);

alfabet='. abcdefghijklmnopqrstuvwxyzåäö';
nalfabet=size(alfabet,2);
ialfabet=invalfabet(alfabet);

% Kryptotext
fidin = fopen('vigtext','r') ;
[klartext,count] = fread(fidin) ;
klartext=klartext';
klartext=setstr(klartext);
klartext=klartext(1:30);
fclose(fidin);
iklartext=stringtoint(klartext,ialfabet);

%kod=[3 5 23];
kod='kombinatoriskoptimering';
kod='soqäupöjoluks onjuqylupw';
kod=kod(1:3);
kod=stringtoint(kod,ialfabet)-2;
period=size(kod,2);
ikryptotext=viginerekryptera(iklartext,kod,nalfabet);

% Statistik
load svtrifrekdubbel
if 1,
  tristat(find(tristat>1000)) = -3*ones(size(find(tristat>1000)));
end;

problem = vigcrypto(ikryptotext,alfabet,ltristat,tristat,utristat,size(kod,2),kod);
 
