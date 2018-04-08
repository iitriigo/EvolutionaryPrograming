function [ CostLines, P_line ] = LineInLimit(POP, P_l, Amatrix, ...
    Line_Lim, Cost_ini)

% LineInLimit  - Checks if a line is operating inside its limits
%   These function computes power flow for each system line using the ...
%   A matrix and then checks if line limits are respected. If not, adds ...
%   a penalization in the cost of the respective individual 


% Variable initialization 
M = 10000;
NumberOfLines = 6;
A =[Amatrix(:,1), Amatrix(:,2), Amatrix(:,3), [0;0;0;0;0;0], Amatrix(:,4)];

% Compute PF each system line
for j = 1:length(POP)
  P_gen(:,j) = [0; 0; (POP(1,j)+ POP(2,j)); (POP(3,j)+ POP(4,j)); 0];
  P_in(:,j) = P_gen(:,j) - P_l(:);
  
  P_line12(1,j) = A(1,:)*(P_in(:,j)/100);
  P_line15(1,j) = A(2,:)*(P_in(:,j)/100);
  P_line23(1,j) = A(3,:)*(P_in(:,j)/100);
  P_line24(1,j) = A(4,:)*(P_in(:,j)/100);
  P_line34(1,j) = A(5,:)*(P_in(:,j)/100);
  P_line45(1,j) = A(6,:)*(P_in(:,j)/100);
  
  P_line(1,j) = P_line12(1,j);
  P_line(2,j) = P_line15(1,j);
  P_line(3,j) = P_line23(1,j);
  P_line(4,j) = P_line24(1,j);
  P_line(5,j) = P_line34(1,j);
  P_line(6,j) = P_line45(1,j); 
end
 

for j=1:length(POP)
    for i = 1:NumberOfLines
       if (abs(P_line(i,j)) > Line_Lim(i))
         CostLines(j) = Cost_ini(j) + M*(abs(P_line(i,j) - Line_Lim(i)))^2;
       end 
    end 
end 



end

