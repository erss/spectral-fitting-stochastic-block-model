%%%% paper fitting algorithm

% 1) diagonalize A
[U,L] = eig(A);

Xhat = real(U*sqrtm(L)); % first step to get estimated node positions

% 2) normalize and regularize rows of Xhat
% regularization parameter
alpha_n = sum(A(:))/(n*(n-1)*K);
tau = 0.1*(alpha_n^0.2*K^1.5)/(n^0.3);

norm = sum(Xhat.^2,2).^.5 + tau.*ones(n,1); % norm across columns
norm = repmat(norm,1,n);
Xhat = Xhat./norm;

% 3) K means/ medians


[idx, S]  = kmeans(Xhat,K); %,'Distance','cityblock');

% Zhatp = Xhat*inv(S);
% [y i] = max(Zhatp,[],2);
% Zfinal = zeros(n,K);
% Zfinal(i) = 1;

Zhat = zeros(n,K);
for t = 1:n
    
    Zhat(t,idx(t)) = 1;
end
% 4) Permute Zhat to most closely match Z

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
