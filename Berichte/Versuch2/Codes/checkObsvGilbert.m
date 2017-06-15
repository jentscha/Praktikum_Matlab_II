function [ isObsv_Gilbert ] = checkObsvGilbert( A, C )

[T, lam] = eig(A);

if length(unique(diag(lam))) ~= length(A)
    disp('A hat mehrfache Eigenwerte');
end

Cd = C*T;
isObsv_Gilbert = all(any(Cd,1));

if isObsv_Gilbert
    disp('System ist beobachtbar nach Gilbert');
else
    disp('System ist NICHT beobachtbar nach Gilbert');
end
end

