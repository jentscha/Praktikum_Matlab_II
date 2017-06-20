function [ S_b_Kalman ] = checkObsvKalman( A, C )

n = length(A);

if rank(A) == n
    S_b_Kalman = C;
    for count = 1:n-1
        S_b_Kalman = [S_b_Kalman ; C * A^count];
    end
else    
    disp('Matrix A hat nicht vollen Rang');
end
end

