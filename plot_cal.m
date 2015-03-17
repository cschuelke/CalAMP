%plot calibration parameters if appliable
if plot_display==1
    figure(2);
    subplot(1,3,1);plot(abs(D0));title 'real d';
    k_est = mean(md,2).';
    subplot(1,3,2);plot(abs(k_est));title 'reconstructed d';
    subplot(1,3,3);plot(abs((D0)./sqrt(var((D0)))) - abs(k_est)./sqrt(var((k_est))));title 'normalized difference';
    %clear k_est;
end