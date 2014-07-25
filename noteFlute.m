function [ valCorrel ] = noteFlute( freq )

    [dataSound,fe] = wavread('LA_Flute.wav');
    Spectre_Y = fft(dataSound);
    
    Vechantillon = (0:fe);
    Vamp = [863.1,692,333.5,61.65,28.41,17.71,9.55,6.789,3.619,2.322];
    Vspectre = zeros(length(Vechantillon),1)';
    for i=1:10
       Vspectre(i*freq) = Vamp(i);
    end
    VnoteFlute = ifft(Vspectre);
    VnoteFlute = abs(VnoteFlute);
    VnoteFlute = VnoteFlute - mean(VnoteFlute);

    MaxSoundEvolReel = max(dataSound);
    MaxSoundEvolSynth = max(VnoteFlute);
    Amplification = MaxSoundEvolReel/MaxSoundEvolSynth;
    VnoteFlute = Amplification*VnoteFlute;
    
    Spectre_X = fft(VnoteFlute);%spectre de la note créée (synthétique)

    sound(VnoteFlute,fe);
    
    SizeData = length(VnoteFlute);
    vSpectre = fft(VnoteFlute);
    IntervalFreq = (0:(fe/SizeData):((SizeData-1)/(SizeData))*fe);
    figure();
    plot (IntervalFreq,abs(vSpectre));
    
    if length(Spectre_X)>length(Spectre_Y)
       Spectre_X = Spectre_X(1:length(Spectre_Y));
    else
       Spectre_Y = Spectre_Y(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(Spectre_Y));
    valCorrel = abs(vectCorrel(1,2));
end