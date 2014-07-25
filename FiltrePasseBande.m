function [ SoundEvolTemp ] = FiltrePasseBande( FileName,FreqCoupureBasse,FreqCoupureHaute )
[dataSound,fe,nbits] = wavread(FileName);
sound(dataSound,fe)
MaxDataSound = max(dataSound);
SoundSpectre = fft(dataSound);
SizeData = length(dataSound);
IntervalFreq = ((0:(SizeData-1))/(SizeData))*fe;
plot (IntervalFreq,abs(SoundSpectre));
for i=1:SizeData
    if ((IntervalFreq(i) < FreqCoupureBasse)||(IntervalFreq(i) > FreqCoupureHaute))
        SoundSpectre(i) = 0;
    end
end
figure();
plot (IntervalFreq,abs(SoundSpectre));
SoundEvolTemp = abs(ifft(SoundSpectre));
sound(SoundEvolTemp,fe)
MaxSoundEvolTemp = max(SoundEvolTemp);
Amplification = MaxDataSound/MaxSoundEvolTemp;
sound(Amplification*SoundEvolTemp,fe)

end

