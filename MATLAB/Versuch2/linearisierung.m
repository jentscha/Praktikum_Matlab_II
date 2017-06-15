function [ A, B, C, D] = linearisierung( f, h, AP )
%LINEARISIERUNG Summary of this function goes here
%   Detailed explanation goes here
syms phi1 phi2 dphi1 dphi2 ddphi1 ddphi2 M;

x = [phi1;dphi1;phi2;dphi2];
u = M;

f_M_AP = subs(f(2),x,AP);

M_AP = solve(f_M_AP == 0 , M);

A = jacobian(f,x);
B = jacobian(f,u);
C = jacobian(h,x);
D = jacobian(h,u);

A = subs(A,[x,u],[AP,M_AP]);
B = subs(B,[x,u],[AP,M_AP]);
C = subs(C,[x,u],[AP,M_AP]);
D = subs(D,[x,u],[AP,M_AP]);


A = double(A);
B = double(B);
C = double(C);
D = double(D);

end

