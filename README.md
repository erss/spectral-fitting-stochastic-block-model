# spectral-fitting-sbm

Implements three spectral fitting algorithms to find network clusters in the stochastic block model.

## Simulations
1) Stochastic block model

The stochastic block model (SBM) randomly generates a network comprised of **n** nodes from **K** communities.  Within each community the nodes are more likely to form connections with each other than with nodes outside their community.  The matrix of probabilities for randomly generating the adjacency A is defined as W = ZBZ<sup>T</sup>, where

  - B is the **K** x **K** *block membership matrix* defining probabilities of edges between different communities.  B<sub>ii</sub> is the probability of a node in community *i* connecting to a node in the same community. B<sub>ij</sub>  is the probability of a node in community *i* connecting to a node in community *j*. We assume the probabilities are reciprocal and B<sub>ij</sub>  = B<sub>ji</sub>.

  - Z is the **n** x **K** binary membership matrix.  Each row contains only one non-zero entry corresponding to its community membership.
 
    
2) Degree-corrected stochastic block model


A major limitation of the SBM is that all nodes in the same block have the same expected degree [1]. In the degree-corrected SBM, node-specific degree parameters, θ<sub>i</sub> are introduced for each node **i** allowing for heterogeneous degree distributions within blocks. This adds the additional parameter Θ = diag(θ<sub>i</sub>), such that now the matrix of probabilities W = α<sub>n</sub>ΘZBZ<sup>T</sup>Θ, where α<sub>n</sub> is the global scaling factor that approaches zero as *n* goes to infinity. This prevents the graph from becoming too dense. In order for the model to be identifiable, the degree parameters for nodes within the same community are normalized to a constant value [2].

3) Overlapping and Continuous Community Assignment

For many real-world networks, nodes may belong to more than one community. The overlapping continuous assignment SBM is a generalization of the DC-SBM, where the restriction on the community membership matrix Z to be binary is removed and now each node can belong to a mixture of communities with different weights [1]. In order for the model to be identifiable however the authors of [1] impose the following restrictions. First, B must be of full rank and strictly positive definite. Additionally, Z must have at least one node for each community that only belongs to that community. Finally, the degree parameters must be normalized to some constant value.

## References:

[1] Zhang, Y., Levina, E. & Zhu, J. (2015). Detecting Overlapping Communi- ties in Networks Using Spectral Methods. Journal of Statistical Mechanics: Theory and Experiment, 2015.

[2] Qin, T., & Rohe, K. (2013). Regularized Spectral Clustering Under the Degree-Corrected Stochastic Blockmodel. Journal of Statistical Mechanics: Theory and Experiment, 2013.

[3] Spielman, D. (2015). Spectral Graph Theory. Lectures 2, 3 & 21.

[4] Donetti, L., & Mun ̃oz, M. A. (2004). Detecting network communities: a new systematic and efficient algorithm. Journal of Statistical Mechanics: Theory and Experiment, 2004.
