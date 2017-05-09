%%%% SPECTRAL FITTING ALGORITHM
%%% Computes basic fitting prodedure on graph Laplacian, L, or on adjacency
%%% matrix, A. If L, then clusters K eigenvectors corresponding to the
%%% smallest eigenvalues.  If D, then clusters K eigenvectors corresponding
%%% to largest eigenvalues. K is the number of communities.


% 1) Diagonalize A or Diagonalize Laplacian

if laplacian % Diagonalize Laplacian if true
 D = diag(sum(A,2));
 L = D - A; 
 [Evecs,Evals] = eig(L);
 X = Evecs(:,1:K); % Take K eigenvectors corresponding to smallest eigenvalues
else         % ... otherwise diagonalize A
    [Evecs,Evals] = eig(A);
    X = Evecs(:,end-K+1:end); % Take K eigenvectors corresponding to largest eigenvalues
end

% 2) Cluster using K means.

[idx, S]  = kmeans(X,K);

% 3) Graph matching: permute Zhat to most closely match Z

Zhat = zeros(n,K);  % Create community membership matrix based on clustering
for t = 1:n    
    Zhat(t,idx(t)) = 1;
end


permutations = perms([1:K]); % Graph matching

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
