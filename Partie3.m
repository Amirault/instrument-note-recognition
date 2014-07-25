%A
%1
[ fe , SpectreViolonBruit ] = AffSpectre('ViolonBruit.wav');
[dataViolonBruit,fe,nbits] = wavread('ViolonBruit.wav');
%2
[ fe , SpectreMi_Violon ] = AffSpectre('Mi_Violon.wav');
[dataMi_Violon,fe,nbits] = wavread('Mi_Violon.wav');
%3
[dataSound,fe,nbits] = wavread('Mi_Violon.wav');
corrcoef(dataSound,dataSound)
%4
[ fe , SpectreMi_Violon ] = AffSpectre('Mi_Violon.wav');
corrcoef(abs(SpectreMi_Violon),abs(SpectreMi_Violon))
[dataMi_Violon,fe,nbits] = wavread('Mi_Violon.wav');
[dataViolonBruit,fe,nbits] = wavread('ViolonBruit.wav');
corrcoef(dataMi_Violon,dataViolonBruit)
%5
[ fe , SpectreViolonBruit ] = AffSpectre('ViolonBruit.wav');
[ fe , SpectreMi_Violon ] = AffSpectre('Mi_Violon.wav');
corrcoef(abs(SpectreViolonBruit),abs(SpectreMi_Violon))
%B
%1
%voir fonction