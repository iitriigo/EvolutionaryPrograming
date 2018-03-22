%***********************************************************************%
%************************* State Estimation ****************************%
%***************** Evolutionary Programing - Elitist********************%
%******************* Diogo Martins & Ines Trigo ************************%
%***********************************************************************%

clc
clear

%% Get Data
Pmax=[80, 60, 70, 60];
Pmin=[40, 20, 30, 20];

%Cost Coefficients for each generator
a=[1100, 1200, 300, 650];
b=[20,25, 10, 20];
c=[0.1, 0.07, 0.2, 0.05];


%Stuf we can change for the report_____________________________________
P_load = 160;
NumPOP = 3;
simga = 1;

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


for i=1:5000

% Clone matrix
clonePOP=Clone(matrixPOP);

% Mutate
mutPOP_ini=mutate(matrixPOP, clonePOP, simga,P_load);
Cost_ini = costCalc(a,b,c,mutPOP_ini, Pmax, Pmin);

%Choose the Best
[BestPOP, BestPrice] = elitist(mutPOP_ini, Cost_ini, NumPOP);


%Saving data for plotting
 Price_History(i) = BestPrice;
 Production_G1_History(i) = BestPOP(1,1);
 Production_G1_History(i) = BestPOP(2,1);
 Production_G1_History(i) = BestPOP(3,1);
 Production_G1_History(i) = BestPOP(4,1);

%newGen
matrixPOP = BestPOP;
end 


%% Results Display 





