function [ isCtrb_Hautus ] = checkCtrbHautus( A,B )
%CHECKCTRBHAUTUS Summary of this function goes here
%   Detailed explanation goes here

lam = eig(A);
isCtrb_Hautus = 0;
for count = 1:length(lam)
    ranks(count) = rank(horzcat(eye(length(A))*lam(count) - A, B));
end

if all(ranks == length(A))
    disp('System ist steuerbar nach Hautus');
    isCtrb_Hautus = 1;
else
    disp('System ist NICHT steuerbar nach Hautus');
end

end

