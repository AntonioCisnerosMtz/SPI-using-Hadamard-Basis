
function HT = hadamard_transform_method2(X, method)
%HADAMARD_TRANSFORM2 Compute Hadamard transform using vectorized method.
%   HT = HADAMARD_TRANSFORM2(X, METHOD) computes the Hadamard transform of X
%   by vectorizing the input and using a Hadamard matrix of size N^2.
%   METHOD can be 'kronecker' (default) or 'sylvester'.
%
%   Inputs:
%       X - N x N matrix (N must be a power of 2)
%       METHOD - Optional method string
%   Output:
%       HT - Transformed matrix

% Default method
if nargin < 2
    method = 'kronecker';
else
    method = lower(method);
end

% Check if X is square
[row, col] = size(X);
if row ~= col
    error('Input matrix must be square.');
end

% Check if N is a power of 2
if bitand(row, row-1) ~= 0
    error('N must be a power of 2.');
end

% Generate Hadamard matrix of size N^2
%M_size = row^2;
switch method
    case 'kronecker'
        H = kronecker_hadamard(row^2);
    case 'sylvester'
        H = sylvester_hadamard(row^2);
    case 'walsh'
        H = hadamard_sequency(row^2);
    case 'paley'
        H = hadamard_paley(row^2);
    case 'zigzag'
        H = hadamard_zigzag(row^2);

    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end

% Compute transform
% X = X';%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%new
X_vec = X(:);
HT_vec = H * X_vec;
HT = reshape(HT_vec, [row, row]);
end