stPendel = ladePendel;


startConds(1).x0 = [-pi/3 0 0 0]';
startConds(2).x0 = [-pi/3 0 pi 0]';

% Arbeitspunkt.AP1 = [0;0;0;0];
% Arbeitspunkt.AP2 = [pi;0;pi;0];
% Arbeitspunkt.AP3 = [pi/2;0;pi;0];
Arbeitspunkt(1).AP = [pi/3 0 0 0]';
Arbeitspunkt(2).AP = [pi/3 0 pi 0]';

optPars(1).Q = diag([10 1 1 1]);
optPars(1).R = 1;
optPars(2).Q = diag([1 1 10 1]);
optPars(2).R = 1;
optPars(3).Q = diag([1 1 1 1]);
optPars(3).R = 10;

ii = 2;
jj = 1;

%Arbeitspunkt w�hlen
AP = Arbeitspunkt(ii).AP;
% Anfangswerte
x0 = startConds(ii).x0;

% Reglerentwurfsmatrizen
Q = optPars(jj).Q;
R = optPars(jj).R;

[f, h] = nonlinear_model;

[A,B,C,D, M_AP] = linearisierung(f, h, AP);

K = berechneLQR(A,B,Q,R);

[vT, mX, u] = runPendel(stPendel, AP, K, x0, M_AP);
animierePendel(vT,mX,stPendel,[]);

figure;
subplot(311);
plot(u.Time,u.Data,[vT(1),vT(end)],[M_AP,M_AP],'--k');
ylabel('$M$/Nm','interpreter','latex');

subplot(312);
plot(vT,mX(:,1),[vT(1),vT(end)],[AP(1),AP(1)],'--k');
ylabel('$\varphi_1$/rad','interpreter','latex');

subplot(313);
plot(vT,mX(:,3),[vT(1),vT(end)],[AP(3),AP(3)],'--k');
ylabel('$\varphi_2$/rad','interpreter','latex');