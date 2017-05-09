%%%%%%%% Degree Corrected Stochastic Block Model

% B defines probabilities of edges b/w dif communities

B = p_out*ones(K,K);

i = 1:(K+1):(K*K);
B(i)=p_in;

% Define block membership matrix

p = (1/K)*ones(1,K);
Z = mnrnd(1,p,n);
   
% Define node specific degree parameters

degrees = unifrnd(0,1,[1 n]);

for i = 1:K
    idx = find(Z(:,i)==1);
    degrees(idx) = degrees(idx)./sum(degrees(idx));
end
degrees = (10/max(degrees)).*degrees;
theta = diag(degrees);


% compute probability matrix
W = alpha_n*theta*Z*B*transpose(Z)*theta;
i = find(W>1);
W(i) = 1;

% compute A
A = binornd(1,W);
A = triu(A,1);
A = (A+transpose(A)); % make symmetric undirected graph

% Remove unconnected isolated nodes

Ap=A;
Z(all(Ap==0,2),:)=[];
Ap(all(Ap==0,2),:)=[];
Ap(:,all(Ap==0,1))=[];
n = size(Ap,1);
A=Ap;
