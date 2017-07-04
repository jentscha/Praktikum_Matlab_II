function [ simOut ] = runPendel( stPendel, AP, x0, M_AP, stTraj, Tend )

stOptions = simset( 'SrcWorkspace', 'current');
sim('Modell_V5', Tend, stOptions);

simOut.vT = mZustand.Time;
simOut.mX = mZustand.Data;
simOut.vU = vInput.Data;

end

