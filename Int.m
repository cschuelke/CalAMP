function result = Int(N,mu,sigma,a,b)

%mu=real(mu);
%sigma=real(sigma);

result = 0;
flag=0;
for i=0:N
    
    if rem(i,2)==0
        incr = 1/2.*gamma(i/2+1/2).*(sign(b-mu).*gammainc((b-mu).^2./(2*sigma),i/2+1/2) - sign(a-mu).*gammainc((a-mu).^2./(2*sigma),i/2+1/2));
        %incr = 1/2.*gamma(i/2+1/2).*(sign(b-mu).*gammainc((b-mu).^2./(2*sigma),i/2+1/2,'scaledlower') - sign(a-mu).*gammainc((a-mu).^2./(2*sigma),i/2+1/2,'scaledlower').*((a-mu).^2/(b-mu).^2).^(i/2+1/2).*exp((b-a).*(b+a-2*mu)./(2*sigma)))./gamma(i/2+3/2).*((b-mu).^2./(2*sigma)).^(i/2+1/2).*exp(-(b-mu).^2./(2*sigma));
    else
        incr = 1/2.*gamma(i/2+1/2).*(gammainc((b-mu).^2./(2*sigma),i/2+1/2) - gammainc((a-mu).^2./(2*sigma),i/2+1/2));
        %incr = 1/2.*gamma(i/2+1/2).*(gammainc((b-mu).^2./(2*sigma),i/2+1/2,'scaledlower') - gammainc((a-mu).^2./(2*sigma),i/2+1/2,'scaledlower').*((a-mu).^2/(b-mu).^2).^(i/2+1/2).*exp((b-a).*(b+a-2*mu)./(2*sigma)))./gamma(i/2+3/2).*((b-mu).^2./(2*sigma)).^(i/2+1/2).*exp(-(b-mu).^2./(2*sigma));
    end;
    if incr==0
        flag=1;
    end;
    
    result = result + nchoosek(N,i).*mu.^(N-i).*(sqrt(2*sigma)).^(i+1).*incr;
    
end

if result<eps
    % disp('int minuscule');
end
%if flag==1
%    disp('some increment was zero');
%end

end
