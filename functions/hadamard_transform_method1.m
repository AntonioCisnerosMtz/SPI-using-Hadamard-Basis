function HT = hadamard_transform_method1(f, method)
%HADAMARD_TRANSFORM Compute the Hadamard transform of a matrix.
%   HT = HADAMARD_TRANSFORM(X, METHOD) computes the Hadamard transform of X
%   using the specified METHOD ('kronecker' or 'sylvester'). If METHOD is
%   not provided, 'kronecker' is used by default.
%
%   Inputs:
%       X - Input matrix (must be square and size a power of 2)
%       METHOD - Optional string specifying the method ('kronecker' or 'sylvester')
%   Output:
%       HT - Hadamard transform of X

% Check input arguments
if nargin < 2
    method = 'kronecker';
else
    method = lower(method);
end

% Check if X is square
[N, M] = size(f);
if N ~= M
    error('Input matrix X must be square.');
end

% Generate Hadamard matrix
switch method
    case 'kronecker'
        H = kronecker_hadamard(N);
    case 'sylvester'
        H = sylvester_hadamard(N);
    case 'walsh'
        H = hadamard_sequency(N);
    case 'paley'
        H = hadamard_paley(N);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end

% Compute Hadamard transform
HT = H * f * H;

end