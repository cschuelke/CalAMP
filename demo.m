%rng('default');
%clear all;
addpath('subroutines');

%% Select options and launch a recon

%% Signal options
N   =   500;
rho =   0.2;
signal_type = 'complexGauss';           % 'realGauss', 'complexGauss'
signal_mean = 0;
signal_var = 1;

%% Mixing options
alpha_list=0.8;
matrix_type = 'complexGauss';          % 'realGauss', 'complexGauss'

%% Sensing options
Delta = 1e-15;                  % AWGN variance

%% Calibration options
P = 3;
cal_type = 'gain';              % 'none', 'gain' 'faultySensors'
sensing='realCS';               % leave this

d_distribution = 'complexGauss';     % 'uniform', 'gauss', 'complexGauss'
d_recon_prior = 'complex';         % 'uniform', 'mis','complex'

epsilon =     0.2;
faulty_mean = 0;
faulty_var = rho*signal_var;

%for the uniform prior
d_unif_mean =1;
wd = 1;
d_var = wd^2./12;

%for the gauss prior
d_norm_mean = 1;
d_norm_var = 2;

%for the complexGaussian prior
d_complex_mean = 0;
d_complex_var = 20;


%% Algorithm options
iter_max = 1000;
txt_display = 1;
plot_display = 1;
damping = 0.9;                    % 1 is undamped, 0 infinitely damped
%0.8 for faulty sensors


for ind_alpha=1:length(alpha_list)  
        alpha=alpha_list(ind_alpha);
        fprintf('alpha = %d \n',alpha);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Generate an instance
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %generate signal X
        generate_signal();
        %generate measurement matrix F
        generate_matrix();
        %generate calibration coefficients D0
        if ~strcmp(cal_type,'none')
            generate_d();
        end
        %generate measurements with X,F and D0
        generate_measurements();
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Launch the reconstruction
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %initialize variables
        initialize_variables();
        %main loop
        launch_recon();
        
        my_mse(ind_alpha,ind2)=mse(end);
        clear mse;
        my_mu(ind_alpha,ind2)=mus(end);
        clear mus;
end

