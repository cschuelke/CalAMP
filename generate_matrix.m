% this script generates the matrix

M = ceil(alpha*N);
if strcmp(matrix_type,'realGauss')
    F = normrnd(0,1./sqrt(N),M,N);
elseif strcmp(matrix_type,'complexGauss')
    F = complex(normrnd(0,1./sqrt(N),M,N),normrnd(0,1./sqrt(N),M,N));
end