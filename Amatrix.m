function [A] = Amatrix(  )
%AMATRIX Computes the A matrix


Bar_ref = 4;

%Input of line data 

X_12 = 0.08;
X_15 = 0.16;
X_23 = 0.20;
X_24 = 0.16;
X_34 = 0.20;
X_45 = 0.20;

X = [0.08, 0.16, 0.20, 0.16, 0.20, 0.20]; %X_12, X_15, X_23, X_24, X_34, X_45;

%Line Data Matriz
LineData = [0, 0.08, 0, 0, 0.16 ;  ...
  			0.08, 0, 0.2, 0.16, 0; ...
  			0, 0.2, 0, 0.2, 0; ...
  			0, 0.16, 0.2, 0, 0.2; ...
  			0.16, 0, 0, 0.2, 0 ];


%Computing B matrix
for i = 1:length(LineData)
	for j = 1:length(LineData)
		if LineData(i,j) == 0
			B(i,j) = 0;
		else 
			B(i,j)= - 1/LineData(i,j);
        end
        
       
    end
end 

B_sum = sum(B);

for i = 1:length(LineData)
	for j = 1:length(LineData)
         if i == j 
            B(i,j) = - B_sum(i);
        end 
    end
end


% Remove ref bar 
B(Bar_ref,:) = [];
B(:, Bar_ref) = [];

% Inverte B matrix
B_1 = inv (B);
ZerosCol = zeros(5,1);
ZerosLine = zeros(1,4);


% Compute A matrix
A = zeros(6,4);
%B_1 = [B_1(1,:); B_1(2,:); B_1(3,:); ZerosLine; B_1(4,:) ];
%B_1 = [B_1(:,1), B_1(:,2), B_1(:,3),ZerosCol, B_1(:,4);]

%Line 12
i = 1;
k = 2;
    for j=1:length(B_1)

     A(1,j) = (B_1(i,j)-B_1(k,j))/X(i);

    end
    
%Line 15
i = 1;
k = 4;
    for j=1:length(B_1)

     A(2,j) = (B_1(i,j)-B_1(k,j))/X(2);

    end
    
%Line 23
i = 2;
k = 3;
    for j=1:length(B_1)

     A(3,j) = (B_1(i,j)-B_1(k,j))/X(3);

    end    

%Line 24
i = 2;
    for j=1:length(B_1)

     A(4,j) = (B_1(i,j))/X(4);

    end
    
%Line 34
i = 3;
    for j=1:length(B_1)

     A(5,j) = (B_1(i,j))/X(5);

    end

%Line 34
i = 4;
    for j=1:length(B_1)

     A(6,j) = (-B_1(i,j))/X(6);

    end
      

end