% kronecker_hadamard_gpu_opt.m
function H = kronecker_hadamard_gpu(n)
% Generate Sylvester-Hadamard matrix on GPU using Kronecker products.
% Input:  n - Order of matrix (must be a power of 2)
% Output: H - Hadamard matrix (gpuArray)

% Validate input
if n <= 0 || bitand(n, n-1) ~= 0
    error('n must be a positive integer power of 2 (e.g., 2, 4, 8, ...)');
end

% Base matrix (GPU)
H_base = gpuArray([1 1; 1 -1]);

% Precompute required Kronecker depth
k = log2(n);
H = H_base;

% Iterate Kronecker products
for i = 1:k-1
    H = kron(H, H_base);  % GPU-accelerated Kronecker
end
end