% calculate MSE, correlation etc

%mse - will not go to zero in the complex case
mse(iter) = mean(mean(abs(mx-X).^2,1),2); 
%normalized cross-correlation
mus(iter) = mean(mean(abs(bsxfun(@times, conj(bsxfun(@minus,X,mean(X,1))).*bsxfun(@minus,mx,mean(mx,1)),1./sqrt(var(X,1).*var(mx,1)))),1),2);
%normalized overlap
mus2(iter) = mean(mean(abs(conj(X).*mx),1)./sqrt(mean(abs(X).^2,1).*mean(abs(mx).^2,1)),2);

%corrected mse in case of gain calibration, this should go to zero:
if strcmp(cal_type,'gain')
    D_est = mean(md,2).';
    scaling=mean((D0./D_est));
    mse_corr(iter) = mean(mean(abs(X-scaling.*mx).^2,1),2);
    clear D_est scaling;
end