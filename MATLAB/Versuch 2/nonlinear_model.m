function [f, h] = nonlinear_model()
 syms phi1 phi2 dphi1 dphi2 ddphi1 ddphi2 M
    f = [dphi1;
        (375*((9*cos(phi1 - phi2)*sin(phi1 - phi2)*dphi1^2)/1250 ...
        + (3*sin(phi1 - phi2)*dphi2^2)/625 - (4*M)/5 + (8829*sin(phi1))/12500 ...
        - (8829*cos(phi1 - phi2)*sin(phi2))/25000))/((27*cos(phi1 - phi2)^2)/10 - 24/5);
        dphi2;
        -(1250*((18*sin(phi1 - phi2)*dphi1^2)/3125 ...
        + (27*cos(phi1 - phi2)*sin(phi1 - phi2)*dphi2^2)/12500 ...
        - (8829*sin(phi2))/31250 + (79461*cos(phi1 - phi2)*sin(phi1))/250000 ...
        - (9*M*cos(phi1 - phi2))/25))/((27*cos(phi1 - phi2)^2)/10 - 24/5)];

     h = [phi1;
         phi2];
end
