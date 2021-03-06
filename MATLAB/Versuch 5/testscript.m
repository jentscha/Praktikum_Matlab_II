
stPendel = ladePendel();
Q = diag([1 1 1 1]);
R = 10;
AP = [pi 0 pi 0]';
x0 = [ 0 0 0 0]';
M_AP = 0;
 
% T = 0.8;
% stTraj = berechneTrajektorie( stPendel, Q, R, T );

%% Erstellung der Plots für 5.8
% Vektor der verschiedenen überführungszeiten 
Tplots = [0.65, 0.8, 1, 1.2, 1.4, 1.6, 1.9 ];

for ii = 1:length(Tplots)
    T = Tplots(ii);
    stTraj = berechneTrajektorie( stPendel, Q, R, T);
    hFig = figure;
    %title('Übergangszeit T=',num2str(ii));
    set(hFig, 'Position', [0, 0, 1400, 1000]);

    ax(1) = subplot(511);
    plot(stTraj.vT,stTraj.vU);
    ylabel('$M$/Nm','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    grid on;

    ax(2) = subplot(512);
    plot(stTraj.vT,stTraj.mX(1,:));
    ylabel('$\varphi_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    grid on;

    ax(3) = subplot(513);
    plot(stTraj.vT,stTraj.mX(2,:));
    ylabel('$\dot{\varphi}_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    grid on;

    ax(4) = subplot(514);
    plot(stTraj.vT,stTraj.mX(3,:));
    ylabel('$\varphi_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    grid on;

    ax(5) = subplot(515);
    plot(stTraj.vT,stTraj.mX(4,:));
    ylabel('$\dot{\varphi}_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    grid on;
    
    disp(['maximum M = ',num2str(max(abs(stTraj.vU)))]);
    
    linkaxes(ax,'x')
    print('-depsc', ['Sim_T_', strrep(num2str(T),'.','_'),'sec','.eps']);
    
end

%%
T = 1;
stTraj = berechneTrajektorie( stPendel, Q, R, T);
stPendelvec(1) = stPendel;
stPendelvec(2) = stPendel;
stPendelvec(2).l1 = 0.3;
stPendelvec(2).l2 = 0.3;
stPendelvec(2).Rp1 = 10e-4;
stPendelvec(2).Rp2 = 10e-5;
stPendelvec(3) = stPendel;
stPendelvec(3).m1 = 0.4;
stPendelvec(3).m2 = 0.4;
stPendelvec(4) = stPendel;
stPendelvec(4).g = 11;


for jj = 1:4
    simOut = runPendel(stPendelvec(jj), AP, x0, M_AP, stTraj, T + 1);
    simOut.mX = simOut.mX';
    
    hFig = figure;
    set(hFig, 'Position', [0, 0, 1400, 1000]);

    ax(1) = subplot(511);
    plot(stTraj.vT,stTraj.vU, simOut.vT, simOut.vU,'--');
    ylabel('$M$/Nm','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Steuerung','Simulation');
    grid on;

    ax(2) = subplot(512);
    plot(stTraj.vT,stTraj.mX(1,:),simOut.vT,simOut.mX(1,:),'--');
    ylabel('$\varphi_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Steuerung','Simulation');
    grid on;

    ax(3) = subplot(513);
    plot(stTraj.vT,stTraj.mX(2,:),simOut.vT,simOut.mX(2,:),'--');
    ylabel('$\dot{\varphi}_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Steuerung','Simulation');
    grid on;

    ax(4) = subplot(514);
    plot(stTraj.vT,stTraj.mX(3,:),simOut.vT,simOut.mX(3,:),'--');
    ylabel('$\varphi_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Steuerung','Simulation');
    grid on;

    ax(5) = subplot(515);
    plot(stTraj.vT,stTraj.mX(4,:),simOut.vT,simOut.mX(4,:),'--');
    ylabel('$\dot{\varphi}_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Steuerung','Simulation');
    grid on;

    linkaxes(ax,'x')
    print('-depsc', ['Sim_PendelData_',num2str(jj),'.eps']);
end




