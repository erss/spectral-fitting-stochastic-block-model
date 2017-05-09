%% Stochastic Block Model Simulation
clear all;

% 1) Define parameters.

K     = 3;       % number of communities
n     = 50;      % number of nodes
p_in  = 1/2;     % probability of node connecting to node inside its community
p_out = 1/8;     % probability of node connecting outside its community

% 2) Simulate network.
sbm_simulation; 

% 3) Fit network using simple spectral fitting procedure.
laplacian = true; % TRUE indicates fitting on Laplacian 
                  % FALSE indicates fitting on adjacency A.
spectral_fit;

% 4) Plot true and estimated networks.
figure;
subplot(1,2,1)
plot_labeled_network(A,Z);
title('True Network Communities','FontSize',15)

subplot(1,2,2)
plot_labeled_network(A,Zhat);
title('Estimated Network Communities','FontSize',15)
h = suptitle('Stochastic Block Model');
set(h,'FontSize',20,'FontWeight','normal')

% 5) Compute fraction of misclassified nodes.
difference = (Z-Zhat);
i = find((difference)==-1);
difference(i) =0;
number_misclassified = sum(difference(:));
fraction_misclassified = number_misclassified/n;

fprintf('The fraction of nodes misclassified for \n fitting the stochastic block model:')
disp(fraction_misclassified);


%% Degree-corrected SBM Simulation
clear all;

% 1) Define parameters.

K       = 3;     %number of communities
n       = 1000;  % number of nodes
p_in    = 1;     % probability of node connecting to node inside its community
p_out   = 1/8;   % probability of node connecting outside its community
alpha_n = 1/n;   % global scaling parameter

% 2) Simulate network.
degree_corrected_sbm_simulation; 

% 3) Fit network using spectral fitting procedure for degree correction. 
degree_corrected_spectral_fit;

% 4) Plot true and estimated networks.
figure;
subplot(1,2,1)
plot_labeled_network(A,Z);
title('True Network Communities','FontSize',15)

subplot(1,2,2)
plot_labeled_network(A,Zhat);
title('Estimated Network Communities','FontSize',15)
h = suptitle('Degree-Corrected SBM');
set(h,'FontSize',20,'FontWeight','normal')

% 5) Compute fraction of misclassified nodes.
difference = (Z-Zhat);
i = find((difference)==-1);
difference(i) =0;
number_misclassified = sum(difference(:));
fraction_misclassified = number_misclassified/n;

fprintf('The fraction of nodes misclassified for \n fitting the degree-corrected stochastic block model:')
disp(fraction_misclassified);

% 6) Plot nodes in eigenspace colored by community assignment.
figure;
scatter3(X(:,1),X(:,2),X(:,3),150,idx,'filled')
xlabel('First eigenvector')
ylabel('Second eigenvector')
zlabel('Third eigenvector')
title('Nodes represented in eigenspace and colored by community assignment')

%% Overlapping and Continuous Community Assignment Simulation
clear all;

% 1) Define parameters.
K       = 4;    % number of communities
n       = 1000; % number of nodes
p_in    = 1;    % probability of node connecting to node inside its community
p_out   = 1/8;  % probability of node connecting outside its community
alpha_n = 1/n;  % global scaling parameter

% 2) Simulate network.
overlapping_continuous_sbm_simulation;

% 3) Fit network using overlapping continuous assignment procedure.
continuous_sbm_spectral_fit;

% 4) Plot true network.
figure;
plot_labeled_network(A);
h = suptitle('Continuous Assignment SBM');
set(h,'FontSize',20,'FontWeight','normal')

% 5) Plot nodes in eigenspace colored by discrete community assignment.
figure;
scatter3(X(:,1),X(:,2),X(:,3),150,idx,'filled')
xlabel('First eigenvector')
ylabel('Second eigenvector')
zlabel('Third eigenvector')
title('Nodes represented in eigenspace and colored by discrete community assignment')

