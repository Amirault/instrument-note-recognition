function [ fe , vSpectre ] = AffSpectre( soundFileName )
    [dataSound,fe,nbits] = wavread(soundFileName);
    sound(dataSound,fe);
    SizeData = length(dataSound);
    MaxTime = (1/fe) * length(dataSound);
    Intervaltempo = (1/fe):(1/fe):MaxTime;
    figure();
    plot(Intervaltempo,dataSound);
    vSpectre = fft(dataSound);
    IntervalFreq = (0:(fe/SizeData):((SizeData-1)/(SizeData))*fe);
    figure();
    plot (IntervalFreq,abs(vSpectre));
end

