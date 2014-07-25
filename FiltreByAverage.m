function [ outVector ] = FiltreByAverage( FileName )
    [dataSound,fe,nbits] = wavread(FileName);
    SizeData = length(dataSound);
    outVector = zeros(SizeData,1)';%avec transposé pour Vecteur ligne
    for i=1:SizeData
        if (i+100 < SizeData)
            outVector(i) = mean(dataSound(i:i+100));
        end
    end
end
