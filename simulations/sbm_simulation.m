%%%%%%%% Symmetric Stochastic Block Model

% B defines probabilities of edges b/w dif communities

B = p_out*ones(K,K);
i = 1:(K+1):(K*K);
B(i)=p_in;


% Define block membership matrix
p = (1/K)*ones(1,K);
Z= mnrnd(1,p,n);
 
% compute probability matrix
W = Z*B*transpose(Z);
i = find(W>1);
W(i) = 1;

% compute A
A = binornd(1,W);
A = triu(A,1);
A = (A+transpose(A)); % make symmetric undirected graph


% Remove unconnected nodes

Ap=A;
Z(all(Ap==0,2),:)=[];
Ap(all(Ap==0,2),:)=[];
Ap(:,all(Ap==0,1))=[];
n = size(Ap,1);
A=Ap;

