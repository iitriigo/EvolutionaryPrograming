%***********************************************************************%
%********************** State Estimation - A1 **************************%
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


%Elements to change ____________________________________________________
P_load = 160;
NumPOP = 2;
tau = 0.5;
stop=0.001;
%_______________________________________________________________________
NumGenerator = length(Pmax);


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

[BestPOP, BestSigma] = elitist_Sig(mutPOP_ini, mutSigma_ini, Cost_ini, NumPOP);

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

    [BestPOP, BestSigma, BestPrice] = ...
        elitist_Sig(mutPOP, mutSigma, Cost, NumPOP);
    
    %Saving data for plotting
    Price_History(i) = BestPrice;
    Sigma_History(i) = BestSigma(1);
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
    
    
    %New Generation
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

