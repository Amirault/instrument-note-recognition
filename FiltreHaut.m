function [ outVector ] = FiltreHaut( FileName )
    [dataSound,fe,nbits] = wavread(FileName);
    sound(dataSound);
    SizeData = length(dataSound);
    outVector = zeros(SizeData,1)';%avec transposé pour Vecteur ligne
    for i=1:SizeData
        if (i+1 < SizeData)
            outVector(i) = dataSound(i+1)-dataSound(i);
        end
    end
    sound(outVector)
end

