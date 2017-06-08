function dx = fcn(x,M,p)
%#codegen

% Zustände definieren
phi1  = x(1);
dphi1 = x(2);
phi2  = x(3);
dphi2 = x(4);

% Parameter definieren
g = p(1);
m1 = p(2);
m2 = p(3);
l1 = p(4);
l2 = p(5);
Rp1 = p(6);
Rp2 = p(7);

% Bewegungsgleichungen des Modells
ddphi1 = -(6*(4*Rp1*dphi1*l2 - 4*M*l2 + 6*Rp2*dphi1*l1*cos(phi1 - phi2) - 6*Rp2*dphi2*l1*cos(phi1 - phi2) + (3*g*l1*l2*m2*sin(phi1 - 2*phi2))/2 + (3*dphi1^2*l1^2*l2*m2*sin(2*phi1 - 2*phi2))/2 + 2*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 2*g*l1*l2*m1*sin(phi1) + (5*g*l1*l2*m2*sin(phi1))/2))/(l1^2*l2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));

ddphi2 = (6*(4*Rp2*dphi1*l1*m1 - 6*M*l2*m2*cos(phi1 - phi2) + 12*Rp2*dphi1*l1*m2 - 4*Rp2*dphi2*l1*m1 - 12*Rp2*dphi2*l1*m2 + 6*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 3*g*l1*l2*m2^2*sin(phi2) + (3*dphi2^2*l1*l2^2*m2^2*sin(2*phi1 - 2*phi2))/2 + 3*g*l1*l2*m2^2*sin(2*phi1 - phi2) + 6*Rp1*dphi1*l2*m2*cos(phi1 - phi2) + 2*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) - (g*l1*l2*m1*m2*sin(phi2))/2 + (3*g*l1*l2*m1*m2*sin(2*phi1 - phi2))/2))/(l1*l2^2*m2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));

% Zustandsraummodell
dx = [dphi1; ddphi1; dphi2; ddphi2];