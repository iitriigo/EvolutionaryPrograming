function [Popini, Sigmaini] = GeraPop_Sig(Pmax, Pmin, NumPop,P_load)
%GeraPOP - Creates the 1st population and initializes sigma to zero.
%   Generates the 1st population using the lower limit off production ...
%   to which is added a random number 
NumGeradores = 4;

for n=1:NumPop
    for i=1:NumGeradores
        Gerador(i,n)=Pmin(1,i)+randn*40;
        Pop_ini(i,n)= Gerador(i,n);
    end
    Sigmaini(n) = 0;
end

%% Assure that production and load are igual

Popini = inLimit(NumPop, NumGeradores, Pop_ini, P_load);


