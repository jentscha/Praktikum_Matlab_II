function [ sim ] = runPendel( stPendel, AP, x0, M_AP, Tend )

stOptions = simset( 'SrcWorkspace', 'current');
sim('Modell_V5', Tend, stOptions);

sim.vT = mZustand.Time;
sim.mX = mZustand.Data;
sim.vU = vInput.Data;

end

