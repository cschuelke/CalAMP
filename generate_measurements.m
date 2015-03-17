% this script generates the measurements

Z = F*X;
if strcmp(signal_type,'realGauss')
    noise=normrnd(0,Delta,size(Z));
elseif strcmp(signal_type, 'complexGauss')
    noise=complex(normrnd(0,Delta,size(Z)),normrnd(0,Delta,size(Z)));
end
Z = Z + noise;

if strcmp(cal_type,'none')
    Y = Z;
elseif strcmp(cal_type,'gain')
    %Y = diag(D0.^(-1))*Z;
    Y = diag(D0)^(-1)*Z;
elseif strcmp(cal_type,'faultySensors')
    Y = Z;
    n_faulty_sensors = ceil(epsilon*M);
    faulty_sensors = randperm(M,n_faulty_sensors);
    Y(faulty_sensors,:) = normrnd(faulty_mean,faulty_var,n_faulty_sensors,P);
end