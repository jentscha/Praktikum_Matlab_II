function [ S_s_Kalman] = checkCtrbKalman( A, B )

n = length(A);

if (rank(A)==n)
    S_s_Kalman = B;
    for count = 1:n-1
        S_s_Kalman = [S_s_Kalman, A^count *B ];
    end
else
    
    disp('Matrix A hat nicht vollen Rang')
end

end

