function [IHT, t] = inverse_hadamard_transform_method2_GPU(HT, method, num_trials)
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
    num_trials = 1;
else
    method = lower(method);
end

% Check if HT is square
[row, col] = size(HT);
if row ~= col
    %error('Input matrix must be square.');
    HT_temp = HT;
    HT = zeros(col, col);
    HT(1 : row, : ) = HT_temp;
    
end


% Check if N is a power of 2
if bitand(col, col-1) ~= 0
    error('N must be a power of 2.');
end

reset(gpuDevice)
% Generate Hadamard matrix of size N^2
M_size = col^2;
switch method
    case 'kronecker'
        H = kronecker_hadamard(M_size);
    case 'sylvester'
        H = sylvester_hadamard(M_size);
    case 'walsh'
        H = hadamard_sequency(M_size);
    case 'paley'
        H = hadamard_paley(M_size);
    case 'zigzag'
        H = hadamard_zigzag(M_size);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end

% Compute inverse transform
% HT = HT';

reset(gpuDevice)
HT = gpuArray(HT);
H = gpuArray(H);


times = zeros(num_trials, 1);
for k = 1:num_trials
    tic;
    %HT_vec = HT(:);
    IHT_vec = (1 / M_size) * H' * HT(:);
    IHT = reshape(IHT_vec, [col, col]);
    wait(gpuDevice);
    times(k) = toc;
    
end
t = median(times); % Use median for stable measurement
IHT = gather(IHT);
reset(gpuDevice)
end

