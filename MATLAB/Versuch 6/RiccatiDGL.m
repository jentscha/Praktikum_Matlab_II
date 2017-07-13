function vPdot = RiccatiDGL( t, vP, stTraj, Q, R )
%RICCATIDGL Summary of this function goes here
%   Detailed explanation goes here

persistent RiccatiCache;

if nargin > 2
    RiccatiCache.stTraj = stTraj;
    RiccatiCache.Q = Q;
    RiccatiCache.R = R;
    
elseif isempty(RiccatiCache)
    disp('RiccatiDGL was not initialized');
    
else
    stTraj = RiccatiCache.stTraj;
    Q = RiccatiCache.Q;
    R = RiccatiCache.R;
end

Upol = interp1(stTraj.vT,stTraj.vU,t);
Xpol = interp1(stTraj.vT,stTraj.mX',t)';


[A,B,~,~] = linearisierung_XU(Xpol,Upol);

n = size(A,1);
P = reshape(vP,n,n);

vPdot = (P*B*(R^-1)*B'*P)-(P*A)-(A'*P)-Q;

vPdot = (vPdot(:).')';

end

