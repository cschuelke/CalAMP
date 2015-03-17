%damp MX and VX
VX_before = VX;
VX = (damping.*VX.^(-1) + (1-damping)./damping.*VX_old.^(-1)).^(-1);
dampingPrime = damping.*VX./VX_before;
MX = dampingPrime.*MX + (1-dampingPrime).*MX_old;
clear VX_before dampingPrime;