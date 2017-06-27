[f_m, h_m] = nonlinear_model();

AP = [pi/3 0 0 0];
Q = diag([10 1 1 1]);
R = 1;
stPendel = ladePendel();
x0 =[-pi/3 0 0 0];

[A, B, C, D, M_AP] = linearisierung(f_m, h_m, AP);


[K, poleRK] = berechneLQR(A, B, Q, R);
L = berechneBeobachter(A,C,(5*real(poleRK)));
stObs.A = A;
stObs.B = B;
stObs.C = C;
stObs.L = L;
stObs.x0 = x0;


[vT, mX, mXobs] = runPendel(stPendel, AP, K, x0, M_AP, stObs);
%Animation des Pendels ohne avi-Video (Viertes Argument)
animierePendel(vT,mX,stPendel,[]);