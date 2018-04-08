function [Popini] = GeraPop(Pmax, Pmin, NumPop,P_load)
%GeraPOP - Creates the 1st population
%   Generates the 1st population using the lower limit off production ...
%   to which is added a random number 


NumGenerators = 4;

for n=1:NumPop
    for i=1:NumGenerators
        Generator(i,n)=Pmin(1,i)+randn*40;
        Pop_ini(i,n)= Generator(i,n);
    end
end

%% Assure that production and load are igual

Popini = inLimit(NumPop, NumGenerators, Pop_ini, P_load);


