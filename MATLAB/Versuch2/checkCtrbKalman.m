function [ S_s_Kalman] = checkCtrbKalman( A, B )

n = length(A);

if (rank(A)==n)
    
else
    
    disp('Matrix A hat nicht vollen Rang')
end
<<<<<<< HEAD

=======
S_s_Kalman = B;
for count = 1:n-1
    S_s_Kalman = [S_s_Kalman, A^count *B ];
end
>>>>>>> 38b7d0387000b3368fdeffdc189b3b80731375e2
end

