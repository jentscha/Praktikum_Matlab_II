function [ vTK, mK ] = berechneK( stTraj, Q, R )
%BERECHNEK Summary of this function goes here
%   Detailed explanation goes here

[A, B, ~, ~] = linearisierung_XU(stTraj.mX(:,end), stTraj.vU(end));
n = length(A);

P_End = care(A, B, Q, R, zeros(size(B)), eye(n));
P_End = (P_End(:).')';

Pdot_check = RiccatiDGL(stTraj.vT(end), P_End, stTraj, Q, R);

[vTK,vPt] = ode45(@RiccatiDGL,flip(stTraj.vT), P_End);
vTK = flipud(vTK);
vPt = flipud(vPt);

for ii = 1:length(vTK)
%     xh = interp1(stTraj.vT,stTraj.mX',stTraj.vT(ii))';
%     uh = interp1(stTraj.vT,stTraj.vU,stTraj.vT(ii));
    xh = stTraj.mX(:,ii);
    uh = stTraj.vU(ii);
    [~,Bh,~,~] = linearisierung_XU(xh,uh);

    Ph = vPt(ii,:);
    Ph = reshape(Ph,n,n);
     
    mK(1:4,ii) = inv(R)*Bh'*Ph;
end
end

