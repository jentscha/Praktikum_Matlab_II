traj.Q = diag([1 1 1 1 ]);
traj.R = 10;

ctrl.Q = diag([1 1 1 1 ]);
ctrl.R = 1;

Tend = 1;
x0 = [0;0;0;0];

stPendel = ladePendel();
stTraj = berechneTrajektorie(stPendel, traj.Q, traj.R,Tend);
[vTK,mK] = berechneK(stTraj,ctrl.Q,ctrl.R);

simOut = runSimulation_V6(stPendel, stTraj, vTK, mK, x0, Tend+1);