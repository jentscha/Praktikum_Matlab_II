hFig = figure;


ax(1) = subplot(3,1,1);
title('Winkel phi1 und phi2 unter sinusförmiger Momentenanregung')
plot(M_Fcn.time, M_Fcn.Data,'b-',M_Matlab.time,M_Matlab.Data,'r--',M_S_Function.time,M_S_Function.Data,'k-.');

ylabel('Anregungsmoment M in Nm');
xlabel('Zeit t in s');
legend('Fcn-Block','MATLAB-Function','S-Function');

ax(2) = subplot(3,1,2);
plot(phi1_Fcn.time, phi1_Fcn.Data,'b-',phi1_Matlab.time,phi1_Matlab.Data,'r--',phi1_S_Function.time,phi1_S_Function.Data,'k-.');

ylabel('Winkel phi1 in rad');
xlabel('Zeit t in s');
legend('Fcn-Block','MATLAB-Function','S-Function');

ax(3) = subplot(3,1,3);
plot(phi2_Fcn.time, phi2_Fcn.Data,'b-',phi2_Matlab.time,phi2_Matlab.Data,'r--',phi2_S_Function.time,phi2_S_Function.Data,'k-.');
ylabel('Winkel phi2 in rad');
xlabel('Zeit t in s');
legend('Fcn-Block','MATLAB-Function','S-Function');

linkaxes(ax,'x')
print('-depsc', 'V1_Modell_output.eps');