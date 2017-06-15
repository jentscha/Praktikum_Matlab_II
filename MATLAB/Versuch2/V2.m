
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

% 2.3 Diagonalisierung
[A2D, B2D, C2D, D2D] = diagonalForm( A2, B2, C2, D2);

sys2 = ss(A2, B2, C2, D2);
sys2_canon = canon(sys2);

sys1 = ss(A1, B1, C1, D1);
sys1_canon = canon(sys1);

checkCtrbKalman(A1,B1);
ctrb(A1,B1);

checkObsvKalman(A1,C1);
obsv(A1,C1);

checkCtrbHautus(A3,B3);

