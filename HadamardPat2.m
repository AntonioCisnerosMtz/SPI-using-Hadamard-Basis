
%% Clear workspace, close figures, and clear command window
clear var;
close all;
clc;

%% Output directory configuration
outputDir = 'C:\Users\annto\OneDrive\Tesis\Figuras\matlab\';  % <--- Añade esta línea
%mkdir(outputDir);  % Crea el directorio si no existe              % <--- Añade esta línea

%% Generate Hadamard matrix
n = 5;          
N = 4^n;
H = hadamard(N);            
[ny, nx] = size(H);         
gridOnOff = 'off';
esp2 = 0.3/100;                

%% FIGURE 1: Visualize full Hadamard matrix

clear createFigure;          
fig1 = createFigure('left', 200, 'bottom', 150, 'width', 400, 'height', 400);


esp = 1/100;                  

subplot_tight(1, 1, 1, esp);
imagesc(H);                 
axis image;                 
colormap gray;              

set(gca, ...
    'xtick', linspace(0.5, nx+0.5, nx+1), ...
    'ytick', linspace(0.5, ny+0.5, ny+1), ...
    'xticklabel', {[]}, 'yticklabel', {[]}, ...
    'xgrid', gridOnOff, 'ygrid', gridOnOff, ...
    'gridlinestyle', '-', 'xcolor', 'k', 'ycolor', 'k');

% Guardar en la ruta especificada (cambios aquí ▼)
print(fullfile(outputDir, ['HadamardMatrix_', num2str(N), 'x', num2str(N), '_paper']), '-dpng', '-r300');
print(fullfile(outputDir, ['HadamardMatrix_', num2str(N), 'x', num2str(N), '_paper']), '-deps', '-r300');


%% FIGURE 2: Visualize individual Hadamard patterns

fig2 = createFigure('left', 200, 'bottom', 150, 'width', 400, 'height', 400);
p = 1;                      
% esp2 = 1/100;                

for i = 1:sqrt(N)           
    for j = 1:sqrt(N)       
        pat = reshape(H(:, p), sqrt(N), sqrt(N));
        
        subplot_tight(sqrt(N), sqrt(N), p, esp2);
        imagesc(pat');      
        axis image;         
        caxis([-1 1]);      
        colormap gray
        set(gca, ...
            'xtick', linspace(0.5, nx+0.5, nx+1), ...
            'ytick', linspace(0.5, ny+0.5, ny+1), ...
            'xticklabel', {[]}, 'yticklabel', {[]}, ...
            'xgrid', gridOnOff, 'ygrid', gridOnOff, ...
            'gridlinestyle', '-', 'xcolor', 'k', 'ycolor', 'k');
        
        p = p + 1;         
    end
end

% Guardar en la ruta especificada con nombre corregido (cambios aquí ▼)
print(fullfile(outputDir, ['HadamardPat_', num2str(sqrt(N)), 'x', num2str(sqrt(N)), '_paper']), '-dpng', '-r300');
print(fullfile(outputDir, ['HadamardPat_', num2str(sqrt(N)), 'x', num2str(sqrt(N)), '_paper']), '-deps', '-r300');  % Nombre corregido
