%***********************************************************************%
%************************* State Estimation ****************************%
%****** Evolutionary Programing - Elitist + Autoadapting Sigma**********%
%******************* Diogo Martins & Ines Trigo ************************%
%***********************************************************************%
close all
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
NumPOP = 4;
tau = 0.1;
stop=0.001;
load_precent = 1.25; %Changes from 0.75 pu to 1.25pu
Line_Lim_precent = 0.5; %Changes from 0.5 to 1.2 pu
%_______________________________________________________________________
NumGenerator = length(Pmax);
Bar = 5;

Pc = [50;100;0;0;50]*load_precent;
P_load = sum(Pc);

Line_lim_ini = [48; 59; 89; 94; 59; 74]/100;
Line_Lim = Line_lim_ini * Line_Lim_precent*0.85;

A = Amatrix

%% Initial Population
[matrixPOP, matrixSigma] = GeraPop_Sig(Pmax, Pmin, NumPOP, P_load);


for initiatePOP=1:30
% Clone matrix
clonePOP=Clone(matrixPOP);
cloneSigma = Clone(matrixSigma);

%Mutate matrix
[mutPOP_ini, mutSigma_ini] = mutate_Sig(matrixPOP, clonePOP, matrixSigma, ...
    cloneSigma, tau, P_load);
Cost_ini = costCalc(a,b,c,mutPOP_ini, Pmax, Pmin);
CostLine_ini = LineInLimit(mutPOP_ini, Pc, A, Line_Lim, Cost_ini);

[BestPOP, BestSigma] = elitist_Sig(mutPOP_ini, mutSigma_ini, CostLine_ini, ...
    NumPOP);


%newGen
matrixPOP = BestPOP;
matrixSigma = BestSigma;
end 
 


for i=1:1000
    %Clone matrix
    clonePOP=Clone(matrixPOP);
    cloneSigma = Clone(matrixSigma);
    
    %Mutate matrix
    [mutPOP, mutSigma] = mutate_Sig(matrixPOP, clonePOP, matrixSigma, ...
        cloneSigma, tau, P_load);
    Cost = costCalc(a,b,c,mutPOP, Pmax, Pmin);
    CostLine = LineInLimit(mutPOP, Pc, A, Line_Lim, Cost);

    [BestPOP, BestSigma, BestPrice] = ...
        elitist_Sig(mutPOP, mutSigma, CostLine, NumPOP);
    
    %Saving data for plotting
    Price_History(i) = BestPrice;
    Sigma_History(i) = BestSigma(1);
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
    
    
    %NewGEn
    matrixPOP = BestPOP;
    matrixSigma = BestSigma;
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
plot(Sigma_History);
title('Evolution of Sigma in the best individual')
xlabel('Number of iterations')
ylabel('Sigma')

figure(3)
plot(Price_History);
title('Evolution of BestPrice in the best individual')
xlabel('Number of iterations')
ylabel('Price (Euro/MWh)')


figure(4)
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



