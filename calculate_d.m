% calculate_d

VD = (sum(abs(Y).^2./(Delta + VZ),2)).^(-1);
MD = VD.*sum(MZ.*conj(Y)./(Delta+VZ),2);

if strcmp(d_recon_prior,'uniform')
    
    binf = (2-wd)/2;
    bsup =(2+wd)/2;
    
    int0 = Int(P,MD,VD,binf,bsup);
    int1 = Int(P+1,MD,VD,binf,bsup);
    int2 = Int(P+2,MD,VD,binf,bsup);
    
    md = int1./max(int0,eps);
    vd = int2./max(int0,eps) - md.^2;
    
elseif strcmp(d_recon_prior,'mis')
    % this prior is simple to calculate and seems much more stable than the
    % uniform prior.
    
    delta=d_var;
    SS = (1./VD + 1/(delta) ).^(-1);
    MM = SS.*(MD./VD + d_unif_mean/(delta));
    
    result1 = Int(P+1,MM,SS,0,Inf);
    result0 = max(Int(P,MM,SS,0,Inf),eps);
    md  = result1./result0;
    
    result2 = Int(P+2,MM,SS,0,Inf);
    vd = result2./result0 - md.^2;
    
    clear delta result0 result1 result2 SS MM;
    
elseif strcmp(d_recon_prior,'complex')
    phase = MD./abs(MD); 
    phase(MD==0)=0;
%     S = (1./VD + 1/(d_complex_var) ).^(-1);
%     M = S.*(abs(MD)./VD + 0/(d_complex_var));
    S=VD;
    M=abs(MD);
    int0 = Int(P+1,M,S,0,Inf);
    int1 = Int(P+2,M,S,0,Inf);
    result = int1./max(int0,eps);
    
%     dinf=1e-8;dsup=1e10; DMAX=dsup;
%     result(result<dinf)=dinf;
%     result(result>dsup)=DMAX; 
    
    md=phase.*result;
    md(MD==0) = 1;
    vd=VD;
    if P==1 
        vd=0.95*VD;
    end
    
    %adding this makes sure k does not get too small, and 
    %thereby greatly improves convergence 
    if var(md)~=0
        md=md./sqrt(var(md)).*sqrt(d_complex_var);  
    end

        
end

%if we want to get rid of the scaling factor
%md=md./sqrt(var(md)).*sqrt(var(D0));

vd = repmat(vd,[1 P]);
md = repmat(md,[1 P]);
