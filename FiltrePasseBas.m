function [ SoundEvolTemp ] = FiltrePasseBas( FileName,FreqCoupure )
[dataSound,fe,nbits] = wavread(FileName);
sound(dataSound,fe)
MaxDataSound = max(dataSound);
SoundSpectre = fft(dataSound);
SizeData = length(dataSound);
IntervalFreq = ((0:(SizeData-1))/(SizeData))*fe;
%Vzero = zeros(SizeData-FreqCoupure,1);
%MixSpectre(FreqCoupure : end) = Vzero;
for i=1:SizeData
    if (IntervalFreq(i) > FreqCoupure)
        SoundSpectre(i) = 0;
    end
end
plot (IntervalFreq,abs(SoundSpectre));
SoundEvolTemp = abs(ifft(SoundSpectre));
sound(SoundEvolTemp)
MaxSoundEvolTemp = max(SoundEvolTemp);
% Solution question 4) -> Amplification
Amplification = MaxDataSound/MaxSoundEvolTemp;
SoundEvolTemp = Amplification*SoundEvolTemp;
sound(SoundEvolTemp)

end

