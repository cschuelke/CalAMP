function results = PhaseDiagram(rho,alpha,fill,P,rho_d,faulty_var)

method=1;
delta=1;

%% Try to parralelize if a matalbpool can be opened
try
    matlabpool(6);
catch error
    disp('Parralel treatment impossible');
end


%% Create matrices of parameters with total number of cells N_total
if fill==1
    s_alpha = max(size(alpha));
    s_rho = max(size(rho));
    s_P = max(size(P));
    s_rho_d = max(size(rho_d));
    s = [s_alpha s_rho s_P s_rho_d];
    N_total = s_alpha*s_rho*s_P*s_rho_d;
    alpha = repmat(alpha',[1 s_rho s_P s_rho_d]);
    rho = repmat(rho',[1 s_alpha s_P s_rho_d]);
    rho = permute(rho,[2 1 3 4]);
    P = repmat(P',[1 s_alpha s_rho s_rho_d]);
    P = permute(P,[2 3 1 4]);
    rho_d = repmat(rho_d',[1 s_alpha s_rho s_P]);
    rho_d = permute(rho_d,[2 3 4 1]);
elseif fill==0    %allow only one P but multiple deltas
    rho = repmat(rho,[1 1 max(size(delta))]);
    alpha = repmat(alpha,[1 1 max(size(delta))]);
    N_total=numel(rho);
    P = repmat(P,size(rho));
    delta = repmat(delta',[1 size(rho(:,:,1))]);
    delta = permute(delta,[2 3 1]);  
    s=size(rho);
end


%% Initialize results table

mu = ones(s);

%% Calculate diagram points
%par
parfor ind=1:N_total
    
    %% Solve one point
    if alpha(ind)<rho(ind)/(1-rho_d(ind))
        res=0.1;
    else
        disp(sprintf('Solving point %i of %i with rho %f , alpha %f, P %i, rho_d: %f', ind , N_total,rho(ind), alpha(ind),P(ind),rho_d(ind)));
        res = BC_fun(rho(ind),alpha(ind),rho_d(ind),P(ind),faulty_var);
    end
    %% Collect intersting data
    resultats(ind) = res(end);
    
    
end;

disp('all jobs ended');

results.faulty_var = faulty_var;
results.P = P;
results.rho = rho;
results.rho_d = rho_d;
results.alpha=alpha;
results.resultats=resultats;

%find number of this phase diagram: take the smallest id not already taken
[status, numberlist] =unix('./counting.sh');
numberlist = str2num(numberlist);
free = setdiff(1:max(numberlist)+1,numberlist);
ind_diag = min(free);
if isempty(free); ind_diag=1;end;
filename = sprintf('phaseDiagram%i.mat',ind_diag);
save(filename,'results');

try
    matlabpool close
catch error
end

end

