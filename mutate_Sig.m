function [ mutatedPOP, mutateSigma ] = mutate_Sig(POP, clonePOP, Sigma, ...
    cloneSigma, tau, Load)

%MUTATE -  Mutates current population and sigma values
%  This function mutates the new population individuals according to ...
%  the following rules: 
%    X_new = X_old + sigma*N(0,1)
%    Sigma_new = Sigma_old + tau*N(0,1)
%  Tau is a constant whose influence will be tested by changing it's ...
%  value and analysing the end result

[l,c] = size(POP);
min = c + 1;
max = c + c;
ger_n = l;

mutatedPOP=clonePOP;
mutateSigma=cloneSigma;


for j = min:max
    totalGerado=0;
    mutateSigma(j) = mutateSigma(j)+tau*randn;
    
    for i=1:ger_n 
      mutatedPOP(i,j) = clonePOP(i,j) + mutateSigma(i)*randn;
      totalGerado = totalGerado + mutatedPOP(i,j);
    end
    
    
    for i=1:ger_n
        mutatedPOP(i,j)=mutatedPOP(i,j)*(Load/totalGerado);
    end
        
end

end


