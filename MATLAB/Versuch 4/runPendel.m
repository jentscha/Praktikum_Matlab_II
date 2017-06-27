function [ vT, mX, mXobs ] = runPendel( stPendel, AP, K, x0, M_AP, stObs )

vT = 'error';
mX = 'error';
mXobs = [];

if ~isempty(stObs)
    stObs.switch = true;
else
    stObs.switch = false;
    stObs.A = eye(4);
    stObs.B = [0;1;0;1];
    stObs.C = [1 0 0 0; 0 0 1 0];
    stObs.L = stObs.C';
    stObs.x0 = [0 0 0 0];
end

Tend = 10;
stOptions = simset( 'SrcWorkspace', 'current');
sim('Modell_V4', Tend, stOptions);

vT = mZustand.Time;
mX = mZustand.Data;
mXobs = mBeobacht.Data;
% u.Data = vInput.Data;
% u.Time = vInput.Time;
end

