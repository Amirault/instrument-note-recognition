function [ SoundEvolTemp ] = FiltreHautBas( FileName,FreqCoupure,xBas )
[dataSound,fe,nbits] = wavread(FileName);
sound(dataSound,fe)
MaxDataSound = max(dataSound);
SoundSpectre = fft(dataSound);
SizeData = length(dataSound);
IntervalFreq = ((0:(SizeData-1))/(SizeData))*fe;
plot (IntervalFreq,abs(SoundSpectre));
if (xBas == 1)
    for i=1:SizeData
        if (IntervalFreq(i) > FreqCoupure)
            SoundSpectre(i) = 0;
        end
    end
else
    for i=1:SizeData
        if (IntervalFreq(i) < FreqCoupure)
            SoundSpectre(i) = 0;
        end
    end
end
figure();
plot (IntervalFreq,abs(SoundSpectre));
SoundEvolTemp = abs(ifft(SoundSpectre));
sound(SoundEvolTemp,fe)
MaxSoundEvolTemp = max(SoundEvolTemp);
% Solution question 4) -> Amplification
Amplification = MaxDataSound/MaxSoundEvolTemp;
sound(Amplification*SoundEvolTemp,fe)

end

