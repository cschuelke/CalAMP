function result=normal(x,mean,var,iscomplex)

if (iscomplex==0)
    result = 1./(sqrt(2*pi*var)).*exp(-(abs(x-mean).^2)./(2*var));
elseif (iscomplex==1)  %% verifier le /2
    result = normal(real(x),real(mean),var,0).*normal(imag(x),imag(mean),var,0);
end

end