function [tf] = blindTest( fichier )

    fA = 440.00;
    fAd = fA*2^(1/12);
    fB = fAd*2^(1/12);
    fC = fB*2^(1/12);
    fCd = fC*2^(1/12);
    fD = fCd*2^(1/12);
    fDd = fD*2^(1/12);
    fE = fDd*2^(1/12);
    fF = fE*2^(1/12);
    fFd = fF*2^(1/12);
    fG = fFd*2^(1/12);
    fGd = fG*2^(1/12);
    
    gamme = struct('Do', fC, 'DoDiese', fCd, 'Re', fD, 'ReDiese', fDd, 'Mi', fE, 'Fa', fF, 'FaDiese', fFd, 'Sol', fG, 'SolDiese', fGd, 'La', fA, 'LaDiese', fAd, 'Si', fB); 
    
    [y,Fs] = wavread(fichier);  %écouter le son contenu dans le fichier
    tf = fft(y);    %transformée de Fourier
    nbE = length(y);    %nombre d'échantillons
    [c,indice] = max(abs(tf)); %l'indice de l'échantillon avec l'amplitude la plus grande
    F = indice*Fs/nbE; %fréquence de l'harmonique avec l'amplitude la plus grande
    maxY = max(y);
    figure();
    plot ((1:nbE)*Fs/nbE, abs(tf)); xlabel('f(Hz)'); ylabel('s(Volts)');
    sound(y, Fs);
    
    names = fieldnames(gamme);
    x=F/gamme.(names{1});
    min = x - floor(x);
    iMin = 1;
    i = 1;
    while  i <= numel(names) 
        x=F/gamme.(names{i});
        m = x - floor(x);
        if m < min
            min = m;
            iMin = i;
        end 
        i=i+1;
    end
    disp(names{iMin});
    Fmodele = gamme.(names{iMin});
    iModele = round((Fmodele*nbE)/Fs);
    
    [yLaFlute,FsLaFlute] = wavread('LA_Flute.wav');  %écouter la note La d'une flûte
    tfLaFlute = fft(yLaFlute);    %transformée de Fourier
    nbELaFlute = length(yLaFlute);    %nombre d'échantillons
    [cLaFlute,indiceLaFlute] = max(abs(tfLaFlute)); %l'indice de l'échantillon avec l'amplitude la plus grande
    
    figure();
    plot ((1:nbELaFlute)*FsLaFlute/nbELaFlute, abs(tfLaFlute)); xlabel('f(Hz)'); ylabel('s(Volts)');
    
    tfGenere=zeros(nbE,1);
    j = indiceLaFlute;
    i = iModele;
    while i <= nbE/2
        if(j<=nbELaFlute/2)
            tfGenere(i) = tfLaFlute(j);
            j= j+indiceLaFlute;
        end
        i = i + iModele;
    end
    i = nbE-iModele+1;
    j = nbELaFlute-indiceLaFlute+2;
    while i > nbE/2
        if(j>nbELaFlute/2)
            tfGenere(i) = tfLaFlute(j);
            j= j-indiceLaFlute;
        end
        i = i-iModele;
    end
  
     figure();
     plot ((1:nbE)*Fs/nbE, abs(tfGenere)); xlabel('f(Hz)'); ylabel('s(Volts)');
    yGenere =  abs(ifft(tfGenere));
    yGenere = yGenere*(maxY/max(yGenere));
%     sound(yGenere, Fs);
    R = corrcoef(y, yGenere);
end

