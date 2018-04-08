function [ clonePOP ] = Clone(matrixPOP)
% This function uses the command repmap and replicates the inicial matrix 
% matrixPOP into a new one clonePOP in the following way:
% matrixPOP = 1 0 0        clonePOP = 1 0 0 1 0 0
%             0 1 0                   0 1 0 0 1 0 
%             1 0 0                   0 0 1 0 0 1 

clonePOP = repmat(matrixPOP,1,2);

end

