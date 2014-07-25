function [ AmpHarmonique ] = recupAmp(soundFileName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [dataSound,fe] = wavread(soundFileName);
    Spectre_Y = fft(dataSound);  
    j=1;
    k=1;
    SizeMaxSpectre = 20000*(length(Spectre_Y)/fe);
    if (SizeMaxSpectre > length(Spectre_Y))
        SizeMaxSpectre = length(Spectre_Y);
    end
    AmpHarmonique = ones(0,SizeMaxSpectre)';    
    
    ratioTemps = round((length(Spectre_Y)/fe));
    start = ratioTemps*400;
    i = start;
    while (i <= SizeMaxSpectre)
        if (((start <= i)&&(round(start+100*ratioTemps) >= i)))
            AmpHarmonique(j,k) = Spectre_Y(i);
            k = k+1;
            i = i +1;
        elseif (round(start+100*ratioTemps) <= i)
            j = j+1;
            start = ratioTemps*400*j;
            k = 1;
            i = start;
        else
            i = i+1;
        end
    end
end

