% mxvx

if strcmp(signal_type,'realGauss')
    iscomplex=0;
elseif strcmp(signal_type,'complexGauss')
    iscomplex=1;
end

f0= (1-rho).*normal(MX,0,VX,iscomplex) + rho.*normal(MX,0,VX+1,iscomplex);
f1= rho*MX./(VX+1).*normal(MX,0,VX+1,iscomplex);
f2= rho.*(abs(MX).^2 + VX.*(VX+1))./((VX+1).^2).*normal(MX,0,VX+1,iscomplex);

mx=f1./max(f0,eps);
vx=(f2./max(f0,eps) - abs(mx).^2);
