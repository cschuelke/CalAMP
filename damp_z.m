%damp w and V

VZ_before = VZ;
VZ = (damping.*VZ.^(-1) + (1-damping)./damping.*VZ_old.^(-1)).^(-1);
dampingPrime = damping.*VZ./VZ_before;
MZ = dampingPrime.*MZ + (1-dampingPrime).*MZ_old;

clear VZ_before dampingPrime;