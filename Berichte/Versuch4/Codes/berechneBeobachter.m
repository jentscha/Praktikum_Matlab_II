function L = berechneBeobachter(A, C, poleBeobachter)
MB = obsv(A,C);

if rank(MB)==length(A)
L = place(A', C', poleBeobachter)';
else
 disp('System nicht vollständig beobachtbar');
end

end

