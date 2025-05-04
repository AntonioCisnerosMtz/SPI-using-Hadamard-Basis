function IHT = inverse_hadamard_transform_method2(HT, method)
%INVERSE_HADAMARD_TRANSFORM2 Compute inverse Hadamard transform using vectorized method.
%   IHT = INVERSE_HADAMARD_TRANSFORM2(HT, METHOD) computes the inverse
%   transform by vectorizing HT and using a Hadamard matrix of size N^2.
%   METHOD can be 'kronecker' (default) or 'sylvester'.
%
%   Inputs:
%       HT - N x N transformed matrix
%       METHOD - Optional method string
%   Output:
%       IHT - Inverse transformed matrix

% Default method
if nargin < 2
    method = 'kronecker';
else
    method = lower(method);
end

% Check if HT is square
[N, M] = size(HT);
if N ~= M
    error('Input matrix must be square.');
end

% Check if N is a power of 2
if bitand(N, N-1) ~= 0
    error('N must be a power of 2.');
end

% Generate Hadamard matrix of size N^2
M_size = N^2;
switch method
    case 'kronecker'
        H = kronecker_hadamard(M_size);
    case 'sylvester'
        H = sylvester_hadamard(M_size);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end

% Compute inverse transform
HT_vec = HT(:);
IHT_vec = (1 / M_size) * H * HT_vec;
IHT = reshape(IHT_vec, [N, N]);
end