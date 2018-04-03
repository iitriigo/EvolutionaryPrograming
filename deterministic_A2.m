function [ ChosenPOP_order, BestPrice ] = deterministic_A2( POP, NumPop, a, b, ...
    c, Pmax, Pmin, P_l, Amatrix, Line_Lim)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

PopSize = length(POP);
aux = zeros(1,PopSize);
TournamentPOP = zeros(4,PopSize);
Cost = zeros(1, PopSize);
index = 1;

for i=1:NumPop
	%Chose fist index:
	while 1
		n1 = randi(PopSize);
		if ismember(n1, aux) == 0
			aux(index) = n1; 
			break
        end
    end 
    index = index+1;
    
    
    %Chose second index:
 	while 1
		n2 = randi(PopSize);
		if ismember(n2, aux) == 0
			aux(index) = n2;
			break
        end
    end 
    index = index+1;     
end 


%% Re-order matrix
for i=1:PopSize
    TournamentPOP(:,i) = POP(:,(aux(i)));
end


Cost = costCalc(a,b,c, TournamentPOP,Pmax,Pmin);
Cost = LineInLimit(TournamentPOP, P_l, Amatrix, Line_Lim, Cost);


 %% Tournament 

n1 = 1;
n2 = 2;

for i=1:NumPop
    Prob = rand;
    
    if Prob > 0.2 %Choose lower price
        
        if Cost(n1)>Cost(n2)
            ChosenPOP(:,i) = TournamentPOP(:,n2);
            ChosenPrice(i) = Cost(n2);
        else 
            ChosenPOP(:,i) = TournamentPOP(:,n1);
            ChosenPrice(i) = Cost(n1);
        end 
        
    else
        
        if Cost(n1)>Cost(n2)
            ChosenPOP(:,i) = TournamentPOP(:,n1);
            ChosenPrice(i) = Cost(n1);
        else 
            ChosenPOP(:,i) = TournamentPOP(:,n2);
            ChosenPrice(i) = Cost(n2);
        end 
    end
    
    n1 = n1+2;
    n2 = n2+2;
end


[ChosenPrice_order, index] = sort(ChosenPrice);

BestPrice = ChosenPrice_order(1);

for i=1:NumPop   
    ChosenPOP_order(:,i)=ChosenPOP(:,index(i));  
end

end

