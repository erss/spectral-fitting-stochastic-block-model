%%%%%%%% STOCHASTIC BLOCK MODEL

% 1) Define block membership matrix, B which defines probabilities of 
%    edges between dif communities
B = p_out*ones(K,K);
i = 1:(K+1):(K*K);
B(i)=p_in;


% 2) Define node membership matrix.  This is computed from a multinomial
% distribution on K categories.
p = (1/K)*ones(1,K);
Z = mnrnd(1,p,n);
 
% 3) Compute probability matrix.
W = Z*B*transpose(Z);
i = find(W>1);
W(i) = 1;

% 4) Compute the adjacency matrix, A.
A = binornd(1,W);
A = triu(A,1);
A = (A+transpose(A)); % make symmetric undirected graph

% 5) Remove isolated nodes.

Ap=A;
Z(all(Ap==0,2),:)=[];
Ap(all(Ap==0,2),:)=[];
Ap(:,all(Ap==0,1))=[];
n = size(Ap,1);
A=Ap;

