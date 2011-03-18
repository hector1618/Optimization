function display(s);
% function display(s);
% VIGCRYPTO/DISPLAY Command window display of an msegment;
%

disp(' ');
disp([inputname(1),' = '])
disp(' ');
disp(['Vigenere crypto with ' num2str(size(s.cryptotext,2)) ' characters.'])
disp(' ');
disp(s.alphabet(s.cryptotext))
