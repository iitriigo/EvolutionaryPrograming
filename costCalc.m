function [ price ] = costCalc( a, b, c, POP, Pmax, Pmin)
%CostCalc - Computes the cost of each individual. If any generator is ...
% operating outside its limits applies a penalization.

[NumGeradores, NumPop] = size(POP);

price = zeros(1,NumPop);
M=0;
Dif = 0;
for j=1:NumPop
    for i=1:NumGeradores
       if(POP(i,j)>Pmax(i))
            M=100;
            Dif = POP(i,j) - Pmax(i);
       end
       
       if (POP(i,j)<Pmin(i))
           M = 100;
           Dif = Pmin(i) - POP(i,j);
       end
       price(j)=price(j)+a(i)+b(i)*POP(i,j)+c(i)*POP(i,j)^2+Dif^2*M;
       M=0;
       Dif=0;
    end
end

