function [IHT, t] = iterative_inverse_hadamard_transform_01_GPU(HT, method, num_trials)
%ITERATIVE_INVERSE_HADAMARD Compute inverse Hadamard transform iteratively.
%   computes the inverse Hadamard transform of HT using an iterative approach.
%   METHOD can be 'kronecker' (default) or 'sylvester'.
%
%   Inputs:
%       HT - N x N transformed matrix (N must be a power of 2)
%       METHOD - Optional method string



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
    case 'zigzag'
        H = hadamard_zigzag(N^2);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end


reset(gpuDevice)
HT = gpuArray(single(HT));
H = gpuArray(single(H));


times = zeros(num_trials, 1);

for k = 1:num_trials
    tic;       
        IHT3 = zeros(N, N); % Initialize variables
        IHT3 = gpuArray(IHT3);
        for i = 1 : row * col % Iterate over each row of the Hadamard matrix            
            contribution = HT(i) * reshape(H(i, :), [N, N]); % Compute contribution from the i-th row
            IHT3 = IHT3 + contribution;    
        end
        IHT = (1 / N) * IHT3; % Final result (100% completion)
        wait(gpuDevice);
    times(k) = toc;
end
t = median(times); % Use median for stable measurement
IHT = gather(IHT);
reset(gpuDevice)




end