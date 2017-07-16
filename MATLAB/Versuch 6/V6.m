traj.Q = diag([1 1 1 1 ]);
traj.R = 10;

ctrl.Q = diag([1 1 1 1 ]);
ctrl.R = 1;

Tend = 1.2;
x0 = [0;0;0;0];

stPendel = ladePendel();
stTraj = berechneTrajektorie(stPendel, traj.Q, traj.R,Tend);

%%
[vTK,mK] = berechneK(stTraj,ctrl.Q,ctrl.R);

%% mit Trajektorienfolgeregelung


%Ohne Parameteränderung
stPendel = ladePendel();
simOutR1 = runSimulation_V6(stPendel, stTraj, vTK, mK, x0, Tend+1);

% 5% kürzeres zweites Pendel
stPendel.l2 = 0.95*stPendel.l2;
simOutR2 = runSimulation_V6(stPendel, stTraj, vTK, mK, x0, Tend+1);

% 5% schwerers erstes Pendel
stPendel = ladePendel();
stPendel.m1 = stPendel.m1*1.05;
simOutR3 = runSimulation_V6(stPendel, stTraj, vTK, mK, x0, Tend+1);

%% ohne Trajektorienfolgeregelung (manuellen Switch umschalten und Run Section)

%Ohne Parameteränderung
stPendel = ladePendel();
simOutS1 = runSimulation_V6(stPendel, stTraj, vTK, mK, x0, Tend+1);

% 5% kürzeres zweites Pendel
stPendel.l2 = 0.95*stPendel.l2;
simOutS2 = runSimulation_V6(stPendel, stTraj, vTK, mK, x0, Tend+1);

% 5% schwerers erstes Pendel
stPendel = ladePendel();
stPendel.m1 = stPendel.m1*1.05;
simOutS3 = runSimulation_V6(stPendel, stTraj, vTK, mK, x0, Tend+1);

%% Plots der Ergebnisse

% ohne Parameteränderung
    hFig = figure;
    set(hFig, 'Position', [0, 0, 1400, 1000]);

    ax(1) = subplot(511);
    plot(simOutR1.vT, simOutR1.vU, '-.r', simOutS1.vT, simOutS1.vU, '--k');
    ylabel('$M$/Nm','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(2) = subplot(512);
    plot(simOutR1.vT,simOutR1.mX(:,1), '-.r', simOutS1.vT,simOutS1.mX(:,1), '--k');
    ylabel('$\varphi_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(3) = subplot(513);
    plot(simOutR1.vT,simOutR1.mX(:,2), '-.r', simOutS1.vT,simOutS1.mX(:,2), '--k');
    ylabel('$\dot{\varphi}_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(4) = subplot(514);
    plot(simOutR1.vT,simOutR1.mX(:,3), '-.r', simOutS1.vT,simOutS1.mX(:,3), '--k');
    ylabel('$\varphi_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(5) = subplot(515);
    plot(simOutR1.vT,simOutR1.mX(:,4), '-.r', simOutS1.vT,simOutS1.mX(:,4), '--k');
    ylabel('$\dot{\varphi}_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;
    
    %disp(['maximum M = ',num2str(max(abs(stTraj.vU)))]);
    print('-depsc', ['Sim_ohneParameteränderung.eps']);
 
%% kürzeres zweites Pendel
    hFig = figure;
    set(hFig, 'Position', [0, 0, 1400, 1000]);

    ax(1) = subplot(511);
    plot(simOutR2.vT,simOutR2.vU, '-.r', simOutS2.vT,simOutS2.vU, '--k');
    ylabel('$M$/Nm','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(2) = subplot(512);
    plot(simOutR2.vT,simOutR2.mX(:,1), '-.r', simOutS2.vT,simOutS2.mX(:,1), '--k');
    ylabel('$\varphi_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(3) = subplot(513);
    plot(simOutR2.vT,simOutR2.mX(:,2), '-.r', simOutS2.vT,simOutS2.mX(:,2), '--k');
    ylabel('$\dot{\varphi}_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(4) = subplot(514);
    plot(simOutR2.vT,simOutR2.mX(:,3), '-.r', simOutS2.vT,simOutS2.mX(:,3), '--k');
    ylabel('$\varphi_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(5) = subplot(515);
    plot(simOutR2.vT,simOutR2.mX(:,4), '-.r', simOutS2.vT,simOutS2.mX(:,4), '--k');
    ylabel('$\dot{\varphi}_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;
    
    %disp(['maximum M = ',num2str(max(abs(stTraj.vU)))]);
    print('-depsc', ['Sim_kuerzeresZweitesPendel.eps']);



%% schwereres erstes Pendel
    
    hFig = figure;
    set(hFig, 'Position', [0, 0, 1400, 1000]);

    ax(1) = subplot(511);
    plot(simOutR3.vT,simOutR3.vU, '-.r', simOutS3.vT,simOutS3.vU, '--k');
    ylabel('$M$/Nm','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(2) = subplot(512);
    plot(simOutR3.vT,simOutR3.mX(:,1), '-.r', simOutS3.vT,simOutS3.mX(:,1), '--k');
    ylabel('$\varphi_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(3) = subplot(513);
    plot(simOutR3.vT,simOutR3.mX(:,2), '-.r', simOutS3.vT,simOutS3.mX(:,2), '--k');
    ylabel('$\dot{\varphi}_1$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(4) = subplot(514);
    plot(simOutR3.vT,simOutR3.mX(:,3), '-.r', simOutS3.vT,simOutS3.mX(:,3), '--k');
    ylabel('$\varphi_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;

    ax(5) = subplot(515);
    plot(simOutR3.vT,simOutR3.mX(:,4), '-.r', simOutS3.vT,simOutS3.mX(:,4), '--k');
    ylabel('$\dot{\varphi}_2$/rad','interpreter','latex');
    xlabel('t/s','interpreter','latex');
    legend('Trajektorienfolgeregelung','Reine Steuerung');
    grid on;
    
    %disp(['maximum M = ',num2str(max(abs(stTraj.vU)))]);
    print('-depsc', ['Sim_schwereresErstesPendel.eps']);
