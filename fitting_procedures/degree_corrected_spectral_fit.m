%%%% degree_correct_spectral_fit

% 1) Find graph Laplacian
D = sum(A,2); % expected node degrees
tau = mean(D);
D = diag(D);
D = D+tau*eye(size(D)); % regularize

L = inv(sqrt(D))*A*inv(sqrt(D)); % graph Laplacian

% 2) Diagonalize Laplacian

[Evecs,Evals] = eig(L);

X = Evecs(:,end-K+1:end); % take K largest eigenvectors, corresponding to largest evals

% 3) Normalize X;

norm = sum(X.^2,2).^.5;
norm = repmat(norm,1,K);
Xhat = X./norm;

% 4) Cluster

idx = kmeans(Xhat,K);
% 
% Z = linkage(Xhat,'median');
% c = cluster(Z,'maxclust',6);
% scatter3(X(:,1),X(:,2),X(:,3),10,c)

%Zhat = Xhat*inv(S);

Zhat = zeros(n,K);
for t = 1:n
    
    Zhat(t,idx(t)) = 1;
end

% 5) Permute Zhat to most closely match Z

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