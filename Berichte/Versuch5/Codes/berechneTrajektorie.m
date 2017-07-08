function [ stTraj ] = berechneTrajektorie( stPendel, Q, R, T )
%BERECHNETRAJEKTORIE Summary of this function goes here
%   Detailed explanation goes here

RandwertproblemDGLhandle = @(t,x) RandwertproblemDGL(t,x,stPendel,Q,R);

intervals = 1000;

solinit.x = linspace(0,T,intervals);
solinit.y = [linspace(0,pi,intervals);
            zeros(1,intervals);
            linspace(0,pi,intervals);
            zeros(1,intervals);
            zeros(1,intervals);
            zeros(1,intervals);
            zeros(1,intervals);
            zeros(1,intervals);];
        
RelTol = 1e-10;
bvp4cOptions = bvpset('RelTol',RelTol,'Stats','on');

for ii = 1:15
    sol = bvp4c(RandwertproblemDGLhandle,@RandwertproblemRB,solinit,bvp4cOptions);
    solinit = sol;
    if isfield(sol,'stats')
        break
    end
end

[f, h] = nonlinear_model;


dfdu_symb = jacobian(f,sym('M'));


dfdu = double(subs(dfdu_symb,{sym('phi1'),sym('phi2')},{sol.y(1,:),sol.y(3,:)}));

stTraj.T = T;
stTraj.vT = sol.x;
stTraj.vU = diag(- R^(-1)* dfdu' * sol.y(5:8,:))';
% vU = diag(stTraj.vU);
stTraj.mX = sol.y(1:4,:);

end

