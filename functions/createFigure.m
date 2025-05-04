function hFig = createFigure(varargin)
%CREATEFIGURE Creates a figure with customizable position and size parameters.
%   hFig = CREATEFIGURE('left', value, 'bottom', value, 'width', value, 'height', value) 
%   creates a new figure with specified position and size. Unspecified parameters use defaults.
%
%   Inputs (Name-Value Pairs):
%       - 'left'   : Horizontal position of the figure's bottom-left corner (pixels). Default: 0.
%       - 'bottom' : Vertical position of the figure's bottom-left corner (pixels). Default: 0.
%       - 'width'  : Figure width (pixels). Default: 400.
%       - 'height' : Figure height (pixels). Default: 400.
%
%   Output:
%       - hFig    : Handle to the created figure.
%
%   Examples:
%       1. createFigure(); % Default position (0,0) and size (400x400).
%       2. createFigure('left', 50, 'bottom', 100); % Position (50,100), size 400x400.
%       3. createFigure('width', 800, 'height', 500); % Position (0,0), size 800x500.
%       4. createFigure('left', 200, 'height', 300); % Position (200,0), size 400x300.

    % --- Default parameters ---
    params.left = 0;
    params.bottom = 0;
    params.width = 400;
    params.height = 400;
    
    % --- Parse input parameters ---
    for i = 1:2:numel(varargin)
        paramName = varargin{i};
        paramValue = varargin{i+1};
        if isfield(params, paramName)
            params.(paramName) = paramValue;
        else
            error('Invalid parameter: "%s". Valid parameters are "left", "bottom", "width", "height".', paramName);
        end
    end
    
    % --- Persistent counter 'j' for figure numbering ---
    % - 'j' is declared as persistent to retain its value between function calls.
    % - It ensures each new figure gets a unique number, avoiding overlap with existing figures.
    % - Initialized to 0 on the first function call.
    % - Automatically increments by 1 every time the function is called.
    % - To reset 'j', use: clear createFigure.
    persistent j;
    if isempty(j)
        j = 0; % Initialize only once
    end
    j = j + 1; % Increment counter
    
    % --- Create the figure ---
    hFig = figure(j);
    set(hFig, ...
        'PaperPositionMode', 'auto', ...
        'Position', [params.left, params.bottom, params.width, params.height] ...
    );
end




%%
% 
% 
% ---
% 
% ### **Explicación detallada del parámetro `j` (incluida en comentarios internos):**
% El contador **`j`** dentro de la función tiene las siguientes características:  
% 1. **Persistencia**:  
%    - Al declararse como `persistent`, `j` **no se reinicia** cuando la función termina. Mantiene su valor entre llamadas.  
%    - Esto evita que nuevas figuras sobrescriban las anteriores (ej: siempre se crea Figura 1, Figura 2, etc.).  
% 
% 2. **Inicialización**:  
%    - En la primera llamada a `createFigure`, `j` se inicializa a 0. Luego, se incrementa a 1 para la primera figura.  
% 
% 3. **Automatización**:  
%    - Cada llamada incrementa `j` en 1, garantizando números de figura únicos y secuenciales.  
% 
% 4. **Reseteo**:  
%    - Para reiniciar el contador (ej: volver a `j = 0`), ejecute:  
%      ```matlab
%      clear createFigure
%      ```