function [ FreqFinal ] = DetectNoteInstru( soundFileName )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    clear all;
    SizeSpectre = 20000;%Taille maximal d'un spectre
    valCorrel = zeros(2,1)';
    [dataSound,fe] = wavread(soundFileName);%Lecture du son afin de recupérer les données utiles (frequence echantillonage + données)
    sound(dataSound,fe); %Ecoute du son en paramètre  
    Spectre_X = fft(dataSound);% Transformé de fourrier sur le son entrée en paramètre
    if (length(Spectre_X)> SizeSpectre)
        Spectre_X = Spectre_X(1:SizeSpectre);% On ne garde que les fréquences audibles.
    end
        
    BaseFreq = [65.406391,69.295658,73.416192,77.781746,82.406889,87.307058,92.498606,97.998859,103.82617,110,116.54094,123.47083];
    FreqFinalFlute = 0;
    FreqFinalViolon = 0;
    valCorrelViolonSave = 0;
    valCorrelFluteSave = 0;
    CountFlute = 0;
    CountViolon = 0;
    
    for i=1:9
        for j=1:12
            %Création d'une note%
            VampViolon = recupAmp('LA_Violon.wav');
            if (length(VampViolon) < 
            VampFlute = recupAmp('LA_Flute.wav');
            SpectreNoteViolon = zeros(length(VampViolon),1)';
            SpectreNoteFlute = zeros(length(VampFlute),1)';
            for k=1:length(VampFlute)
               SpectreNoteFlute(round(k*i*BaseFreq(j))) = VampFlute(k);
            end 
            for k=1:length(VampViolon)
               SpectreNoteViolon(round(k*i*BaseFreq(j))) = VampViolon(k);
            end 
            VnoteFlute = ifft(SpectreNoteFlute);
            VnoteFlute = abs(VnoteFlute);
            VnoteFlute = VnoteFlute - mean(VnoteFlute);
            SpectreNoteFlute = fft(VnoteFlute);%spectre de la note créée (synthétique)
            VnoteViolon = ifft(SpectreNoteViolon);
            VnoteViolon = abs(VnoteViolon);
            VnoteViolon = VnoteViolon - mean(VnoteViolon);
            SpectreNoteViolon = fft(VnoteViolon);%spectre de la note créée (synthétique)
            %Fin de la création de la note%
            
            valCorrelViolon = CalcCorrelSpectre(Spectre_X,SpectreNoteViolon);
            valCorrelFlute = CalcCorrelSpectre(Spectre_X,SpectreNoteFlute);
            
            if (valCorrelViolonSave < valCorrelViolon)
                CountViolon = CountViolon + 1;
                valCorrelViolonSave = valCorrelViolon;
                FreqFinalViolon = i*BaseFreq(j);
            end
            if (valCorrelFluteSave < valCorrelFlute)
                CountFlute = CountFlute + 1;
                valCorrelFluteSave = valCorrelFlute;
                FreqFinalFlute = i*BaseFreq(j);
            end
        end
    end

    if (CountViolon > CountFlute)
        FreqFinal = FreqFinalViolon;
        disp('Violon');
    else
        FreqFinal = FreqFinalFlute;
        disp ('Flute');
    end

end

