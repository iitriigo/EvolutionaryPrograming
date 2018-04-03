function [ BestPOP,BestSigma ,BestPrice ] = elitist_Sig(POP, Sigma, Cost, NumPop)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[Cost_order, index] = sort(Cost);

BestPrice = Cost_order(1);

for i=1:NumPop   
    BestPOP(:,i)=POP(:,index(i));  
    BestSigma(i)=Sigma(index(i));
end
end

