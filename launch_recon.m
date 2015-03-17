% main algorithm loop

for iter=1:iter_max 

    save_old();
        
    VZ = F2*vx;
    MZ = F*mx - VZ.*(mz-MZ)./VZ_old;
    
    %damping
    if iter>1 && P>1
        damp_z();
    end
        
    %calculate mz and vz
    mzvz();
     
    VX = (F2.'*((VZ-vz)./VZ.^2)).^(-1);
     if ~isreal(sqrt(VX))
         disp('VX should always be positive');
         VX(VX<0)=max(VX(VX<0),signal_var);
    end
    
    MX = mx + VX.*((conjF.')*((mz-MZ)./VZ));
  
    %damping
    if iter>1
        damp_x();
    end
    
    %calculate mx and vx
    mxvx();
    
    %calculate indicators
    calculate_indicators();
    %print results
    print_text();
    %plot reconstruction
    plot_recon();
    %plot calibration parameters
    if strcmp(cal_type,'gain')
      %  plot_cal();
    end
    %stopping conditions
    stopping_conditions();
    
    if finished==1
        break;
    end
    
end