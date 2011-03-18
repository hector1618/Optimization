function ialfabet=invalfabet(alfabet);

ialfabet=ones(1,256);
for k=1:size(alfabet,2);
 ialfabet(abs(alfabet(k)))=k;
end;
