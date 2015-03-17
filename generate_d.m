% this script generates the d coefficients

if strcmp(d_distribution,'uniform')
    narrow =0.8;
    fprintf('True width of d distribution reduced by a factor % .2f \n', narrow);
    D0 = d_unif_mean + narrow*wd*(rand(1,M)-0.5);
    clear narrow;
elseif strcmp(d_distribution,'gauss')
    D0 = normrnd(d_norm_mean,sqrt(d_norm_var),[1 M]);
elseif strcmp(d_distribution,'complexGauss')
    D0 = complex(normrnd(real(d_complex_mean),sqrt(0.5*d_complex_var),[1 M]),normrnd(imag(d_complex_mean),sqrt(0.5*d_complex_var),[1 M]));
   %D0=normrnd(d_norm_mean,sqrt(d_norm_var),1,M);
   %D0=D0.*exp(1i*2*pi*rand(1,M));
end