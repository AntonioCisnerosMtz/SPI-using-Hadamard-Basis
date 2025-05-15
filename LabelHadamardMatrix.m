%% Initialization

clear, close all, clc           
%% User Parameters 

n = 5;         % Base parameter for Hadamard matrix size 
N = 2^n;
% 
HadamardOrder = 2; % 1=Natural, 2=Sequency, 3=Dyadic
addpath('functions\')
switch HadamardOrder
    case 1 % Natural order (MATLAB's default Hadamard)
        H = hadamard(N);
        Ordered = 'Natural';
    case 2 % Sequency order (Walsh-like frequency sorting)
        H = hadamard_sequency(N);
        Ordered = 'Sequency';
    case 3 % Dyadic order (Bit-reversal permutation)
        H = hadamard_dyadic(N);
        Ordered = 'Dyadic';
    otherwise
        disp('Invalid');
end

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

     
%H = hadamard(N);
%I = zeros(N, N); 
[ny, nx] = size(H);
esp = 1/100;   
p = 1;         

sign_changes = count_sign_changes(H);

%=========================================================================
% Hadamard Matrix N x N
clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', ...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
caxis([-1 1])
%add_matrix_annotations(H, 'FontSize', 46);

% print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['LabeledHadamardMatrix_H', num2str(N), '_', Ordered]), '-depsc');

%=========================================================================
fig2 = createFigure('left', 400, 'bottom', 50, 'width', 600, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H)
% Format axes (remove labels, add grid)

set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
for i = 1 : N
    text(N+1,i,num2str(sign_changes(i,2)),'FontSize', FoSi , 'HorizontalAlignment', 'left')
end
axis image
colormap gray
caxis([-1 1])
add_matrix_annotations(H, 'FontSize', FoSi);

% print(fullfile(outputDir, ['HadamardMatrix_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['HadamardMatrix_H', num2str(N), '_', Ordered]), '-deps');
