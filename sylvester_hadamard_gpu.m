
function H = sylvester_hadamard_gpu(n)
% Generate Sylvester-Hadamard matrix on GPU using iterative block doubling.
% Input:  n - Order of matrix (must be a power of 2)
% Output: H - Hadamard matrix (gpuArray)

% Validate input
if n <= 0 || bitand(n, n-1) ~= 0
    error('n must be a positive integer power of 2 (e.g., 2, 4, 8, ...)');
end

% Initialize base matrix on GPU
H = gpuArray(1);
current_size = 1;

% Iteratively double the matrix size
while current_size < n
    H = [H,  H;   % Block concatenation on GPU
         H, -H];
    current_size = current_size * 2;
end
end


