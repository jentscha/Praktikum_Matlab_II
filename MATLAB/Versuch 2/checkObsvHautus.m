function [ isObsv_Hautus ] = checkObsvHautus( A,C )
%CHECKOBSVHAUTUS Summary of this function goes here
%   Detailed explanation goes here

lam = eig(A);
isObsv_Hautus = 0;
for count = 1:length(lam)
    ranks(count) = rank(vertcat(eye(length(A))*lam(count) - A, C));
end

if all(ranks == length(A))
    disp('System ist beobachtbar nach Hautus');
    isObsv_Hautus = 1;
else
    disp('System ist NICHT beobachtbar nach Hautus');
end

end