
%2.1 linearisierung
[f,h] = nonlinear_model;

AP1 = [0;0;0;0];
AP2 = [pi;0;pi;0];
AP3 = [pi/2;0;pi;0];

[A1,B1,C1,D1] = linearisierung(f,h,AP1);
[A2,B2,C2,D2] = linearisierung(f,h,AP2);
[A3,B3,C3,D3] = linearisierung(f,h,AP3);

%2.2 Eigenwerte
lam1 = eig(A1);
lam2 = eig(A2);
lam3 = eig(A3);

%% 2.3 Diagonalisierung
%[A1D,B1D,C1D,D1D] = diagonalForm(A1,B1,C1,D1);
[A2D,B2D,C2D,D2D] = diagonalForm(A2,B2,C2,D2);
%[A3D,B3D,C3D,D3D] = diagonalForm(A3,B3,C3,D3);

sys2 = ss(A2, B2, C2, D2);
sys2_canon = canon(sys2);

sys1 = ss(A1, B1, C1, D1);
sys1_canon = canon(sys1);

<<<<<<< HEAD
%% Kalman AP1, AP2, AP3
checkCtrbKalman(A1,B1)
ctrb(A1,B1)
checkObsvKalman(A1,C1)
obsv(A1,C1)

%% Kalman AP2
checkCtrbKalman(A2,B2)
ctrb(A2,B2)
checkObsvKalman(A2,C2)
obsv(A2,C2)

%% Kalman AP3
checkCtrbKalman(A3,B3);
ctrb(A3,B3);
checkObsvKalman(A3,C3);
obsv(A3,C3);

%% Gilbert AP1, AP2, AP3

checkCtrbGilbert(A1D,B1D);
checkObsvGilbert(A1D,B1D);
checkCtrbGilbert(A2D,B2D);
checkObsvGilbert(A2D,B2D);
checkCtrbGilbert(A3D,B3D);
checkObsvGilbert(A3D,B3D);


%% Hautus AP1, AP2, AP3
checkCtrbHautus(A1D,B1D);
checkObsvHautus(A1D,B1D);
checkCtrbHautus(A2D,B2D);
checkObsvHautus(A2D,B2D);
checkCtrbHautus(A3D,B3D);
checkObsvHautus(A3D,B3D);
=======
%% 
checkCtrbKalman(A1,B1);
ctrb(A1,B1);
>>>>>>> 38b7d0387000b3368fdeffdc189b3b80731375e2



