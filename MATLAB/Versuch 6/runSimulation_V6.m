function [ simOut ] = runSimulation_V6( stPendel, stTraj, vTK, mK, x0,Tend )

stOptions = simset( 'SrcWorkspace', 'current');
sim('Modell_V6', Tend, stOptions);

simOut.vT = mZustand.Time;
simOut.mX = mZustand.Data;
simOut.vU = vInput.Data;

end

