function sign_change = optimized_sign_changes(input_matrix)
% OPTIMIZED_SIGN_CHANGES Counts sign changes using vectorized operations
%   Uses matrix operations instead of nested loops for better performance

% Validación de entrada
[rows, cols] = size(input_matrix);
if rows ~= cols
    error('Input must be a square matrix');
end
if any(input_matrix(:).^2 ~= 1)  
    error('Matrix must contain only +1 and -1 elements');
end

% Cálculo vectorizado de cambios de signo
diff_matrix = diff(input_matrix, 1, 2);          
sign_changes = sum(abs(diff_matrix) == 2, 2);    

% Preparar resultado final
sign_change = [(1:rows)' sign_changes];
end