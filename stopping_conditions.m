%stopping conditions

iter_check=200;

if mus(iter)>0.9999999
    resultat = mus(iter);
    disp('target mu reached!');
    finished=1;
    %break;
elseif iter>iter_check && ~(mus(iter)>1.0000001*mus(iter-iter_check+1))
    resultat = mus(iter);
    disp('non-increasing mu');
    finished=1;
    %break;
elseif ~isfinite(mus(iter))
    resultat = mus(iter-1);
    iter=iter-1;
    finished=1;
end