function F_exp = buildRHS(F,propContact,nodesActive,segments)
%% Function documentation
%
% Add the gap function of every Lagrange multiplier to the RHS load vector
% 
%          Input :
%              F : Number of non prescribed DoF
%   contactNodes : structure containing the global numbering of contact
%                  canditate-nodes coordinates of the candidate nodes
%    activeNodes : List of indices of the nodes for which the matrix should
%                  be built (e.g. the set of all currently active nodes)
%       segments : data stucture containing informations about the rigid 
%                  wall segments (normal vector, parallel vector, position)
%
%         Output :
%          F_exp : Vector containing in its first entries the force on every
%                  DoF  and in its last entries the gap constant for all 
%                  nodes defined in the activeNodes
%
%% Function main body

% get number of DOFs
nDOF = length(F);

% initialize F_exp and add zeros
zero_vector = zeros(length(nodesActive),1);
F_exp = [F;zero_vector];

% initialize counters
k=1;
l=1;
% loop through the number of segments
for m=1:segments.number
    % loop through contact nodes
    for n=1:propContact.numberOfNodes

        if (isempty(nodesActive) || max(ismember(nodesActive,l)))
            F_exp(nDOF+k) = -propContact.gap(n,m);
            
            k=k+1;
        end
        l=l+1;
    end
end

end