function T = computeTransformationMtx4Tensor2ndOrderVoigtBSplineSurface ...
    (basisA, basisB)
%% Licensing
%
% License:         BSD License
%                  cane Multiphysics default license: cane/license.txt
%
% Main authors:    Andreas Apostolatos
%
%% Function documentation
%
% Returns the transformation matrix corresponding to the transformation of
% a second order tensor defined over basisA to basisB.
%
%       Input :
%      basisA : The base vectors corresponding to space A
%      basisB : The base vectors corresponding to space B
%
%      Output :
%           T : Transformation matrix for a second order tensor in a Voigt
%               format from space A to space B
%
% Function layout :
%
% 0. Read input
%
% 1. Compute the co-contravariant basis corresponding to space B
%
% 2. Compute the transformation matrix
% 
%% Function main body

%% 0. Read input
T = zeros(3,3);

%% 1. Compute the co-contravariant basis corresponding to space B
metricTensorB = [basisB(:, 1) basisB(:, 2)]'*[basisB(:, 1) basisB(:, 2)];
basisBCoContra = (metricTensorB\[basisB(:, 1) basisB(:, 2)]')';

%% 2. Compute the transformation matrix
T(1, 1) = (basisA(:, 1)'*basisBCoContra(:, 1))^2;
T(1, 2) = (basisA(:, 2)'*basisBCoContra(:, 1))^2;
T(1, 3) = 2*(basisA(:, 1)'*basisBCoContra(:, 1))*(basisA(:, 2)'*basisBCoContra(:, 1));
T(2, 1) = (basisA(:, 1)'*basisBCoContra(:, 2))^2;
T(2, 2) = (basisA(:, 2)'*basisBCoContra(:, 2))^2;
T(2, 3) = 2*(basisA(:, 1)'*basisBCoContra(:, 2))*(basisA(:, 2)'*basisBCoContra(:, 2));
T(3, 1) = (basisA(:, 1)'*basisBCoContra(:, 1))*(basisA(:, 1)'*basisBCoContra(:, 2));
T(3, 2) = (basisA(:, 2)'*basisBCoContra(:, 1))*(basisA(:, 2)'*basisBCoContra(:, 2));
T(3, 3) = (basisA(:, 1)'*basisBCoContra(:, 1))*(basisA(:, 2)'*basisBCoContra(:, 2)) + ...
    (basisA(:,2)'*basisBCoContra(:, 1))*(basisA(:, 1)'*basisBCoContra(:, 2));

end
