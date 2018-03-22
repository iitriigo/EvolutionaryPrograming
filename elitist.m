function [ BestPOP, BestPrice ] = elitist(POP, Cost, NumPop)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[Cost_order, index] = sort(Cost);

BestPrice = Cost_order(1);
for i=1:NumPop   
    BestPOP(:,i)=POP(:,index(i));  
end
end

