function [ VLa440 ] = La440()
Vechantillon = (0:44100);
Vfreq = 400;
Vamp = [863.1,692,333.5,61.65,28.41,17.71,9.55,6.789,3.619,2.322];
Vspectre = zeros(length(Vechantillon),1)';
for i=1:10
   Vspectre(i*Vfreq) = Vamp(i);
end
VLa440 = ifft(Vspectre);
VLa440 = abs(VLa440);
sound(VLa440,44100);
end