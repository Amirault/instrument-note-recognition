
FreqCoupure = 1400;
[dataSound,fe,nbits] = wavread('Mix.wav');
sound(dataSound,fe)
MixSpectre = fft(dataSound);
SizeData = length(dataSound);
IntervalFreq = ((0:(SizeData-1))/(SizeData))*fe;
%Vzero = zeros(SizeData-FreqCoupure,1);
%MixSpectre(FreqCoupure : end) = Vzero;

for i=1:SizeData
    if (IntervalFreq(i) > FreqCoupure)
        MixSpectre(i) = 0;
    end
end

plot (IntervalFreq,abs(MixSpectre));
MixEvolTemp = abs(ifft(MixSpectre));
sound(MixEvolTemp,fe)

% Solution question 4) -> Amplification

sound(10*MixEvolTemp,fe)
AffSpectreData(10*MixEvolTemp,fe)