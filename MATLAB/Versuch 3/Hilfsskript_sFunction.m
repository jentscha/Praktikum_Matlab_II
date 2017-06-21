stPendel = ladePendel;


modelPars(1).x0 = [-pi/3 0 0 0]';
modelPars(2).x0 = [-pi/3 0 pi 0]';

% modelPars.AP1 = [0;0;0;0];
% modelPars.AP2 = [pi;0;pi;0];
% modelPars.AP3 = [pi/2;0;pi;0];
modelPars(1).AP = [pi/3 0 0 0]';
modelPars(2).AP = [pi/3 0 pi 0]';

optPars(1).Q = diag([10 1 1 1]);
optPars(1).R = 1;
optPars(2).Q = diag([1 1 10 1]);
optPars(2).R = 1;
optPars(3).Q = diag([1 1 1 1]);
optPars(3).R = 10;

ii = 2;
jj = 1;

for ii = 1:2        
    %modelPars wählen
    AP = modelPars(ii).AP;
    % Anfangswerte
    x0 = modelPars(ii).x0;
    for jj = 1:3


        % Reglerentwurfsmatrizen
        Q = optPars(jj).Q;
        R = optPars(jj).R;

        [f, h] = nonlinear_model;

        [A,B,C,D, M_AP] = linearisierung(f, h, AP);

        K = berechneLQR(A,B,Q,R);

        [vT, mX, u] = runPendel(stPendel, AP, K, x0, M_AP);
        
        animierePendel(vT,mX,stPendel,[]);
        

        
        hFig = figure('Name',['model = ', num2str(ii),'; opt = ',num2str(jj)],'NumberTitle','off');
        set(hFig, 'Position', [0, 0, 1400, 1000]);
        
        ax(1) = subplot(311);
        plot(u.Time,u.Data,[vT(1),vT(end)],[M_AP,M_AP],'--k');
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
        
        linkaxes(ax,'x')
        print('-depsc', ['LQR_model_', num2str(ii),'_opt_',num2str(jj),'.eps']);
    end
end