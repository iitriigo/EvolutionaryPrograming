function [ Pop_ini ] = inLimit( NumPop, NumGeradores, Pop_ini, P_load)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for n=1:NumPop
	GeneratedPower = 0;
	sum_test = 0;
	for i=1:NumGeradores
		GeneratedPower = GeneratedPower + Pop_ini(i,n);
	end

	if (GeneratedPower ~= P_load)
		for i=1:NumGeradores
			Pop_ini(i,n) = Pop_ini(i, n)*(P_load/GeneratedPower);
		end
	end
end

teste = sum(Pop_ini);
%disp (teste);
end

