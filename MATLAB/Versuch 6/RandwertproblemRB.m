function [deltaRB ] = RandwertproblemRB( xa, xb )
%RANDWERTPROBLEMRB Summary of this function goes here
%   Detailed explanation goes here
deltaRB =  [xa(1);
            xa(2);
            xa(3);
            xa(4);
            xb(1)-pi;
            xb(2);
            xb(3)-pi;
            xb(4)];


end

