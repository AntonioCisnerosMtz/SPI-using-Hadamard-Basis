function sign_change = count_sign_changes(input_matrix)
% COUNT_SIGN_CHANGES Analyzes sign changes in a binary (±1) square matrix
%   sign_change = COUNT_SIGN_CHANGES(input_matrix) calculates the number
%   of sign changes between consecutive elements in each row of a matrix
%   extended with a duplicated last column.
%
%   Input:
%       input_matrix - Square matrix with elements +1 and -1
%   Output:
%       sign_change  - Matrix with row indices and sign change counts

% Validate input matrix
[rows, cols] = size(input_matrix);
if rows ~= cols
    error('Input must be a square matrix');
end
if any(~ismember(input_matrix(:), [1, -1]))
    error('Matrix must contain only +1 and -1 elements');
end

% Duplicate last column to create extended matrix
extended_matrix = [input_matrix, input_matrix(:, end)];

% Initialize result matrix
sign_change = zeros(rows, 2);
sign_change(:, 1) = (1:rows)';  % First column: row indices

% Count sign changes for each row
for row_idx = 1 : rows
    change_count = 0;
    % Compare each element with its next neighbor
    for col_idx = 1 : cols  % Original columns (N comparisons for N+1 elements)
        if extended_matrix(row_idx, col_idx) ~= extended_matrix(row_idx, col_idx+1)
            change_count = change_count + 1;
        end
    end
    sign_change(row_idx, 2) = change_count;
end
end