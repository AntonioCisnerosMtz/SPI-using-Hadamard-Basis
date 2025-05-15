%% Initialization

clear, close all, clc           
%% User Parameters 

n = 4;         % Base parameter for Hadamard matrix size 
N = 2^n;
% 
% HadamardOrder = 1; % 1=Natural, 2=Sequency, 3=Dyadic
% addpath('functions\')
% switch HadamardOrder
%     case 1 % Natural order (MATLAB's default Hadamard)
%         H = hadamard(N);
%         Ordered = 'Natural';
%     case 2 % Sequency order (Walsh-like frequency sorting)
%         H = hadamard_sequency(N);
%         Ordered = 'Sequency';
%     case 3 % Dyadic order (Bit-reversal permutation)
%         H = hadamard_dyadic(N);
%         Ordered = 'Dyadic';
%     otherwise
%         disp('Invalid');
% end

outputDir = 'C:\Users\annto\OneDrive\Doctorado\Paper\figures\MATLAB\';  %<================ change dir
currentFile = mfilename('fullpath');  
[~, filename] = fileparts(currentFile);  
outputDir = [outputDir, filename];
[status,msg] = mkdir(outputDir);



% ========================================================================
% Parameters for better visualization
if n == 1
    FoSi = 56;
elseif n == 2
    FoSi = 46;
elseif n == 3
    FoSi = 30;
elseif n == 4
    FoSi = 14;
elseif n == 5
    FoSi = 8;
elseif n == 6
    FoSi = 4;
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
fig1 = createFigure('left', 0, 'bottom', 50, 'width', 550, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', ...
    'xcolor', 'k', 'ycolor', 'k');
for i = 1 : N
    text(N+1,i, row_number_bin(i,:) ,'FontSize', FoSi , 'HorizontalAlignment', 'left')
end

for i = 1 : N
    text(0,i, num2str(sign_changes_natural(i,1)) ,'FontSize', FoSi , 'HorizontalAlignment', 'right')
end

axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', FoSi);

% print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-depsc');

%=========================================================================

H = hadamard_dyadic(N);
Ordered = 'Dyadic';
sign_changes_dyadic = count_sign_changes(H);

for i = 1 : N
    [row, ~] = find(sign_changes_natural(:,2) == sign_changes_dyadic(i,2));
    row_number_in_natural(i,:) = row - 1;
end
row_number_bin_in_natural = dec2bin(row_number_in_natural(:,1));


fig2 = createFigure('left', 550, 'bottom', 50, 'width', 550, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', ...
    'xcolor', 'k', 'ycolor', 'k');
for i = 1 : N
    text(N+1,i, row_number_bin_in_natural(i,:) ,'FontSize', FoSi , 'HorizontalAlignment', 'left')
end

for i = 1 : N
    text(0,i, num2str(row_number_in_natural(i,1)) ,'FontSize', FoSi , 'HorizontalAlignment', 'right')
end

axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', FoSi);
%=========================================================================
H = hadamard_sequency(N);
Ordered = 'Sequency';
sign_changes_sequency = count_sign_changes(H);

for i = 1 : N
    [row, ~] = find(sign_changes_natural(:,2) == sign_changes_sequency(i,2));
    row_number_in_natural(i,:) = row - 1;
end
%row_number_bin_in_natural = dec2bin(row_number_in_natural(:,1));


fig2 = createFigure('left', 1100, 'bottom', 50, 'width', 550, 'height', 400);
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