function [ valCorrel ] = noteViolon( freq )
    [dataSound,fe] = wavread('LA_Violon.wav');
    Spectre_Y = fft(dataSound); % Spectre du LA Violon réel
    
    Vechantillon = (0:fe);
    Vamp =[893.7,380.9,50.7,120.9,302,16.84,40.73,82.67,12.36,18.14];
    Vspectre = zeros(length(Vechantillon),1)';
    for i=1:10
       Vspectre(i*freq) = Vamp(i);
    end
    VnoteViolon = ifft(Vspectre);
    VnoteViolon = abs(VnoteViolon);
        
    MaxSoundEvolReel = max(dataSound);
    MaxSoundEvolSynth = max(VnoteViolon);
    Amplification = MaxSoundEvolReel/MaxSoundEvolSynth
    VnoteViolon = Amplification*VnoteViolon;
    
    Spectre_X = fft(VnoteViolon);%spectre de la note créée (synthétique)

    sound(VnoteViolon,fe);
    
    if length(Spectre_X)>length(Spectre_Y)
       Spectre_X = Spectre_X(1:length(Spectre_Y));
    else
       Spectre_Y = Spectre_Y(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(Spectre_Y))
    valCorrel = abs(vectCorrel(1,2));
    
    AffSpectreData(dataSound,fe);
    AffSpectreData(VnoteViolon,fe);
    
end