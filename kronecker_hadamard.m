function H = kronecker_hadamard(n)
% Generate Sylvester-Hadamard matrix of order n (power of 2) using Kronecker product.
% Input:  n - Order of the matrix (must be a power of 2)
% Output: H - Hadamard matrix of order n

% Check if n is a positive integer and a power of 2
if n <= 0 || bitand(n, n-1) ~= 0
    error('n must be a positive integer power of 2 (e.g., 2, 4, 8, ...)');
end

% Base matrix
H_base = [1 1; 1 -1];

% Number of Kronecker products needed
k = log2(n);
H = H_base;

% Apply Kronecker product iteratively
for i = 1:k-1
    H = kron(H, H_base);
end
end

