function [IHT, t] = iterative_inverse_hadamard_transform_01(HT, method, num_trials)
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
    num_trials = 1;
else
    method = lower(method);
end

% Check if HT is square
[row, col] = size(HT);

N = row;

% if row ~= col
%     % error('Input matrix must be square.');
%     HT_temp = HT;
%     HT = zeros(N, N);
%     HT(1 : row, : ) = HT_temp;%%%%%%%%%%%%%%%%%%%
%     HT = HT';
% end

% Check if N is a power of 2
if bitand(N, N - 1) ~= 0
    error('N must be a power of 2.');
end

% Generate Hadamard matrix of size N^2
%M_size = col^2;
switch method
    case 'kronecker'
        H = kronecker_hadamard(N^2);
    case 'sylvester'
        H = sylvester_hadamard(N^2);
    case 'walsh'
        H = hadamard_sequency(N^2);
    case 'paley'
        H = hadamard_paley(N^2);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end



times = zeros(num_trials, 1);
for k = 1:num_trials
    tic;       
        IHT3 = zeros(N, N); % Initialize variables
        for i = 1 : row * col % Iterate over each row of the Hadamard matrix            
            contribution = HT(i) * reshape(H(i, :), [N, N]); % Compute contribution from the i-th row
            IHT3 = IHT3 + contribution;    
        end
        IHT = (1 / N) * IHT3; % Final result (100% completion)
    times(k) = toc;
end
t = median(times); % Use median for stable measurement

end