%%%% paper fitting algorithm

% 1) diagonalize A

[Evecs,Evals] = eig(A);
L = Evals(end-K+1:end,end-K+1:end);
U = Evecs(:,end-K+1:end);


Xhat = real(U*sqrtm(L)); % first step to get estimated node positions

% 2) normalize and regularize rows of Xhat
% regularization parameter
alpha_n = sum(A(:))/(n*(n-1)*K);
tau = 0.5*(alpha_n^0.2*K^1.5)/(n^0.3);

norm = sum(Xhat.^2,2).^.5 + tau.*ones(n,1); % norm across columns
norm = repmat(norm,1,K);
Xhat = Xhat./norm;

% 3) Hierarchical clustering by medians

warning('off')
P = linkage(Xhat,'median');
idx = cluster(P,'maxclust',K);



