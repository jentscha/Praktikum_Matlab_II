function [ A, B, C, D] = linearisierung_XU( x,u )
%LINEARISIERUNG Summary of this function goes here
%   Detailed explanation goes here
syms phi1 phi2 dphi1 dphi2 ddphi1 ddphi2 M;
[f,h] = nonlinear_model();

z = [phi1;dphi1;phi2;dphi2];
u_z = M;
% 
% % f_M_AP = subs(f(2),z,x);
% % 
% % M_AP = solve(f_M_AP == 0 , M);

A = jacobian(f,z);
B = jacobian(f,u_z);
C = jacobian(h,z);
D = jacobian(h,u_z);

A = subs(A,[z.',u_z],[x.',u]);
B = subs(B,[z.',u_z],[x.',u]);
C = subs(C,[z.',u_z],[x.',u]);
D = subs(D,[z.',u_z],[x.',u]);


A = double(A);
B = double(B);
C = double(C);
D = double(D);

end

