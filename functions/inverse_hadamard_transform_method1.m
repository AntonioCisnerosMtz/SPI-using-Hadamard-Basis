function IHT = inverse_hadamard_transform_method1(HT, method)
%INVERSE_HADAMARD_TRANSFORM Compute the inverse Hadamard transform of a matrix.
%   IHT = INVERSE_HADAMARD_TRANSFORM(HT, METHOD) computes the inverse
%   Hadamard transform of HT using the specified METHOD. If METHOD is not
%   provided, 'kronecker' is used by default.
%
%   Inputs:
%       HT - Hadamard transformed matrix (must be square and size a power of 2)
%       METHOD - Optional string specifying the method ('kronecker' or 'sylvester')
%   Output:
%       IHT - Inverse Hadamard transform of HT

% Check input arguments
if nargin < 2
    method = 'kronecker';
else
    method = lower(method);
end

% Check if HT is square
[N, M] = size(HT);
if N ~= M
    error('Input matrix HT must be square.');
end

% Generate Hadamard matrix
switch method
    case 'kronecker'
        H = kronecker_hadamard(N);
    case 'sylvester'
        H = sylvester_hadamard(N);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end

% Compute inverse Hadamard transform
IHT = (1/(N^2)) * H * HT * H;

