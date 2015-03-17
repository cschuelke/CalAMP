%rng(10);

% initialize variables of the algorithm
iter=0;
finished =0;


F2 = abs(F).^2;
conjF = conj(F);

% initialization
MX = 0*ones(N,P);
VX = rho.*signal_var.*ones(N,P);  %initialize for damping

vx = rho.*signal_var.*ones(N,P);
mx = normrnd(0,1,[N P]);

VZ = signal_var.*ones(size(Y));%F2*vx;
MZ = double(Y);


%vz = 0*ones(size(Y)); %F2*vx;
mz = double(Y);

save_old();

%mzvz();
