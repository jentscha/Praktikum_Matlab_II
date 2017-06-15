function [ isCtrb_Gilbert ] = checkCtrbGilbert( A, B )
%CHECKCTRBGILBERT Summary of this function goes here
%   Detailed explanation goes here
[T, lam] = eig(A);

if length(unique(diag(lam))) ~= length(A)
    disp('A hat mehrfache Eigenwerte');
end

Bd = T/B;
isCtrb = all(any(Bd,2));

if isCtrb
    disp('System ist steuerbar nach Gilbert');
else
    disp('System ist NICHT steuerbar nach Gilbert');
end
end

