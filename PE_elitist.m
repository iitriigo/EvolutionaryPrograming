%***********************************************************************%
%********************** State Estimation - A1 **************************%
%***************** Evolutionary Programing - Elitist********************%
%******************* Diogo Martins & Ines Trigo ************************%
%***********************************************************************%

clc
clear
close all

%% Get Data
Pmax=[80, 60, 70, 60];
Pmin=[40, 20, 30, 20];

%Cost Coefficients for each generator
a=[1100, 1200, 300, 650];
b=[20,25, 10, 20];
c=[0.1, 0.07, 0.2, 0.05];


%Parameters to change ____________________________________________________
P_load = 160;
NumPOP = 10;
simga = 0.5;
stop=0.0001;
%_______________________________________________________________________

NumGenerator = length(Pmax);


%% Initial Population
matrixPOP = GeraPop(Pmax, Pmin, NumPOP, P_load );


for initiatePOP=1:30

% Clone matrix
clonePOP=Clone(matrixPOP);

% Mutate
mutPOP_ini=mutate(matrixPOP, clonePOP, simga,P_load);
Cost_ini = costCalc(a,b,c,mutPOP_ini, Pmax, Pmin);

%Choose the Best
BestPOP = elitist(mutPOP_ini, Cost_ini, NumPOP);

%newGen
matrixPOP = BestPOP;
end 


for i=1:1000

% Clone matrix
clonePOP=Clone(matrixPOP);

% Mutate
mutPOP_ini=mutate(matrixPOP, clonePOP, simga,P_load);
Cost_ini = costCalc(a,b,c,mutPOP_ini, Pmax, Pmin);

%Choose the Best
[BestPOP, BestPrice] = elitist(mutPOP_ini, Cost_ini, NumPOP);


%Saving data for plotting
 Price_History(i) = BestPrice;
 Production_G31_History(i) = BestPOP(1,1);
 Production_G32_History(i) = BestPOP(2,1);
 Production_G41_History(i) = BestPOP(3,1);
 Production_G42_History(i) = BestPOP(4,1);


%Stoping criteria

if i>22
	if ( abs(Price_History(i-21)-Price_History(i))<stop)
        if (abs(Price_History(i-20)-Price_History(i-1))<stop)
		break
        end
	end

end
 
%newGen
matrixPOP = BestPOP;
end 

%% Results Display 
fprintf('Best Solution\nP (MW) =\n');
disp(BestPOP(:,1))
fprintf('Best Solution\nCost (Euro/MWh) = ');
disp(BestPrice)
fprintf('Number of iterations: ');
disp(i)

figure(1)
plot(Production_G31_History);
hold on 
plot(Production_G32_History);
hold on 
plot(Production_G41_History);
hold on 
plot(Production_G42_History);
title('Evolution of prodruction in the best individual')
xlabel('Number of iterations')
ylabel('Production (MW)')
legend('G31','G32','G41','G42')


figure(2)
plot(Price_History);
title('Evolution of BestPrice in the best individual')
xlabel('Number of iterations')
ylabel('Price (Euro/MWh)')





