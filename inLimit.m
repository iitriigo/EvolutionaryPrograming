function [ Pop_ini ] = inLimit( NumPop, NumGenerators, Pop_ini, P_load)
%   InLimit  - Checks if a generator is operating inside its limits
%   Checks if a generator limits are respected. If not, adds ...
%   a penalization in the cost of the respective individual 


for n=1:NumPop
	GeneratedPower = 0;
	sum_test = 0;
	for i=1:NumGenerators
		GeneratedPower = GeneratedPower + Pop_ini(i,n);
	end

	if (GeneratedPower ~= P_load)
		for i=1:NumGenerators
			Pop_ini(i,n) = Pop_ini(i, n)*(P_load/GeneratedPower);
		end
	end
end

teste = sum(Pop_ini);
%disp (teste);
end

