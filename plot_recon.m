% plot recon

if plot_display==1
    figure(1);
    if P==1
        if isreal(X) && isreal(mx)
            subplot(1,3,1);plot(X); title 'real signal';
            subplot(1,3,2);plot(mx); title 'reconstruction';
            subplot(1,3,3);plot(X./(sqrt(var(X)))-mx./sqrt(var(mx))); title 'normalized difference';
        else
            subplot(2,3,1);plot(abs(X)); title 'abs( real signal )';
            subplot(2,3,2);plot(abs(mx)); title 'abs( reconstruction )';
            subplot(2,3,3);plot(abs(X)./(sqrt(var(X)))-abs(mx)./sqrt(var(mx))); title 'normalized difference';
        end
    else
        if isreal(X) && isreal(mx)
            subplot(1,3,1);surf(X); title 'real signal';
            subplot(1,3,2);surf(mx); title 'reconstruction';
            subplot(1,3,3);surf(bsxfun(@times,X,1./(sqrt(var(X,1))))-bsxfun(@times,mx,1./sqrt(var(mx,1)))); title 'normalized difference';
        else
            subplot(1,3,1);surf(abs(X)); title 'abs( real signal )';
            subplot(1,3,2);surf(abs(mx)); title 'abs( reconstruction )';
            subplot(1,3,3);surf(bsxfun(@times,abs(X-mean(mean(X))),1./(sqrt(var(X,1))))-bsxfun(@times,abs(mx-mean(mean(mx))),1./sqrt(var(mx,1)))); title 'normalized difference';
        end
    end
    drawnow;
end
