function [IHT_full, IHT_25, IHT_50, IHT_75] = iterative_inverse_hadamard_transform_02(HT, method)
%ITERATIVE_INVERSE_HADAMARD Compute inverse Hadamard transform iteratively.
%   [IHT_full, IHT_25, IHT_50, IHT_75] = ITERATIVE_INVERSE_HADAMARD(HT, METHOD)
%   computes the inverse Hadamard transform of HT using an iterative approach.
%   Intermediate results are returned at 25%%, 50%%, 75%%, and 100%% completion.
%   METHOD can be 'kronecker' (default) or 'sylvester'.
%
%   Inputs:
%       HT - N x N transformed matrix (N must be a power of 2)
%       METHOD - Optional method string
%   Outputs:
%       IHT_full - Final inverse transformed matrix (100%% completion)
%       IHT_25 - Intermediate result at 25%% completion
%       IHT_50 - Intermediate result at 50%% completion
%       IHT_75 - Intermediate result at 75%% completion

% Default method
if nargin < 2
    method = 'kronecker';
else
    method = lower(method);
end

% Check if HT is square
[row, col] = size(HT);
if row ~= col
    error('Input matrix must be square.');
end

% Check if N is a power of 2
if bitand(row, row-1) ~= 0
    error('N must be a power of 2.');
end

% Generate Hadamard matrix of size N^2
M_size = row^2;
switch method
    case 'kronecker'
        H = kronecker_hadamard(M_size);
    case 'sylvester'
        H = sylvester_hadamard(M_size);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end

% Initialize variables
IHT3 = zeros(row, row);
IHT_25 = [];
IHT_50 = [];
IHT_75 = [];

% Iterate over each row of the Hadamard matrix
for i = 1:M_size
    % Compute contribution from the i-th row
    contribution = HT(i) * reshape(H(i, :)', [row, row]);
    IHT3 = IHT3 + contribution;
    
    % Save intermediate results
    if i == round(M_size / 4)
        IHT_25 = (1 / M_size) * IHT3; % 25% completion
    elseif i == round(M_size / 2)
        IHT_50 = (1 / M_size) * IHT3; % 50% completion
    elseif i == round(3 * M_size / 4)
        IHT_75 = (1 / M_size) * IHT3; % 75% completion
    end
end

% Final result (100% completion)
IHT_full = (1 / col^2) * IHT3;

end