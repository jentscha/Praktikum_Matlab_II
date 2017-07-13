function [ vTK, mK ] = berechneK( stTraj, Q, R )
%BERECHNEK Summary of this function goes here
%   Detailed explanation goes here

[A, B, ~, ~] = linearisierung_XU(stTraj.mX(:,end), stTraj.vU(end));
n = length(A);

P_End = care(A, B, Q, R, zeros(size(B)), eye(n));
P_End = P_End(:).';

RiccatiDGL(stTraj.vT(end), P_End, stTraj, Q, R);

[vTK,vPt] = ode45(@RiccatiDGL,flip(stTraj.vT), P_End);
vTK = flipud(vTK);
vPt = flipud(vPt)';

P = reshape(vPt,n,size(vPt,2)*(size(vPt,1)/n));

mK = inv(R)*B'*P;
mK = reshape(mK,n,size(mK,2)/n);
end

