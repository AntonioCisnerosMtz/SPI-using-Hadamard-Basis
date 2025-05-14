function p = SubplotIndicesByColumn(M, N)
% SubplotIndicesByColumn Generates column-major subplot indices for M×N grid
%
%   p = SubplotIndicesByColumn(M, N) creates indices to arrange subplots
%   in column-major order (top to bottom, left to right) instead of MATLAB's
%   default row-major order
%
%   Inputs:
%       M - Number of rows in subplot grid
%       N - Number of columns in subplot grid
%   Output:
%       p - Array of subplot indices (1×M*N) in column-major order
%
%   Example:
%       p = columnMajorSubplotIndices(2, 3)  % For 2x3 grid (6 subplots)
%       Returns: [1 3 5 2 4 6]

% Generate indices using matrix reshaping and transpose
indices_matrix = reshape(1:M*N, M, N);  % Create M×N matrix in row-major order
p = indices_matrix';                     % Transpose to get column-major indices
p = p(:)';                              % Flatten to 1D row vector

end