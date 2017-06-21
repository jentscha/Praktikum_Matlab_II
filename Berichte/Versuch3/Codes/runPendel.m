function [ vT, mX, u ] = runPendel( stPendel, AP, K, x0, M_AP )

vT = 'error';
mX = 'error';

Tend = 10;
stOptions = simset( 'SrcWorkspace', 'current');
sim('Modell_V3', Tend, stOptions);

vT = mZustand.Time;
mX = mZustand.Data;
u.Data = vInput.Data;
u.Time = vInput.Time;
end

