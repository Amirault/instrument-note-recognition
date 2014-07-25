function [ Spectre_X ] = noteViolonReal( freq )
% Fonction permettant la synthétisation d'une note de Violon selon une
% frequence donnée (freq)
%La fonction retourne le spectre de la note de Violon créée

    [dataSound,fe] = wavread('LA_Violon.wav');% LA Violon réel, notre référence d'une note de violon
    Spectre_Y = fft(dataSound); %Spectre du LA Violon réel
    SizeData = length(Spectre_Y);%Taille du spectre de LA Violon réel
    Spectre_Y(SizeData/2:SizeData) = 0;%On efface les fréquences dù au repliment de spectre
    
    Spectre_X = zeros(SizeData,1)';%Initialisation du spectre de la nouvelle note à créer
    i = round((length(Spectre_Y)/fe)*440);%Calcul du fondamental du LA Violon
    limit_1 = round(length(Spectre_Y)/2);%Calcul de la taille maximal d'echantillon utile pour le spectre Y (celui du LA Violon réel)
    limit_2 = round(length(Spectre_X)/2);%Calcul de la taille maximal d'echantillon utile pour le spectre X (celui de la note à créer)
    j=1;%index 
    
    % Synthése de la note de fréquence de fondamental "freq"
    while ((i <= limit_1)&&(j*freq <= limit_2))
        if (j*freq <= 100)% Cas spécial la fréquence demandé est inférieur à 100
            %Copie et association des amplitudes des correspondantes aux différentes harmoniques
            Spectre_X(j*freq:j*freq+200) = Spectre_Y(i:i+200);
        else
            %Copie et association des amplitudes des correspondantes aux différentes harmoniques
            %Copie des amplitudes sur 300 frequences autour d'un harmonique  du fondamental (440 Hz) du spectre du LA violon réel
            %Association des amplitudes sur les harmoniques correspondant à
            %la fréquence donnée en paramètre de la fonction
            Spectre_X(j*freq*round(length(Spectre_Y)/fe)-50:j*freq*round(length(Spectre_Y)/fe)+200) = Spectre_Y(i-50:i+200);
        end
        j = j + 1;
        i = i + round(440*length(Spectre_Y)/fe);
    end
end