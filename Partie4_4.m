Vechantillon = (0:(1/44100):5);
Vfreq = [441.9,883.8,1326,1765,2209,2651,3092,3535,3977,4414];
Vamp = [863.1,692,333.5,61.65,28.41,17.71,9.55,6.789,3.619,2.322];
clear Vsin;
Vsin = zeros(length(Vechantillon),1)';
for i=1:10
    Vsin = Vsin +Vamp(i)*sin(2*pi*Vfreq(i)*Vechantillon);
end
Vsin = Vsin/10^4;
%plot (Vechantillon,Vsin);
sound(Vsin,44100);