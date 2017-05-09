function plot_labeled_network( A, Z )
% Plots graph for given adjacency matrix A and given community assignment
% matrix Z (optional).  Z is a binary matrix of size [number of nodes] x [number of
% communities]. 

if nargin == 1  % default Z plots network as one community
    Z= ones(size(A,1),1);
end

    G = graph(A);
    n = size(A,1);
    K = size(Z,2);
   
    h = plot(G,'MarkerSize',15,'LineWidth',2);
    h.NodeLabel = {};
    axis square
    axis tight
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);


    for node = 1:n
        indices(node) = find(Z(node,:)==1);
    end

    for k = 1:K
        labels = find(indices==k);
        if K == 1
           highlight(h,labels,'NodeColor','k');
        else
           highlight(h,labels,'NodeColor',[k/K 1/k^3 1/k]);
        end
    end


end

