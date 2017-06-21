%% Variablen
% Parameter
syms m1 l1 J1 m2 l2 J2 Rp1 Rp2 g t positive;

% Koordinaten
% syms x1 dx1 ddx1 y1 dy1 ddy1 phi1 dphi1 ddphi1...
%     x2 dx2 ddx2 y2 dy2 ddy2 phi2 dphi2 ddphi2 real;
syms phi1 dphi1 ddphi1 phi2 dphi2 ddphi2 real;

% Momente
syms M MR1 MR2 real;


x = [dphi1;phi1;dphi2;phi2];
u = M;

%% Konstanten

l1 = 0.2;
l2 = 0.2;
g = 9.81;
m1 = 0.3;
m2 = 0.3;
Rp1 = 1e-2;
Rp2 = 1e-3;


%% Zu ersetzende Größen

% Reibungen
MR1 = Rp1 * dphi1;
MR2 = Rp2 * (dphi2 - dphi1);

% Trägheintsmomente
J1 = 1 / 12 * m1 * l1^2;
J2 = 1 / 12 * m2 * l2^2;

% Pendelkoordinaten
x1 = l1 / 2 * sin(phi1);
dx1 = l1 / 2 * dphi1 * cos(phi1);
%ddx1 = l1 / 2 * (ddphi1 * cos(phi1) - dphi1^2 * sin(phi1));

y1 = -l1 / 2 * cos(phi1);
dy1 = l1 / 2 * dphi1 * sin(phi1);
%ddy1 = l1 / 2 * (ddphi1 * sin(phi1) + dphi1^2 * cos(phi1));

x2 =  x1 + l2 / 2 * sin(phi2);
dx2 = dx1 + l2 / 2 * dphi2 * cos(phi2);
%ddx2 = ddx1 + l2 / 2 * ((ddphi1 + ddphi2) * cos(phi1 + phi2) -...
%                                    (dphi1 + dphi2)^2 * sin(phi1 + phi2));

y2 = y1 - l2 / 2 * cos(phi2);
dy2 = dy1 + l2 / 2 * dphi2 * sin(phi2);
%ddy2 = 2* ddy1 + l2 / 2 * ((ddphi1 + ddphi2) * sin(phi1 + phi2) +...
%                                    (dphi1 + dphi2)^2 * cos(phi1 + phi2));
            

%% Solver output
ddphi1 = -(6*(4*Rp1*dphi1*l2 - 4*M*l2 + 6*Rp2*dphi1*l1*cos(phi1 - phi2) - 6*Rp2*dphi2*l1*cos(phi1 - phi2) + (3*g*l1*l2*m2*sin(phi1 - 2*phi2))/2 + (3*dphi1^2*l1^2*l2*m2*sin(2*phi1 - 2*phi2))/2 + 2*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 2*g*l1*l2*m1*sin(phi1) + (5*g*l1*l2*m2*sin(phi1))/2))/(l1^2*l2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));
 
 

 
ddphi2 = (6*(4*Rp2*dphi1*l1*m1 - 6*M*l2*m2*cos(phi1 - phi2) + 12*Rp2*dphi1*l1*m2 - 4*Rp2*dphi2*l1*m1 - 12*Rp2*dphi2*l1*m2 + 6*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 3*g*l1*l2*m2^2*sin(phi2) + (3*dphi2^2*l1*l2^2*m2^2*sin(2*phi1 - 2*phi2))/2 + 3*g*l1*l2*m2^2*sin(2*phi1 - phi2) + 6*Rp1*dphi1*l2*m2*cos(phi1 - phi2) + 2*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) - (g*l1*l2*m1*m2*sin(phi2))/2 + (3*g*l1*l2*m1*m2*sin(2*phi1 - phi2))/2))/(l1*l2^2*m2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));



%% Linearisierung

f_xu = [ddphi1;dphi1;ddphi2;dphi2];
h_xu = [phi1;phi2];
A = jacobian(f_xu,x);
B = jacobian(f_xu,u);
C = jacobian(h_xu,x);
D = jacobian(h_xu,u);

vars = [dphi1,phi1,dphi2,phi2];
vars_ap = [0,0,0,0];

A = subs(A,vars,vars_ap);
B = subs(B,vars,vars_ap);
C = subs(C,vars,vars_ap);
D = subs(D,vars,vars_ap);

A = double(A);
B = double(B);
C = double(C);
D = double(D);

sys = ss(A,B,C,D);
sys_canon = canon(sys);
%% Kalman

controllable = rank(ctrb(sys.a,sys.b));
observable = rank(obsv(sys.a,sys.c));
disp('Kalman');
disp(['Rang der Systemmatrix = ', num2str(rank(sys.a))]);
disp(['Rang der Steuerbarkeitsmatrix = ', num2str(controllable)]);
disp(['Rang der Beobachtbarkeitsmatrix = ', num2str(observable)]);


%% Gilbert

if all(any(sys_canon.b,2))
   disp('Das System ist steuerbar nach Gilbert');
else
    disp('Das System ist nicht steuerbar nach Gilbert');
end

if all(any(sys_canon.c,1))
   disp('Das System ist beobachtbar nach Gilbert');
else
    disp('Das System ist nicht beobachtbar nach Gilbert');
end


%% Hautus
eigenValues = eig(sys.a);

for count = 1:length(eigenValues)
    ranks(count) = rank(horzcat(eye(length(sys.a))*eigenValues[count] - sys.a, sys.b));
end






