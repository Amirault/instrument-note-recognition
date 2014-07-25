function [ valCorrel ] = CalcCorrelSpectre( Spectre_X,Spectre_Y )
%Fonction permettant le calcul de correlation entre deux spectre
%La fonction prend en paramètre deux spectres et effectue une correlation
%tout en redimensionnant les spectres si nécessaire

    % Si un spectre est plus grand que l'autre alors on redemensionne (minimize) le
    % plus grand
    if (length(Spectre_X)>length(Spectre_Y))
       Spectre_X = Spectre_X(1:length(Spectre_Y));
    else
       Spectre_Y = Spectre_Y(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(Spectre_Y));%Calcul de la correlation entre les deux spectre
    valCorrel = abs(vectCorrel(1,2));%Retour de la valeur de correlation correspondante en valeur absolue

end

