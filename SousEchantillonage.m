function [ dataSubSound] = SousEchantillonage(soundFileName,feSub)   
    [dataSound,fe] = wavread(soundFileName);
    if feSub < fe
        rapportEchant = round (fe/feSub);
        SizeOfdataSound = size(dataSound);
        SizeOfdataSubSound = fix(SizeOfdataSound/rapportEchant);
        dataSubSound = 1:SizeOfdataSubSound;
        for i=1:SizeOfdataSubSound
            dataSubSound(i) = dataSound(rapportEchant*i);
        end
        wavwrite(dataSubSound,feSub,'SousEchantillon');
    else
        disp('Erreur la frequence d échantillonage est plus grande !');
        dataSubSound =0;
    end
end

