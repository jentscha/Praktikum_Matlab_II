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


