function [ isCtrb_Gilbert ] = checkCtrbGilbert( A, B )

[T, lam] = eig(A);

if length(unique(diag(lam))) ~= length(A)
    disp('A hat mehrfache Eigenwerte');
end

Bd = T/B;
isCtrb_Gilbert = all(any(Bd,2));

if isCtrb_Gilbert
    disp('System ist steuerbar nach Gilbert');
else
    disp('System ist NICHT steuerbar nach Gilbert');
end
end

