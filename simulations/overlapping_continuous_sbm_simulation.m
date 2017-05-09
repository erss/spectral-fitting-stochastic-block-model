%%%%%%%% Overlapping Continuous Stochastic Block Model

% 1) Define block membership matrix, B which defines probabilities of 
%    edges between dif communities
p_in=1;
B = p_out*ones(K,K);

i = 1:(K+1):(K*K);
B(i)=p_in;



% 2) Define node membership matrix.  This is computed from a mixture
% distribution of a multinomial on K categories and a uniform distribution
% on (0,1), with more probability to generate nodes from a multinomial.
% This generates mostly nodes belonging to one community and the rest
% belonging to a mixture of communities.

p = (1/K)*ones(1,K);
Z = zeros(n,K);

for i = 1:n
    if (binornd(1,pi_p))
        Z(i,:)= mnrnd(1,p);
    else
        Z(i,:)= unifrnd(0,1,[1 K]);
    end
end

   
% 3) Define node specific degree parameters. Degrees are drawn from a
% uniform distribution on (0,1), and each set of node corresponding to a
% commubnity is normalized to a constant.

degrees = unifrnd(0,1,[1 n]);

for i = 1:K
    idx = find(Z(:,i)==1);
    degrees(idx) = degrees(idx)./sum(degrees(idx));
end
degrees = (10/max(degrees)).*degrees;
theta = diag(degrees);

% 4) Compute probability matrix.
W = alpha_n*theta*Z*B*transpose(Z)*theta;
i = find(W>1);
W(i) = 1;

% 5) Compute the adjacency matrix, A.
A = binornd(1,W);
A = triu(A,1);
A = (A+transpose(A)); % make symmetric undirected graph

% 6) Remove isolated nodes.

Ap=A;
Z(all(Ap==0,2),:)=[];
Ap(all(Ap==0,2),:)=[];
Ap(:,all(Ap==0,1))=[];
n = size(Ap,1);
A=Ap;


