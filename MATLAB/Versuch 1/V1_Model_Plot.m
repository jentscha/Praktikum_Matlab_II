% load('V1_Figure_Data.mat');
clear('ax');

hFig = figure;
set(hFig, 'Position', [100, 100, 1400, 1000]);

ax(1) = subplot(3,1,1);
title('Winkel $\varphi_1$ und $\varphi_2$ unter sinusförmiger Momentenanregung','Interpreter','latex')
plot(M_Fcn.time, M_Fcn.Data,'b-',M_Matlab.time,M_Matlab.Data,'r--',M_S_Function.time,M_S_Function.Data,'k-.');

ylabel('\textrm{M} / Nm','Interpreter','latex');
xlabel('\textrm{t / s}','Interpreter','latex');
legend('Fcn-Block','MATLAB-Function','S-Function','Location','SouthEast');
grid on
% xlim([0,2])
ax(2) = subplot(3,1,2);
plot(phi1_Fcn.time, phi1_Fcn.Data,'b-',phi1_Matlab.time,phi1_Matlab.Data,'r--',phi1_S_Function.time,phi1_S_Function.Data,'k-.');

ylabel('$\varphi_1$ /rad','Interpreter','latex');
xlabel('\textrm{t / s}','Interpreter','latex');
legend('Fcn-Block','MATLAB-Function','S-Function','Location','SouthEast');
grid on

ax(3) = subplot(3,1,3);
plot(phi2_Fcn.time, phi2_Fcn.Data,'b-',phi2_Matlab.time,phi2_Matlab.Data,'r--',phi2_S_Function.time,phi2_S_Function.Data,'k-.');
ylabel('$\varphi_2$ / rad','Interpreter','latex');
xlabel('\textrm{t / s}','Interpreter','latex');
legend('Fcn-Block','MATLAB-Function','S-Function','Location','SouthEast');
grid on

linkaxes(ax,'x')
print('-depsc', 'V1_Modell_output.eps');