function [Popini] = GeraPop(Pmax, Pmin, NumPop,P_load)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

NumGeradores = 4;

for n=1:NumPop
    for i=1:NumGeradores
        Gerador(i,n)=Pmin(1,i)+rand*40;
        Pop_ini(i,n)= Gerador(i,n);
    end
end

%% Assure that production and load are igual

Popini = inLimit(NumPop, NumGeradores, Pop_ini, P_load);


