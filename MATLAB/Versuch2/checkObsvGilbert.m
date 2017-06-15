function [ isObsv_Gilbert ] = checkObsvGilbert( A, C )
%CHECKOBSVGILBERT Summary of this function goes here
%   Detailed explanation goes here
[T, lam] = eig(A);

if length(unique(diag(lam))) ~= length(A)
    disp('A hat mehrfache Eigenwerte');
end

Cd = C*T;
isObsv = all(any(Cd,1));

if isObsv
    disp('System ist beobachtbar nach Gilbert');
else
    disp('System ist NICHT beobachtbar nach Gilbert');
end
end

