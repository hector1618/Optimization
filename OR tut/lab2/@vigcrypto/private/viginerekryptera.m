function ikry=viginerekryptera(iklar,kod,nalfabet);

period=size(kod,2);
niklar=size(iklar,2);

ikry=iklar;

for ii=1:period;
 koddel=kod(ii);
 if koddel>=0,
  aendra1=(iklar>1) & (iklar <=nalfabet);
  aendra2=zeros(size(iklar));
  aendra2(ii:period:niklar)=ones(size(ii:period:niklar));
  aendra=aendra1 & aendra2;
 
  temp=(iklar(aendra)+koddel);
  hoega=find(temp>nalfabet);
  if size(hoega,1)>0,
   temp(hoega)=temp(hoega)-nalfabet+1;
  end;
  ikry(aendra)=temp;
 else
  aendra2=zeros(size(iklar));
  aendra2(ii:period:niklar)=ones(size(ii:period:niklar));
  ikry(find(aendra2))=ones(1,sum(aendra2));
 end;
end;
