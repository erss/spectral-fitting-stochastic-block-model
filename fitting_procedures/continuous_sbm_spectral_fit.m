%%%% OVERLAPPING CONTINUOUS ASSIGNMENT FITTING ALGORITHM
%%% Algorithm developed from: 'Detecting Overlapping Communities in
%%% Networks Using Spectral Methods' Zhang, Levina, Zhu (2015).

% 1) Compute Laplacian

[Evecs,Evals] = eig(A);
L = Evals(end-K+1:end,end-K+1:end);
U = Evecs(:,end-K+1:end);

X = real(U*sqrtm(L)); % first step to get estimated node positions

% 2) Normalize and regularize rows of X

% Regularization parameter
alpha_n = sum(A(:))/(n*(n-1)*K);
tau = 0.5*(alpha_n^0.2*K^1.5)/(n^0.3);

norm = sum(X.^2,2).^.5 + tau.*ones(n,1); % norm across columns
norm = repmat(norm,1,K);
X = X./norm;

% 3) Hierarchical clustering by medians

warning('off')
P = linkage(X,'median');
idx = cluster(P,'maxclust',K);



