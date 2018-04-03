function [ mutatedPOP ] = mutate(POP, clonePOP, sigma, Load)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[l,c] = size(POP);
min = c + 1;
max = c + c;
ger_n = l;

mutatedPOP=clonePOP;

for j = min:max
    totalGerado=0;
    for i=1:ger_n  
     % a=sigma*rand;
      mutatedPOP(i,j) = clonePOP(i,j) + sigma*randn;
      totalGerado = totalGerado + mutatedPOP(i,j);
    end
    
    
    for i=1:ger_n
        mutatedPOP(i,j)=mutatedPOP(i,j)*(Load/totalGerado);
    end
        
end

end


