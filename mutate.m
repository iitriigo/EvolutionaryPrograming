function [ mutatedPOP ] = mutate(POP, clonePOP, sigma, Load)
%MUTATE - Mutates current population
%  This function mutates the new population individuals according to ...
%  the following rule: 
%    X_new = X_old + sigma*N(0,1)
%  Sigma is a constant whose influence will be tested by changing it's ...
%  value and analysing the end result

[l,c] = size(POP);
min = c + 1;
max = c + c;
ger_n = l;

mutatedPOP=clonePOP;

for j = min:max
    totalGerado=0;
    for i=1:ger_n  
      mutatedPOP(i,j) = clonePOP(i,j) + sigma*randn;
      totalGerado = totalGerado + mutatedPOP(i,j);
    end
    
    
    for i=1:ger_n
        mutatedPOP(i,j)=mutatedPOP(i,j)*(Load/totalGerado);
    end
        
end

end


