function add_matrix_annotations(H, varargin)
% ADD_MATRIX_ANNOTATIONS Overlays matrix values on imagesc plot with automatic text coloring
%   add_matrix_annotations(H) adds values from matrix H centered in each pixel
%   add_matrix_annotations(H, 'Parameter', Value) allows customization:
%
%   Optional parameters:
%   - 'FontSize'       : Text size (default = 14)
%   - 'FontWeight'     : 'normal' | 'bold' (default = 'normal')
%   - 'PositiveValue'  : Value considered positive (default = 1)
%   - 'NegativeValue'  : Value considered negative (default = -1)
%
%   Example:
%     H = hadamard(4);
%     imagesc(H);
%     axis image; colormap gray; caxis([-1 1]);
%     add_matrix_annotations(H, 'FontSize', 16, 'FontWeight', 'bold');

% Parse input parameters
p = inputParser;
addRequired(p, 'H', @ismatrix);
addParameter(p, 'FontSize', 14, @isnumeric);
addParameter(p, 'FontWeight', 'normal', @(x) ismember(x, {'normal','bold'}));
addParameter(p, 'PositiveValue', 1, @isnumeric);
addParameter(p, 'NegativeValue', -1, @isnumeric);
parse(p, H, varargin{:});

% Get matrix dimensions
[rows, cols] = size(H);

% Add annotations
hold on;
for i = 1:rows
    for j = 1:cols
        current_value = H(i,j);
        
        % Validate allowed values
        if current_value ~= p.Results.PositiveValue && ...
           current_value ~= p.Results.NegativeValue
            error('Matrix contains values outside specified positive/negative ranges');
        end
        
        % Determine text color
        if current_value == p.Results.PositiveValue
            text_color = [0 0 0];  % Black for positive values
        else
            text_color = [1 1 1];  % White for negative values
        end
        
        % Create annotation
        text(j, i, num2str(current_value),...
            'HorizontalAlignment', 'center',...
            'Color', text_color,...
            'FontSize', p.Results.FontSize,...
            'FontWeight', p.Results.FontWeight);
    end
end
hold off;
end