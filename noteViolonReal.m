function [ Spectre_X ] = noteViolonReal( freq )
% Fonction permettant la synth�tisation d'une note de Violon selon une
% frequence donn�e (freq)
%La fonction retourne le spectre de la note de Violon cr��e

    [dataSound,fe] = wavread('LA_Violon.wav');% LA Violon r�el, notre r�f�rence d'une note de violon
    Spectre_Y = fft(dataSound); %Spectre du LA Violon r�el
    SizeData = length(Spectre_Y);%Taille du spectre de LA Violon r�el
    Spectre_Y(SizeData/2:SizeData) = 0;%On efface les fr�quences d� au repliment de spectre
    
    Spectre_X = zeros(SizeData,1)';%Initialisation du spectre de la nouvelle note � cr�er
    i = round((length(Spectre_Y)/fe)*440);%Calcul du fondamental du LA Violon
    limit_1 = round(length(Spectre_Y)/2);%Calcul de la taille maximal d'echantillon utile pour le spectre Y (celui du LA Violon r�el)
    limit_2 = round(length(Spectre_X)/2);%Calcul de la taille maximal d'echantillon utile pour le spectre X (celui de la note � cr�er)
    j=1;%index 
    
    % Synth�se de la note de fr�quence de fondamental "freq"
    while ((i <= limit_1)&&(j*freq <= limit_2))
        if (j*freq <= 100)% Cas sp�cial la fr�quence demand� est inf�rieur � 100
            %Copie et association des amplitudes des correspondantes aux diff�rentes harmoniques
            Spectre_X(j*freq:j*freq+200) = Spectre_Y(i:i+200);
        else
            %Copie et association des amplitudes des correspondantes aux diff�rentes harmoniques
            %Copie des amplitudes sur 300 frequences autour d'un harmonique  du fondamental (440 Hz) du spectre du LA violon r�el
            %Association des amplitudes sur les harmoniques correspondant �
            %la fr�quence donn�e en param�tre de la fonction
            Spectre_X(j*freq*round(length(Spectre_Y)/fe)-50:j*freq*round(length(Spectre_Y)/fe)+200) = Spectre_Y(i-50:i+200);
        end
        j = j + 1;
        i = i + round(440*length(Spectre_Y)/fe);
    end
end