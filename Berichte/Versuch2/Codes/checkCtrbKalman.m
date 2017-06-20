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
else
    disp('nicht steuerbar');
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
