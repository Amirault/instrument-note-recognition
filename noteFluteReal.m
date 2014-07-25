function [ Spectre_X ] = noteFluteReal( freq )
% Fonction permettant la synthétisation d'une note de Flute selon une
% frequence donnée (freq)
%La fonction retourne le spectre de la note de flute créée

    [dataSound,fe] = wavread('LA_Flute.wav');% LA Flute réel, notre référence d'une note de flute
    Spectre_Y = fft(dataSound); %Spectre du LA Flute réel
    SizeData = length(Spectre_Y);%Taille du spectre de LA Flute réel
    Spectre_Y(SizeData/2:SizeData) = 0;%On efface les fréquences dù au repliment de spectre
    
    Spectre_X = zeros(fe,1)';%Initialisation du spectre de la nouvelle note à créer
    i = round(440*SizeData/fe);%Calcul du fondamental du LA Flute
    limit_1 = round(SizeData/2);%Calcul de la taille maximal d'echantillon utile pour le spectre Y (celui du LA Flute réel)
    limit_2 = round(length(Spectre_X)/2);%Calcul de la taille maximal d'echantillon utile pour le spectre X (celui de la note à créer)
    j=1;%index 
    
    % Synthése de la note de fréquence de fondamental "freq"
    while ((i <= limit_1)&&(j*freq <= limit_2))
        if (j*freq <= 100)% Cas spécial la fréquence demandé est inférieur à 100
            %Copie et association des amplitudes des correspondantes aux différentes harmoniques
            Spectre_X(j*freq:j*freq+100) = Spectre_Y(i:i+100);
        else
            %Copie et association des amplitudes des correspondantes aux différentes harmoniques
            %Copie des amplitudes sur 200 frequences autour d'un harmonique  du fondamental (440 Hz) du spectre du LA Flute réel
            %Association des amplitudes sur les harmoniques correspondant à
            %la fréquence donnée en paramètre de la fonction
            Spectre_X(j*freq-100:j*freq+100) = Spectre_Y(i-100:i+100);
        end
        j = j + 1;
        i = i + round(440*(SizeData/fe));
    end
    
    if length(Spectre_X)>length(Spectre_Y)
       Spectre_X = Spectre_X(1:length(Spectre_Y));
    else
       Spectre_Y = Spectre_Y(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(Spectre_Y))
    valCorrel = abs(vectCorrel(1,2))
end