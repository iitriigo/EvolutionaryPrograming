function [ price ] = costCalc( a, b, c, POP, Pmax, Pmin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[NumGeradores, NumPop] = size(POP);

price = zeros(1,NumPop);
M=0;
for j=1:NumPop
    for i=1:NumGeradores
       if(POP(i,j)>Pmax(i)||POP(i,j)<Pmin(i))
            M=1000;
       end
       price(j)=price(j)+a(i)+b(i)*POP(i,j)+c(i)*POP(i,j)^2+POP(i,j)*M^2;
       M=0;
    end
end

