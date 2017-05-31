clear
clc
%% Variablen
% Parameter
syms m1 l_1 J1 m2 l_2 J2 Rp1 Rp2 g t positive;

% Koordinaten
syms x1 dx1 ddx1 y1 dy1 ddy1 phi1 dphi1 ddphi1...
    x2 dx2 ddx2 y2 dy2 ddy2 phi2 dphi2 ddphi2 real;

% Momente
syms M MR1 MR2 real;

%% Zu ersetzende Größen

% Reibungen
MR1 = Rp1 * dphi1;
MR2 = Rp2 * (dphi2 - dphi1);

% Trägheintsmomente
J1 = 1 / 12 * m1 * l_1^2;
J2 = 1 / 12 * m2 * l_2^2;

% Pendelkoordinaten
x1 = l_1 / 2 * sin(phi1);
dx1 = l_1 / 2 * dphi1 * cos(phi1);
ddx1 = l_1 / 2 * (ddphi1 * cos(phi1) - dphi1^2 * sin(phi1));

y1 = -l_1 / 2 * cos(phi1);
dy1 = l_1 / 2 * dphi1 * sin(phi1);
ddy1 = l_1 / 2 * (ddphi1 * sin(phi1) + dphi1^2 * cos(phi1));

x2 = 2 * x1 + l_2 / 2 * sin(phi1+phi2);
dx2 = 2 * dx1 + l_2 / 2 * (dphi1 + dphi2) * cos(phi1 + phi2);
ddx2 = 2 * ddx1 + l_2 / 2 * ((ddphi1 + ddphi2) * cos(phi1 + phi2) -...
                                    (dphi1 + dphi2)^2 * sin(phi1 + phi2));

y2 = 2 * y1 - l_2 / 2 * cos(phi1 + phi2);
dy2 = 2 * dy1 + l_2 / 2 * (dphi1 + dphi2) * sin(phi1 + phi2);
ddy2 = 2* ddy1 + l_2 / 2 * ((ddphi1 + ddphi2) * sin(phi1 + phi2) +...
                                    (dphi1 + dphi2)^2 * cos(phi1 + phi2));
                                
%% Mechanik

T = 1/2 * m1 * (dx1^2 + dy1^2) + 1/2 * J1 * dphi1^2 +...
    1/2 * m2 * (dx2^2 + dy2^2) + 1/2 * J2 * dphi2^2;

U = g * (m1 * y1 + m2 * y2);

%Generalisierte Kräfte

Qphi1 = M - MR1;
Qphi2 = -MR2;

%Lagrangegleichung

L = T-U;

%% Herleitung der Ableitung nach generalisierter Koordinate

% dL/dphi1
L_phi1 = jacobian(L, phi1);

% dL/ddphi1
L_dphi1 = jacobian(L, dphi1);

% dL/dhpi2
L_phi2 = jacobian(L, phi2);

% dL/ddphi2
L_dphi2 = jacobian(L, dphi2);

% d(L_dphi1)/dt und d(L_dphi2)/dt

% Variablen ohne t durch Variablen mit t ersetzen
L_dphi1_t = subs(L_dphi1,{phi1,dphi1,phi2,dphi2},...
    {'phi1(t)', 'dphi1(t)', 'phi2(t)', 'dphi2(t)'});

L_dphi2_t = subs(L_dphi2,{phi1,dphi1,phi2,dphi2},...
    {'phi1(t)', 'dphi1(t)', 'phi2(t)', 'dphi2(t)'});

%Berechnung der Zeitableitung
dL_dphi1_t = diff(L_dphi1_t,t);
dL_dphi2_t = diff(L_dphi2_t,t);

%Variablen mit t
Var_t = {'phi1(t)', 'dphi1(t)', 'diff(phi1(t),t)', 'diff(dphi1(t),t)',...
        'phi2(t)', 'dphi2(t)', 'diff(phi2(t),t)', 'diff(dphi2(t),t)'};

%Variablen ohne t 
Var_ot = {phi1, dphi1, dphi1, ddphi1, phi2, dphi2, dphi2, ddphi2};

dL_dphi1_t = subs(dL_dphi1_t, Var_t, Var_ot);
dL_dphi2_t = subs(dL_dphi2_t, Var_t, Var_ot);

%% Berchnung der LAGRANGEschen Gleichungen

Sol = solve([dL_dphi1_t - L_phi1 == Qphi1, dL_dphi2_t - L_phi2 == Qphi2],...
            [ddphi1,ddphi2]);
