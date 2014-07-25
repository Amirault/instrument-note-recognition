function [ Spectre_X ] = noteReal( freq,fileName )
% Fonction permettant la synth�tisation d'une note d'un instrument
% le fichier audio en param�tre donne la note et l'instrument de r�f�rence
% frequence donn�e (freq)
%La fonction retourne le spectre de la note de flute cr��e

    [dataSound,fe] = wavread(fileName);% note r�el, notre r�f�rence d'une note de l'instrument donn�
    Spectre_Y = fft(dataSound); %Spectre de la note r�el
    SizeData = length(Spectre_Y);%Taille du spectre de le note r�el
    Spectre_Y(SizeData/2:SizeData) = 0;%On efface les fr�quences d� au repliment de spectre
    
    Spectre_X = zeros(fe,1)';%Initialisation du spectre de la nouvelle note � cr�er
    i = round((SizeData/fe)*440);%Calcul du fondamental de la note r�el
    limit_1 = round(SizeData/2);%Calcul de la taille maximal d'echantillon utile pour le spectre Y (celui du LA Flute r�el)
    limit_2 = round(length(Spectre_X)/2);%Calcul de la taille maximal d'echantillon utile pour le spectre X (celui de la note � cr�er)
    j=1;%index 
    
    % Synth�se de la note de fr�quence de fondamental "freq"
    while ((i <= limit_1)&&(j*freq <= limit_2))
        if (j*freq <= 100)% Cas sp�cial la fr�quence demand� est inf�rieur � 100
            %Copie et association des amplitudes des correspondantes aux diff�rentes harmoniques
            Spectre_X(j*freq:j*freq+100) = Spectre_Y(i:i+100);
        else
            %Copie et association des amplitudes des correspondantes aux diff�rentes harmoniques
            %Copie des amplitudes sur 200 frequences autour d'un harmonique  du fondamental (440 Hz) du spectre du LA Flute r�el
            %Association des amplitudes sur les harmoniques correspondant �
            %la fr�quence donn�e en param�tre de la fonction
            Spectre_X(j*freq-100:j*freq+100) = Spectre_Y(i-100:i+100);
        end
        j = j + 1;
        i = round(i + 440*SizeData/fe);
    end
    Spectre_X = fft(VnoteViolon);%spectre de la note cr��e (synth�tique)

    sound(VnoteViolon,fe);
    
    if length(Spectre_X)>length(Spectre_Y)
       Spectre_X = Spectre_X(1:length(Spectre_Y));
    else
       Spectre_Y = Spectre_Y(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(Spectre_Y))
    valCorrel = abs(vectCorrel(1,2))
end