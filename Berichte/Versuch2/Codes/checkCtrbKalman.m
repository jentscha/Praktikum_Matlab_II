function checkCtrbKalman(A,B)
function [ S_s_Kalman] = checkCtrbKalman( A, B )

n = length(A);

if (rank(A)==n)
    
else
end

S_s_Kalman = B;
for count = 1:n-1
    S_s_Kalman = [S_s_Kalman, A^count *B ];
end
end

