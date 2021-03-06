hFig = figure;

ax(1) = subplot(3,1,1);
plot(M_Fcn.time, M_Fcn.Data,'b-',M_Matlab.time,M_Matlab.Data,'r--',M_S_Function.time,M_S_Function.Data,'k-.');

ylabel('M/Nm');
xlabel('t/s');
legend('Fcn-Block','MATLAB-Function','S-Function');

ax(2) = subplot(3,1,2);
plot(phi1_Fcn.time, phi1_Fcn.Data,'b-',phi1_Matlab.time,phi1_Matlab.Data,'r--',phi1_S_Function.time,phi1_S_Function.Data,'k-.');

ylabel('phi1/rad');
xlabel('t/s');
legend('Fcn-Block','MATLAB-Function','S-Function');

ax(3) = subplot(3,1,3);
plot(phi2_Fcn.time, phi2_Fcn.Data,'b-',phi2_Matlab.time,phi2_Matlab.Data,'r--',phi2_S_Function.time,phi2_S_Function.Data,'k-.');
ylabel('phi2/rad');
xlabel('t/s');
legend('Fcn-Block','MATLAB-Function','S-Function');

linkaxes(ax,'x')
print('-depsc', 'V1_Modell_output.eps');