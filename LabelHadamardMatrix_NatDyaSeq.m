%% Initialization

clear, close all, clc           
%% User Parameters 

n = 3;         % Base parameter for Hadamard matrix size 
N = 2^n;


addpath('functions\')


outputDir = 'C:\Users\annto\OneDrive\Doctorado\Paper\figures\MATLAB\';  %<================ change dir
currentFile = mfilename('fullpath');  
[~, filename] = fileparts(currentFile);  
outputDir = [outputDir, filename];
[status,msg] = mkdir(outputDir);



% ========================================================================
% Parameters for better visualization
if n == 1
    FoSi = 26;
    figure_width = 600
elseif n == 2
    FoSi = 26;
    figure_width = 600;
elseif n == 3
    FoSi = 24;
    figure_width = 600;
elseif n == 4
    FoSi = 14;
    figure_width = 550;
elseif n == 5
    FoSi = 8;
    figure_width = 570;
elseif n == 6
    FoSi = 4;
    figure_width = 570;
else
    FoSi = 0;

end 
% ========================================================================




%% M
H = hadamard(N);
Ordered = 'Natural';
     
[ny, nx] = size(H);
esp = 1/100;   
p = 1;         

sign_changes_natural = count_sign_changes(H);
row_number_bin = dec2bin(sign_changes_natural(:,1));
%=========================================================================

clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 50, 'width', figure_width, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', ...
    'xcolor', 'k', 'ycolor', 'k');
for i = 1 : N
    text(N + 1,i, num2str(sign_changes_natural(i,2)) ,'FontSize', FoSi , 'HorizontalAlignment', 'left')
end

for i = 1 : N
    text(0,i, num2str(sign_changes_natural(i,1)) ,'FontSize', FoSi , 'HorizontalAlignment', 'right')
end

axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', FoSi);

print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-depsc');

%=========================================================================

H = hadamard_paley(N);
Ordered = 'Dyadic';
sign_changes_dyadic = count_sign_changes(H);

for i = 1 : N
    [row, ~] = find(sign_changes_natural(:,2) == sign_changes_dyadic(i,2));
    row_number_in_natural(i,:) = row - 1;
end
%row_number_bin_in_natural = dec2bin(row_number_in_natural(:,1));
gray_code_sing_change_dyadic = dec2bin(sign_changes_dyadic(:,2));



fig2 = createFigure('left', figure_width, 'bottom', 50, 'width', figure_width, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', ...
    'xcolor', 'k', 'ycolor', 'k');

for i = 1 : N
    text(N + 1,i, num2str(sign_changes_dyadic(i,2)) ,'FontSize', FoSi , 'HorizontalAlignment', 'left')
end

% for i = 1 : N
%     %text(N+1,i, row_number_bin_in_natural(i,:) ,'FontSize', FoSi , 'HorizontalAlignment', 'left')
%     text(N + 2.4,i, gray_code_sing_change_dyadic(i,:) ,'FontSize', FoSi , 'HorizontalAlignment', 'left')
% end

for i = 1 : N
    text(0,i, num2str(row_number_in_natural(i,1)) ,'FontSize', FoSi , 'HorizontalAlignment', 'right')
end

axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', FoSi);



print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-depsc');
%=========================================================================
H = hadamard_sequency(N);
Ordered = 'Sequency';
sign_changes_sequency = count_sign_changes(H);

for i = 1 : N
    [row, ~] = find(sign_changes_natural(:,2) == sign_changes_sequency(i,2));
    row_number_in_natural(i,:) = row - 1;
end
%row_number_bin_in_natural = dec2bin(row_number_in_natural(:,1));


fig2 = createFigure('left', figure_width*2, 'bottom', 50, 'width', figure_width , 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', ...
    'xcolor', 'k', 'ycolor', 'k');
for i = 1 : N
    text(N+1,i, num2str(sign_changes_sequency(i,2)) ,'FontSize', FoSi , 'HorizontalAlignment', 'left')
end

for i = 1 : N
    text(0,i, num2str(row_number_in_natural(i,1)) ,'FontSize', FoSi , 'HorizontalAlignment', 'right')
end

axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', FoSi);

print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-depsc');