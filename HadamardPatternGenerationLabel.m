% HadamardPatternGeneration.m
% This script demonstrates three methods to generate and visualize Hadamard patterns.
% -------------------------------------------------------------------------------------

clear          % Clear workspace variables
close all      % Close all open figures
clc            % Clear command window

n = 2;         % Base parameter for Hadamard matrix size (2^n x 2^n)
%% Output directory configuration
outputDir = 'C:\Users\annto\OneDrive\Tesis\Figuras\matlab\';  % <--- 
filename = 'HadamardPatternGenerationLabeled_';
%% Method 1 - Hadamard Transform
% Generates patterns using Hadamard matrix multiplication: H * I * H
% ------------------------------------------------------------------
N = 2^n;       % Size of Hadamard matrix (2x2 for n=1)
H = hadamard(N); % Generate Hadamard matrix
I = zeros(N, N); % Initialize binary matrix I
[ny, nx] = size(H);
esp = 2/100;   % Spacing between subplots (5% of figure width/height)
p = 1;         % Subplot index counter


clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', 36);

print(fullfile(outputDir, [filename, 'HadamardMatrixLabeled_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, [filename, 'HadamardMatrixLabeled_', num2str(N), 'x', num2str(N)]), '-deps');



I(2,2) = 1;
I_vec = I;
fig2 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(I)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
add_matrix_annotations(I, 'NegativeValue', 0, 'FontSize', 36);
print(fullfile(outputDir, [filename, 'DeltaMatrix_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, [filename, 'DeltaMatrix_', num2str(N), 'x', num2str(N)]), '-deps');


I(2,2) = 0;


% Create Figure 1 at position (0,50) with size 400x400
fig3 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);

% Iterate over each element in matrix I
for row = 1 : N
    for col = 1 : N
        I(row,col) = 1;           % Activate (i,j) in I
        pat = H * I * H;          % Compute Hadamard pattern
        subplot_tight(N, N, p, [esp, esp]); % Compact subplot
        imagesc(pat)              % Display pattern
        % Format axes (remove labels, add grid)
        set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
            'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
            'xcolor', 'k', 'ycolor', 'k');
        axis image                % Equal aspect ratio
        colormap gray             % Grayscale colormap
        caxis([-1 1])             % Fix color limits to [-1,1]
        add_matrix_annotations(pat, 'FontSize', 12);
        I(row,col) = 0;           % Reset (i,j) in I
        p = p + 1;                % Increment subplot index
    end
end
print(fullfile(outputDir, [filename, 'HadamardPatters_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, [filename, 'HadamardPatters_', num2str(N), 'x', num2str(N)]), '-deps');


%% Method 2 - Hadamard Matrix * Vector
% Generates patterns by reshaping the product of Hadamard matrix and a vector.
% --------------------------------------------------------------------------
N = 4^n;               % Size of Hadamard matrix (4x4 for n=1)
H = hadamard(N);       % Generate Hadamard matrix
I = zeros(N, 1);       % Initialize binary vector I
[ny, nx] = size(H);
k = 1;                 % Index counter for subplot order calculation


fig4 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', 14);
print(fullfile(outputDir, [filename, 'HadamardMatrixLabeled_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, [filename, 'HadamardMatrixLabeled_', num2str(N), 'x', num2str(N)]), '-depsc', '-r300');


fig5 = createFigure('left', 400, 'bottom', 50, 'width', 100, 'height', 400);
imagesc(I_vec(:))
axis image
colormap gray
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
add_matrix_annotations(I_vec(:), 'NegativeValue', 0, 'FontSize', 14);
print(fullfile(outputDir, [filename, 'DeltaVector_', num2str(N), 'x', num2str(1)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, [filename, 'DeltaVector_', num2str(N), 'x', num2str(1)]), '-deps');


% Precompute subplot indices (p) for diagonal-like arrangement
for i = 1 : sqrt(N)
    c = -sqrt(N) + i;  
    for j = 1 : sqrt(N)
        c = c + sqrt(N);
        p(k) = c;      % Store subplot index
        k = k + 1;
    end
end

% Create Figure 2 at position (400,50) with size 400x400
fig6 = createFigure('left', 400, 'bottom', 50, 'width', 400, 'height', 400);



% Iterate over each element in vector I
for row = 1 : N
    I(row,1) = 1;                  % Activate row-th element in I
    pat = reshape( H * I, sqrt(N), sqrt(N)); % Reshape product into matrix
    subplot_tight(sqrt(N), sqrt(N), p(row), [esp, esp]); % Compact subplot
    imagesc(pat)                   % Display pattern
    % Format axes (same as Method 1)
    set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
        'xticklabel',{[]},'yticklabel',{[]});
    set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
        'xcolor', 'k', 'ycolor', 'k');
    add_matrix_annotations(pat, 'FontSize', 12);
    axis image
    colormap gray
    caxis([-1 1])
    I(row,1) = 0;                  % Reset row-th element in I
end

%% Method 3 - Reshape Hadamard Matrix Rows
% Directly reshapes rows of the Hadamard matrix into 2D patterns.
% ---------------------------------------------------------------
pat = ones(sqrt(N), sqrt(N)); % Placeholder for pattern
k = 1;                        % Row index counter

% Create Figure 3 at position (800,50) with size 400x400
fig7 = createFigure('left', 800, 'bottom', 50, 'width', 400, 'height', 400);

% Iterate over each row of H
for row = 1 : sqrt(N)
    for col = 1 : sqrt(N)
        pat = reshape(H(k,:), sqrt(N), sqrt(N)); % Reshape row into matrix
        subplot_tight(sqrt(N), sqrt(N), p(k), [esp, esp]); % Compact subplot
        imagesc(pat)                   % Display pattern
        % Format axes (same as previous methods)
        set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
            'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
            'xcolor', 'k', 'ycolor', 'k');
        axis image
        add_matrix_annotations(pat, 'FontSize', 12);
        colormap gray
        caxis([-1 1])
        k = k + 1;                % Move to next row
    end
end
%%