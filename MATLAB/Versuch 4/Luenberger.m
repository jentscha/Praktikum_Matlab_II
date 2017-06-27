function L=Luenberger(A,C,Wunschpole)
MB = obsv(A,C);

if rank(MB)==length(A)
luenberger = place(A, C, Wunschpole);
L=luenberger';
else
 disp('System nicht vollständig beobachtbar');
end
end