%Erstellung der Plots
hFig = figure('Name',['model = ', num2str(ii),'; opt = ',num2str(jj)],'NumberTitle','off');
set(hFig, 'Position', [0, 0, 1400, 1000]);

ax(1) = subplot(311);
plot(vT,u,[vT(1),vT(end)],[M_AP,M_AP],'--k');
ylabel('$M$/Nm','interpreter','latex');
xlabel('t/s','interpreter','latex');
grid on;

ax(2) = subplot(312);
plot(vT,mX(:,1),[vT(1),vT(end)],[AP(1),AP(1)],'--k');
ylabel('$\varphi_1$/rad','interpreter','latex');
xlabel('t/s','interpreter','latex');
grid on;

ax(3) = subplot(313);
plot(vT,mX(:,3),[vT(1),vT(end)],[AP(3),AP(3)],'--k');
ylabel('$\varphi_2$/rad','interpreter','latex');
xlabel('t/s','interpreter','latex');
grid on;

linkaxes(ax,'x');
print('-depsc', ['LQR_model_', num2str(ii),'_opt_',num2str(jj),'.eps']);