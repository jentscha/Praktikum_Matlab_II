function [ AD, BD, CD, DD ] = diagonalForm( A, B, C, D )

% lamA = eig(A);

[V, Deig] = eig(A);

if rank(V)==length(V)
    V_inv = inv(V);

    AD = Deig;
    BD = V_inv*B;
    CD = C*V;
    DD = D;
else
    disp('Matrix A ist nicht diagonalähnlich!')
end

end

