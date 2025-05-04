% sylvester_hadamard.m
function H = sylvester_hadamard(n)
% Generate Sylvester-Hadamard matrix of order n (power of 2) using recursion.
% Input:  n - Order of the matrix (must be a power of 2)
% Output: H - Hadamard matrix of order n

% Check if n is a positive integer and a power of 2
if n <= 0 || bitand(n, n-1) ~= 0
    error('n must be a positive integer power of 2 (e.g., 2, 4, 8, ...)');
end

% Base case
if n == 1
    H = 1;
    return;
end

% Recursive construction
m = n / 2;
H_prev = sylvester_hadamard(m);
H = [H_prev,  H_prev;
     H_prev, -H_prev];
end

