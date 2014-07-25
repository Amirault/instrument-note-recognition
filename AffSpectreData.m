function [ fe , vSpectre ] = AffSpectreData( dataSound,fe )
    sound(dataSound,fe);
    SizeData = length(dataSound);
    MaxTime = (1/fe) * SizeData;
    Intervaltempo = (1/fe):(1/fe):MaxTime;
    figure();
    plot(Intervaltempo,dataSound);
    vSpectre = fft(dataSound);
    IntervalFreq = (0:(fe/SizeData):((SizeData-1)/(SizeData))*fe);
    figure();
    plot (IntervalFreq,abs(vSpectre));
end