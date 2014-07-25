function [ valCorrel ] = CalcValCorrel( fileName )
    valCorrel = zeros(2,1)';
    %%%%
    [ fe , Spectre_X ] = AffSpectre(fileName);
    [ fe , SpectreY ] = AffSpectre('ViolonMix.wav');
    if length(Spectre_X)>length(SpectreY)
       Spectre_X = Spectre_X(1:length(SpectreY));
    else
       SpectreY = SpectreY(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(SpectreY))
    valCorrel(1) = abs(vectCorrel(1,2));
    %%%%
    [ fe , Spectre_X ] = AffSpectre(fileName);
    [ fe , SpectreY ] = AffSpectre('FluteMix.wav');
    if length(Spectre_X)>length(SpectreY)
       Spectre_X = Spectre_X(1:length(SpectreY));
    else
       SpectreY = SpectreY(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(SpectreY))
    valCorrel(2) = abs(vectCorrel(1,2));
end

