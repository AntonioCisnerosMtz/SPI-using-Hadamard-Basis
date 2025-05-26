function wp_matrix = hadamard_paley(N)
% WALSH_PALEY_MATRIX Generates the Walsh-Paley matrix of order N.
%   Input:  N - Size of the matrix (must be a power of 2).
%   Output: wp_matrix - N x N Walsh-Paley matrix.

    % Check if N is a power of 2
    if (N < 1) || (bitand(N, N-1) ~= 0)
        error('N must be a power of 2.');
    end

    % Base case: N = 1
    if N == 1
        wp_matrix = 1;
        return;
    end

    % Recursive step: Construct matrix of size N/2
    prev_matrix = hadamard_paley(N/2);
    
    % Build upper and lower blocks using Kronecker product
    upper_block = kron(prev_matrix, [1, 1]);   % P_{N/2} ⊗ [1 1]
    lower_block = kron(prev_matrix, [1, -1]);  % P_{N/2} ⊗ [1 -1]
    
    % Combine blocks vertically
    wp_matrix = [upper_block; lower_block];
end