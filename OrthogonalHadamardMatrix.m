clear
close all
clc
%%
n = 4;
N = 2^n;
nx = N;
ny = N;
esp = 1/100;
f_original = im2double( imread('cameraman.tif') );
f = imresize(f_original,[N, N]);
%% Output directory configuration
outputDir = 'C:\Users\annto\OneDrive\Tesis\Figuras\matlab\';  % <--- 
filename = 'OrthogonalHadamardMatrix_';

%% Hadamard Matrix - Natural order
 
H1 = hadamard(N);

clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);

subplot_tight(1,1,1, esp)
imagesc(H1)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
caxis([-1 1])
%add_matrix_annotations(H, 'FontSize', 26);

print(fullfile(outputDir, [filename, 'NaturalHadamardMatrix_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, [filename, 'NaturalHadamardMatrix_', num2str(N), 'x', num2str(N)]), '-deps');

%% Hadamard Transform - Natural order

HT1 = H1 * f * H1;

fig2 = createFigure('left', 0, 'bottom', 450, 'width', 400, 'height', 400);

subplot_tight(1,1,1, esp)
imagesc(log(abs(HT1) + 1))
axis image
colormap jet
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');


print(fullfile(outputDir, [filename, 'NaturalHadamardTransform_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, [filename, 'NaturalHadamardTransform_', num2str(N), 'x', num2str(N)]), '-depsc');

figure
imagesc(H1 * HT1 * H1)
axis image
colormap gray
%% Hadamard Matrix - 
 
H2 = hadamard_sequency(N);

clear createFigure; % Clear persistent counter in createFigure (if needed)
fig3 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);

subplot_tight(1,1,1, esp)
imagesc(H2)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
caxis([-1 1])
%add_matrix_annotations(H, 'FontSize', 26);

% print(fullfile(outputDir, [filename, 'NaturalHadamardMatrix_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, [filename, 'NaturalHadamardMatrix_', num2str(N), 'x', num2str(N)]), '-deps');

%% Hadamard Transform - Natural order

HT2 = H2 * f * H2;

fig2 = createFigure('left', 0, 'bottom', 450, 'width', 400, 'height', 400);

subplot_tight(1,1,1, esp)
imagesc(log(abs(HT2) + 1))
axis image
colormap jet
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');


% print(fullfile(outputDir, [filename, 'NaturalHadamardTransform_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, [filename, 'NaturalHadamardTransform_', num2str(N), 'x', num2str(N)]), '-depsc');

figure
imagesc(H2 * HT2 * H2)
axis image
colormap gray