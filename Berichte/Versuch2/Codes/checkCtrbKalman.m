<<<<<<< HEAD
function checkCtrbKalman(A,B)
 
%Berechnung der Anzahl der Zustände
n = size(A,1);
%Anfangswert der Steuerbarkeitsmatrix ist gleich der Eingangmatrix B
S_s_Kalman = B;
 
for i = 1:1:n-1
    %Berechnung der Steuerbarkeitsmatrix
    S_s_Kalman = [B A*S_s_Kalman];
end

disp('S=')
disp(S_s_Kalman)

%Überprüfung der Steuerbarkeit nach KALMAN
if (rank(S_s_Kalman)==n)
    disp('steuerbar');
=======
function [ S_s_Kalman] = checkCtrbKalman( A, B )

n = length(A);

if (rank(A)==n)
    
>>>>>>> 38b7d0387000b3368fdeffdc189b3b80731375e2
else
    disp('nicht steuerbar');
end
S_s_Kalman = B;
for count = 1:n-1
    S_s_Kalman = [S_s_Kalman, A^count *B ];
end
end

%%Überprüfung der Steuerbarkeit auf die drei Zustandsraummodelle
%S:Steuerbarkeitsmatrix

%1. Zustandsraummodell mit AP_1
S=
   1.0e+04 *

         0    0.0143         0   -3.1532
    0.0143         0   -3.1532         0
         0   -0.0214         0    6.3064
   -0.0214         0    6.3064         0

steuerbar

%2. Zustandsraummodell mit AP_2

S=
   1.0e+04 *

         0    0.0143         0    3.1532
    0.0143         0    3.1532         0
         0   -0.0214         0   -6.3064
   -0.0214         0   -6.3064         0

steuerbar

%3. Zustandsraummodell mit AP_3

S=
         0   62.5000         0         0
   62.5000         0         0         0
         0         0         0         0
         0         0         0         0

nicht steuerbar
