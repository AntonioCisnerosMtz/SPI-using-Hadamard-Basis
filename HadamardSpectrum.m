%% Initialization

clear, close all, clc           
%% User Parameters 

n = 6;         % Base parameter for Hadamard matrix size 
N = 2^n;
f_original = im2double(imread('cameraman.tif')); % Load image (uint8 to double conversion)
f = imresize(f_original, [N, N]);          % Resize image to NxN


HadamardOrder = 2; % 1=Natural, 2=Sequency, 3=Dyadic

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

F = H * f * H;

outputDir = 'C:\Users\annto\OneDrive\Doctorado\Paper\figures\MATLAB\';  %<================ change dir
currentFile = mfilename('fullpath');  
[~, filename] = fileparts(currentFile);  
outputDir = [outputDir, filename];
[status,msg] = mkdir(outputDir);

addpath('functions\');

% ========================================================================
% Parameters for better visualization
% if n == 1
%     FoSi = 56;
% elseif n == 2
%     FoSi = 46;
% elseif n == 3
%     FoSi = 30;
% elseif n == 4
%     FoSi = 16;
% elseif n == 5
%     FoSi = 8;
% else
%     FoSi = 0;
% 
% end 
% ========================================================================




%% M

     
%H = hadamard(N);
%I = zeros(N, N); 
[ny, nx] = size(H);
esp = 1/100;   
p = 1;         

%=========================================================================
% Hadamard Matrix N x N
clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(log(abs(F) + 1))
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'off', 'ygrid', 'off', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap jet


print(fullfile(outputDir, ['HadamardSpectrum_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['HadamardSpectrum_H', num2str(N), '_', Ordered]), '-depsc');

% %=========================================================================
clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(log(abs(F) + 1))
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'w', 'ycolor', 'w');
axis image
colormap jet


print(fullfile(outputDir, ['LabeledHadamardSpectrum_H', num2str(N), '_', Ordered]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['LabeledHadamardSpectrum_H', num2str(N), '_', Ordered]), '-depsc');
