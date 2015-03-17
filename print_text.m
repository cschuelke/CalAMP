%print indicators
if txt_display==1
    if strcmp(cal_type,'gain')
        fprintf('Iteration %i, mse: %i, mse_corr: %i, mu: %i, mu2: %i \n', iter, mse(iter),mse_corr(iter), mus(iter), mus2(iter));
    else
        fprintf('Iteration %i, mse: %i, mu: %i, mu2: %i \n' , iter,mse(iter), mus(iter), mus2(iter));

    end
end