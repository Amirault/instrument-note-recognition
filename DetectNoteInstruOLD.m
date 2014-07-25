function [ FreqFinal ] = DetectNoteInstruOLD( soundFileName )
%Fonction principal 
% Fonction qui permet de detecter la note de musique jouer ainsi que
% l'instrument utilisé dans un fichier audio
% Prend en paramètre le nom du fichier audio et retourne la note joué ainsi
% que l'instrument utilisé

    %%%Lecture et traitement du fichier audio entrée en paramètre%%%
    [dataSound,fe] = wavread(soundFileName);%Lecture du son afin de recupérer les données utiles (frequence echantillonage + données)
    sound(dataSound,fe); %Ecoute du son en paramètre  
    Spectre_X = fft(dataSound);% Transformé de fourrier sur le son entrée en paramètre
    SizeMaxSpectre = 20000*(length(Spectre_X)/fe);
    % Suppression de fréquence non audible %
    if (fe > SizeMaxSpectre)
        Spectre_X = Spectre_X(1:SizeMaxSpectre);% On ne garde que les fréquences audibles.
    else
        Spectre_X(length(Spectre_X):SizeMaxSpectre)=0;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    % Chargement des fréquences de l'octave 1, pour pouvoir générer les
    % autres fréquence des octaves 2,3,4,5,7,8,9
    BaseFreq = [65.406391,69.295658,73.416192,77.781746,82.406889,87.307058,92.498606,97.998859,103.82617,110,116.54094,123.47083];
    
    %Initialisation des variables utiles%
    FreqFinalFlute = 0;%Contiendra la fréquence joué si l'instrument est une flute
    FreqFinalViolon = 0;%Contiendra la fréquence joué si l'instrument est un violon
    valCorrelViolonSave = 0;%Contiendra le coeficient de correlation le plus proche pour un violon
    valCorrelFluteSave = 0;%Contiendra le coeficient de correlation le plus proche pour une flute
    
    for i=1:9 % Boucle pour les 9 octaves
        for j=1:12 % Boucle pour les 12 
            %Création d'une note de violon et d'un note de flute à la fréquence courante%
            SpectreNoteViolon = noteViolonReal(round(i*BaseFreq(j)));
            SpectreNoteFlute = noteFluteReal(round(i*BaseFreq(j)));
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Calcul de la correlation en la note créé et le signal sonore
            % contenu dans le fichie entrée en paramètre
            valCorrelViolon = CalcCorrelSpectre(Spectre_X,SpectreNoteViolon);
            valCorrelFlute = CalcCorrelSpectre(Spectre_X,SpectreNoteFlute);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Verifie si la correlation est plus proche que celle obtenu
            % précédement
            if (valCorrelViolonSave < valCorrelViolon)
                valCorrelViolonSave = valCorrelViolon;% Sauvegarde du plus grand coeficient de correlation pour un violon%
                FreqFinalViolon = i*BaseFreq(j);%Sauvegarde de la frequence correspondante à la correlation effectué%
            end
            % Verifie si la correlation est plus proche que celle obtenu
            % précédement
            if (valCorrelFluteSave < valCorrelFlute)
                valCorrelFluteSave = valCorrelFlute;% Sauvegarde du plus grand coeficient de correlation pour une flute%
                FreqFinalFlute = i*BaseFreq(j);%Sauvegarde de la frequence correspondante à la correlation effectué%
            end
        end
    end    
    %Affichage du résultat%
    if (valCorrelViolonSave > valCorrelFluteSave)
        %Si c'est le violon qui est le plus probable on affiche les valeurs correspondante%
        disp('Violon');
        disp(valCorrelViolonSave);
        disp(FreqFinalViolon);
    elseif (valCorrelViolonSave < valCorrelFluteSave)
        %Si c'est la flute qui est le plus probable on affiche les valeurs correspondante%
        disp ('Flute');
        disp(valCorrelFluteSave);
        disp(FreqFinalFlute);
    else
        %Si les deux sont equiprobables on affiche les valeurs correspondante%
        disp('Violon');
        disp(valCorrelViolonSave);
        disp(FreqFinalViolon);
        disp ('Flute');
        disp(valCorrelFluteSave);
        disp(FreqFinalFlute);
    end
end

