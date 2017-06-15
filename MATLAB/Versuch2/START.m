%Modell-Skript ausführen, Symbolische Variablen intialisieren, Output sind
%sind die zwei Differentialgleichungen

V1_Modell

%% Werte für die Konstanten für die Simulation

l1 = 0.2;
l2 = 0.2;
g = 9.81;
m1 = 0.3;
m2 = 0.3;
Rp1 = 1e-2;
Rp2 = 1e-3;

% Simulationsdauer hier eintragen:

T = 2;

%% Simulation der Modelle

sim('V1_Fcn_Block_Model');
sim('V1_Matlab_Function_Block_Model');
sim('V1_S_Function_Model');

%% Plot-Skript starten

V1_Model_Plot

disp('Skript ausgeführt!')
