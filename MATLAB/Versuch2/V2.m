

%2.1 linearisierung
 l1 = 0.2;
l2 = 0.2;
g = 9.81;
m1 = 0.3;
m2 = 0.3;
Rp1 = 1e-2;
Rp2 = 1e-3;

[f,h] = nonlinear_model_friction;

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
[A1D,B1D,C1D,D1D] = diagonalForm(A1,B1,C1,D1);
[A2D,B2D,C2D,D2D] = diagonalForm(A2,B2,C2,D2);
[A3D,B3D,C3D,D3D] = diagonalForm(A3,B3,C3,D3);

sys2 = ss(A2, B2, C2, D2);
sys2_canon = canon(sys2);

sys1 = ss(A1, B1, C1, D1);
sys1_canon = canon(sys1);

%% Kalman AP1
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
checkObsvGilbert(A1D,C1D);
checkCtrbGilbert(A2D,B2D);
checkObsvGilbert(A2D,C2D);
%checkCtrbGilbert(A3D,B3D);
%checkObsvGilbert(A3D,C3D);


%% Hautus AP1, AP2, AP3
checkCtrbHautus(A1,B1);
checkObsvHautus(A1,C1);
checkCtrbHautus(A2,B2);
checkObsvHautus(A2,C2);
checkCtrbHautus(A3,B3);
checkObsvHautus(A3,C3);




