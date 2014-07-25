function [ fe , vSpectre ] = Listen( soundFileName )
    [dataSound,fe,nbits] = wavread(soundFileName);
    sound(dataSound,fe);
     if length(Spectre_X)>length(SpectreY)
       Spectre_X = Spectre_X(1:length(SpectreY));
    else
       SpectreY = SpectreY(1:length(Spectre_X));        
    end
    vectCorrel = corrcoef(abs(Spectre_X),abs(SpectreY))
    valCorrel(1) = abs(vectCorrel(1,2));
end