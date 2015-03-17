% this script generates the signal

zero_entries = ceil((1-rho)*N);

if strcmp(signal_type,'realGauss')
    X = normrnd(signal_mean, (signal_var), N,P);
elseif strcmp(signal_type, 'complexGauss')
    X = complex(normrnd(signal_mean, (signal_var), N,P),normrnd(signal_mean, sqrt(signal_var), N,P));
end

for i=1:P
   p = randperm(N, zero_entries); 
    X(p,i) = zeros(1, zero_entries);
end