%%%% DEGREE CORRECTED SPECTRAL FITTING ALGORITHM
%%% Algorithm developed from: 'Regularized Spectral Clustering Under the
%%% Degree-Corrected Stochastic Blockmodel' Qin and Rohe (2013).

% 1) Compute regularized graph Laplacian

D = sum(A,2);  % expected node degrees
tau = mean(D); % mean node degree
D = diag(D);
D = D+tau*eye(size(D)); % regularize

L = inv(sqrt(D))*A*inv(sqrt(D)); % graph Laplacian

% 2) Diagonalize Laplacian

[Evecs,Evals] = eig(L);
X = Evecs(:,end-K+1:end); % take K leading eigenvectors

% 3) Project X onto unit sphere;

norm = sum(X.^2,2).^.5;
norm = repmat(norm,1,K);
X = X./norm;

% 4) Cluster using K means.

idx = kmeans(X,K);

% 5) Graph matching: permute Zhat to most closely match Z
Zhat = zeros(n,K);
for t = 1:n
    
    Zhat(t,idx(t)) = 1;
end

permutations = perms([1:K]);

for i = 1:size(permutations,1)
    indices = permutations(i,:);
    Zpermuted = Zhat(:,indices);   
    difference = (Z-Zpermuted);
    ix = find((difference)==-1);
    difference(ix) =0;
    error(i) = sum(difference(:));
   
end

[y, i] = min(error);
Zhat = Zhat(:,permutations(i,:));