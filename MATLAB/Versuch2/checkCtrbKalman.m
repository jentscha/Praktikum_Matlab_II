function [ S_s_Kalman] = checkCtrbKalman( A, B )
%CHECKCTRBKALMAN Summary of this function goes here
%   Detailed explanation goes here
n = length(A);

if (rank(A)==n)
    
else
    disp('Matrix A hat nicht vollen Rang')
end
S_s_Kalman = B;
for count = 1:n-1
    S_s_Kalman = [S_s_Kalman, A^count *B ];
end
end

