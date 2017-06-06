


%% Solver output
ddphi1 = -(6*(4*Rp1*dphi1*l2 - 4*M*l2 + 6*Rp2*dphi1*l1*cos(phi1 - phi2) - 6*Rp2*dphi2*l1*cos(phi1 - phi2) + (3*g*l1*l2*m2*sin(phi1 - 2*phi2))/2 + (3*dphi1^2*l1^2*l2*m2*sin(2*phi1 - 2*phi2))/2 + 2*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 2*g*l1*l2*m1*sin(phi1) + (5*g*l1*l2*m2*sin(phi1))/2))/(l1^2*l2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));
 
 

 
ddphi2 = (6*(4*Rp2*dphi1*l1*m1 - 6*M*l2*m2*cos(phi1 - phi2) + 12*Rp2*dphi1*l1*m2 - 4*Rp2*dphi2*l1*m1 - 12*Rp2*dphi2*l1*m2 + 6*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 3*g*l1*l2*m2^2*sin(phi2) + (3*dphi2^2*l1*l2^2*m2^2*sin(2*phi1 - 2*phi2))/2 + 3*g*l1*l2*m2^2*sin(2*phi1 - phi2) + 6*Rp1*dphi1*l2*m2*cos(phi1 - phi2) + 2*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) - (g*l1*l2*m1*m2*sin(phi2))/2 + (3*g*l1*l2*m1*m2*sin(2*phi1 - phi2))/2))/(l1*l2^2*m2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));
 

%% Für fcn block

ddphi1 = -(6*(4*Rp1*u(2)*l2 - 4*u(1)*l2 + 6*Rp2*u(2)*l1*cos(u(3) - u(4)) - 6*Rp2*u(5)*l1*cos(u(3) - u(4)) + (3*g*l1*l2*m2*sin(u(3) - 2*u(4)))/2 + (3*u(2)^2*l1^2*l2*m2*sin(2*u(3) - 2*u(4)))/2 + 2*u(5)^2*l1*l2^2*m2*sin(u(3) - u(4)) + 2*g*l1*l2*m1*sin(u(3)) + (5*g*l1*l2*m2*sin(u(3)))/2))/(l1^2*l2*(8*m1 + 15*m2 - 9*m2*cos(2*u(3) - 2*u(4))));
 
 

 
ddphi2 = (6*(4*Rp2*u(2)*l1*m1 - 6*u(1)*l2*m2*cos(u(3) - u(4)) + 12*Rp2*u(2)*l1*m2 - 4*Rp2*u(5)*l1*m1 - 12*Rp2*u(5)*l1*m2 + 6*u(2)^2*l1^2*l2*m2^2*sin(u(3) - u(4)) - 3*g*l1*l2*m2^2*sin(u(4)) + (3*u(5)^2*l1*l2^2*m2^2*sin(2*u(3) - 2*u(4)))/2 + 3*g*l1*l2*m2^2*sin(2*u(3) - u(4)) + 6*Rp1*u(2)*l2*m2*cos(u(3) - u(4)) + 2*u(2)^2*l1^2*l2*m1*m2*sin(u(3) - u(4)) - (g*l1*l2*m1*m2*sin(u(4)))/2 + (3*g*l1*l2*m1*m2*sin(2*u(3) - u(4)))/2))/(l1*l2^2*m2*(8*m1 + 15*m2 - 9*m2*cos(2*u(3) - 2*u(4))));
 

%% Konstanten

l1 = 0.2;
l2 = 0.2;
g = 9.81;
m1 = 0.3;
m2 = 0.3;
Rp1 = 1e-2;
Rp2 = 1e-3;