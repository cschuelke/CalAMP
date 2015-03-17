% calculate gout

if strcmp(cal_type,'none')
    if strcmp(sensing,'realCS')
        vz = (VZ.^(-1) + Delta.^(-1)).^(-1);
        mz = vz.*(MZ./VZ + Y./Delta); 
    end
elseif strcmp(cal_type,'gain')
    if iter>0
        calculate_d();
    else 
        md=d_unif_mean;
        vd=d_var;
    end
    vz=Delta*VZ./(Delta+VZ).*(1+Delta.*VZ./(Delta+VZ).*abs(Y).^2./Delta^2.*vd);
%     if P==1 
%        vz=0.9*VZ;
%     end
    mz=Delta*VZ./(Delta+VZ).*(MZ./VZ + Y.*md./Delta);        
elseif strcmp(cal_type, 'faultySensors')    
    pif = prod(normal(Y,faulty_mean,faulty_var,0),2);
    piz = prod(normal(Y,MZ,VZ,0),2); %piz=max(piz,1e9);
    g0 = epsilon.*pif + (1-epsilon).*piz;
    %g1 = epsilon.*bsxfun(@times,Y,pif) + (1-epsilon).*bsxfun(@times,MZ,piz);
    %g2 = epsilon.*bsxfun(@times,Y.^2,pif) + (1-epsilon).*bsxfun(@times,MZ.^2,piz);
    g1 = epsilon.*bsxfun(@times,MZ,pif) + (1-epsilon).*bsxfun(@times,Y,piz);
    g2 = epsilon.*bsxfun(@times,abs(MZ).^2+VZ,pif) + (1-epsilon).*bsxfun(@times,abs(Y).^2,piz);  
    mz = bsxfun(@times,g1,1./max(g0,eps));
    vz = bsxfun(@times,g2,1./max(g0,eps)) - abs(mz).^2;     
else
    disp('Unknown type of calibration');
end