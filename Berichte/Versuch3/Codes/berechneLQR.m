function [ K, poleRK] = berechneLQR( A, B, Q, R )

%Fehlerabfragen
K       = 'Error';
poleRK  = []

%Steuerbarkeit
if length(A) == rank(ctrb(A,B))
    disp('System ist steuerbar');
else
    disp('System ist NICHT steuerbar');
end
    
%Test auf Symmetrie von Q:

if all(all(Q == Q'))
    disp('Matrix Q ist symmetrisch');
else
    disp('Matrix Q ist NICHT symmetrisch');
end

%Test auf Symmetrie von R:

if all(all(R == R'))
    disp('Matrix R ist symmetrisch');
else
    disp('Matrix R ist NICHT symmetrisch');
end
    
%Test auf positive Definitheit von Q:

if all(real(eig(Q)) > 0)
    disp('Matrix Q ist positiv definit');
else    
    disp('Matrix Q ist NICHT positiv definit');
end


%Test auf positive Definitheit von R:
if all(real(eig(R)) > 0)
    disp('Matrix R ist positiv definit');
else    
    disp('Matrix R ist NICHT positiv definit');
end


%Reglerberechnung:
[K, ~, poleRK] = lqr(A,B,Q,R,zeros(size(B,2)));
    %poleRK: Pole geschlossener Regelkreis
    
end %function berechneLQR


