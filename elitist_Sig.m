function [ BestPOP,BestSigma ,BestPrice ] = elitist_Sig(POP, Sigma, Cost, NumPop)
%ELITIST - Chooses the best elements
%    This function orders the cost of each individual and chooses the ...
%    best elements of the population 

[Cost_order, index] = sort(Cost);

BestPrice = Cost_order(1);

for i=1:NumPop   
    BestPOP(:,i)=POP(:,index(i));  
    BestSigma(i)=Sigma(index(i));
end
end

