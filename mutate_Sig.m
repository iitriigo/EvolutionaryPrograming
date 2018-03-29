function [ mutatedPOP, mutateSigma ] = mutate_Sig(POP, clonePOP, Sigma, ...
    cloneSigma, tau, Load)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[l,c] = size(POP);
min = c + 1;
max = c + c;
ger_n = l;

mutatedPOP=clonePOP;
mutateSigma=cloneSigma;


for j = min:max
      mutateSigma(j) = tau*rand;
end



for j = min:max
    totalGerado=0;
    for i=1:ger_n 
      mutatedPOP(i,j) = clonePOP(i,j) + mutateSigma(i)*rand;
      totalGerado = totalGerado + mutatedPOP(i,j);
    end
    
    
    for i=1:ger_n
        mutatedPOP(i,j)=mutatedPOP(i,j)*(Load/totalGerado);
    end
        
end

end


