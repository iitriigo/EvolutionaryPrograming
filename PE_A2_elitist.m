%***********************************************************************%
%*********************** State Estimation - A2 *************************%
%****************** Evolutionary Programing - Elitist ******************%
%********************** Diogo Martins & Ines Trigo *********************%
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
NumPOP = 4;
simga = 1;
stop=0.0001;
load_precent = 1.25; %changes from 0.75pu to 1.25
Line_Lim_precent = 0.5; %changes from 0.5 to 1.2
%_______________________________________________________________________
%Network Data
NumGenerator = length(Pmax);
Bar = 5;

Pc = [50;100;0;0;50]*load_precent;
P_load = sum(Pc);

Line_lim_ini = [48; 59; 89; 94; 59; 74]/100;
Line_Lim = Line_lim_ini*Line_Lim_precent*0.85;

A = Amatrix

%% Initial Population
matrixPOP = GeraPop(Pmax, Pmin, NumPOP, P_load );


for initiatePOP=1:30

% Clone matrix
clonePOP=Clone(matrixPOP);

% Mutate
mutPOP_ini=mutate(matrixPOP, clonePOP, simga,P_load);
Cost_ini = costCalc(a,b,c,mutPOP_ini, Pmax, Pmin);
CostLine = LineInLimit(mutPOP_ini, Pc,A, Line_Lim, Cost_ini);

%Choose the Best
BestPOP = elitist(mutPOP_ini, CostLine, NumPOP);

%newGen
matrixPOP = BestPOP;
end 


for i=1:1000

% Clone matrix
clonePOP=Clone(matrixPOP);

% Mutate
mutPOP_ini=mutate(matrixPOP, clonePOP, simga,P_load);
Cost_ini = costCalc(a,b,c,mutPOP_ini, Pmax, Pmin);
CostLine = LineInLimit(mutPOP_ini, Pc,A, Line_Lim, Cost_ini);

%Choose the Best
[BestPOP, BestPrice] = elitist(mutPOP_ini, CostLine, NumPOP);


%Saving data for plotting
 Price_History(i) = BestPrice;
 Production_G31_History(i) = BestPOP(1,1);
 Production_G32_History(i) = BestPOP(2,1);
 Production_G41_History(i) = BestPOP(3,1);
 Production_G42_History(i) = BestPOP(4,1);
 
 [Cost_final, P_line] = LineInLimit(BestPOP, Pc, A, Line_Lim, CostLine);
 
 Line12_History(i) = P_line(1,1)*100;
 Line15_History(i) = P_line(2,1)*100;
 Line23_History(i) = P_line(3,1)*100;
 Line24_History(i) = P_line(4,1)*100;
 Line34_History(i) = P_line(5,1)*100;
 Line45_History(i) = P_line(6,1)*100;
 


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

figure(3)
plot(Line12_History);
hold on
plot(Line15_History);
hold on
plot(Line23_History);
hold on
plot(Line24_History);
hold on
plot(Line34_History);
hold on
plot(Line45_History);
title('Evolution of power flow in system lines')
xlabel('Number of iterations')
ylabel('PF (MW)')
legend('L12','L15','L23','L24', 'L34', 'L45')



