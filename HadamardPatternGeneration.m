% ========================================================================
% Script: HadamardPatternGenerationLabel.m
% Purpose: Generates and visualizes Hadamard matrices and their derived 
%          patterns in three orders (Natural, Sequency, Dyadic) using 
%          three distinct methods. Outputs are saved as labeled images.
% 
% Key Features:
%   - Configurable matrix size (n=2 by default, N=2^n).
%   - Supports Natural, Sequency, and Dyadic Hadamard matrix orderings.
%   - Three pattern-generation methods with grid visualizations.
%   - Automatic annotations (1/-1 values) with contrast colors.
%   - Tight subplot spacing and figure positioning.
%   - Outputs PNG (raster) and EPS (vector) formats for publication.
%
% Dependencies:
%   - createFigure.m        : Manages figure positioning/sizing.
%   - subplot_tight.m       : Controls subplot margins.
%   - SubplotIndicesByColumn.m : Arranges subplots column-wise.
%   - hadamard_dyadic.m     : Dyadic-ordered Hadamard matrix.
%   - hadamard_sequency.m   : Sequency-ordered Hadamard matrix.
%   - add_matrix_annotations.m : Adds 1/-1 labels to matrix plots.
% ========================================================================
%% Initialization

clear, close all, clc           
%% User Parameters 

n = 2;         % Base parameter for Hadamard matrix size 
N = 2^n;
HadamardOrder = 1; % 1=Natural, 2=Sequency, 3=Dyadic

switch HadamardOrder
    case 1 % Natural order (MATLAB's default Hadamard)
        H1 = hadamard(N);
        H2 = hadamard(N^2);
        Ordered = 'Natural';
    case 2 % Sequency order (Walsh-like frequency sorting)
        H1 = hadamard_sequency(N);
        H2 = hadamard_sequency(N^2);
        Ordered = 'Sequency';
    case 3 % Dyadic order (Bit-reversal permutation)
        H1 = hadamard_dyadic(N);
        H2 = hadamard_dyadic(N^2);
        Ordered = 'Dyadic';
    otherwise
        disp('Invalid');
end

outputDir = 'C:\Users\annto\OneDrive\Doctorado\Paper\figures\MATLAB\';  %<================ change dir
currentFile = mfilename('fullpath');  
[~, filename] = fileparts(currentFile);  
outputDir = [outputDir, filename];
[status,msg] = mkdir(outputDir);
addpath('functions\');

% ========================================================================
% Parameters for better visualization
if n == 1
    esp2 = 6/100; 
    gridOnOff = 'on';
elseif n == 2
    esp2 = 4/100; 
    gridOnOff = 'on';
elseif n == 3
    esp2 = 2/100; 
    gridOnOff = 'on';
elseif n == 4
    esp2 = 1/100; 
    gridOnOff = 'off';
elseif n == 5
    esp2 = 0.5/100; 
    gridOnOff = 'off';

end 
% ========================================================================




%% Method 1: Hadamard Transform (H * I * H)
% Creates NxN patterns by iteratively placing a delta (1) in matrix I and 
% computing H1*I*H1. Patterns are arranged in an NxN grid.

N = 2^n;       

I = zeros(N, N); 
[ny, nx] = size(H1);
esp = 2/100;   
p = 1;         


% Hadamard Matrix N x N
clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 550, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H1)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
caxis([-1 1])
%add_matrix_annotations(H1, 'FontSize', 36);

print(fullfile(outputDir, ['HadamardMatrix', Ordered, '_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['HadamardMatrix', Ordered, '_', num2str(N), 'x', num2str(N)]), '-deps');


% ========================================================================
% Delta Matrix

% I(2,2) = 1;
% I_vec = I;
% fig2 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
% subplot_tight(1,1,1, esp)
% imagesc(I)
% % Format axes (remove labels, add grid)
% set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
%     'xticklabel',{[]},'yticklabel',{[]});
% set(gca,'xgrid', gridOnOff, 'ygrid', gridOnOff, 'gridlinestyle', '-',...
%     'xcolor', 'k', 'ycolor', 'k');
% axis image
% colormap gray
% %add_matrix_annotations(I, 'NegativeValue', 0, 'FontSize', 36);
% print(fullfile(outputDir, [filename, '_DeltaMatrix_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, [filename, '_DeltaMatrix_', num2str(N), 'x', num2str(N)]), '-deps');

% ========================================================================
% Hadamard Patterns 
%I(2,2) = 0;
fig3 = createFigure('left', 400, 'bottom', 550, 'width', 400, 'height', 400);
% Iterate over each element in matrix I
for row = 1 : N
    for col = 1 : N
        I(row,col) = 1;           
        pat = H1 * I * H1;          
        subplot_tight(N, N, p, [esp2, esp2]); 
        imagesc(pat)              
        % Format axes (remove labels, add grid)
        set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
            'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', gridOnOff, 'ygrid', gridOnOff, 'gridlinestyle', '-',...
            'xcolor', 'k', 'ycolor', 'k');
        axis image                
        colormap gray             
        caxis([-1 1])             
        %add_matrix_annotations(pat, 'FontSize', 12);
        I(row,col) = 0;           
        p = p + 1;                %
    end
end
print(fullfile(outputDir, ['HadamardPatters', Ordered, '01_', num2str((N)), 'x', num2str((N))]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['HadamardPatters', Ordered, '01_', num2str((N)), 'x', num2str((N))]), '-deps');


%% Method 2: Hadamard-Vector Multiplication (H2 * delta vector)
% Generates N^2 patterns by multiplying H2 (N^2xN^2) with delta vectors, 
% then reshaping results into sqrt(N)xsqrt(N) grids---------------------------------------------------------------------

N = N^2;
I = zeros(N, 1);       
[ny, nx] = size(H2);
k = 1;                 


% Hadamard Matrix N^2 x N^2
fig4 = createFigure('left', 0, 'bottom', 50, 'width', 400, 'height', 400);
subplot_tight(1,1,1, esp)
imagesc(H2)
% Format axes (remove labels, add grid)
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
    'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k');
axis image
colormap gray
caxis([-1 1])
%add_matrix_annotations(H2, 'FontSize', 14);
print(fullfile(outputDir, ['HadamardMatrix', Ordered, '_', num2str(N), 'x', num2str(N)]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['HadamardMatrix', Ordered, '_', num2str(N), 'x', num2str(N)]), '-deps', '-r300');

% ========================================================================
% Delta vector

% fig5 = createFigure('left', 400, 'bottom', 50, 'width', 100, 'height', 400);
% imagesc(I_vec(:))
% axis image
% colormap gray
% set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),...
%     'xticklabel',{[]},'yticklabel',{[]});
% set(gca,'xgrid', gridOnOff, 'ygrid', gridOnOff, 'gridlinestyle', '-',...
%     'xcolor', 'k', 'ycolor', 'k');
% %add_matrix_annotations(I_vec(:), 'NegativeValue', 0, 'FontSize', 14);
% 
% print(fullfile(outputDir, [filename, '_DeltaVector_', num2str(N), 'x', num2str(1)]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, [filename, '_DeltaVevtor_', num2str(N), 'x', num2str(1)]), '-deps');



% ========================================================================
% Hadamard Patterns
p = SubplotIndicesByColumn(sqrt(N),sqrt(N));
fig6 = createFigure('left', 400, 'bottom', 50, 'width', 400, 'height', 400);

% Iterate over each element in vector I
for row = 1 : N
    I(row,1) = 1;                  
    pat = reshape( H2 * I, sqrt(N), sqrt(N)); 
    subplot_tight(sqrt(N), sqrt(N), p(row), [esp2, esp2]); 
    imagesc(pat)                   
    % Format axes (same as Method 1)
    set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
        'xticklabel',{[]},'yticklabel',{[]});
    set(gca,'xgrid', gridOnOff, 'ygrid', gridOnOff, 'gridlinestyle', '-',...
        'xcolor', 'k', 'ycolor', 'k');
    %add_matrix_annotations(pat, 'FontSize', 12);
    axis image
    colormap gray
    caxis([-1 1])
    I(row,1) = 0;                  
end
print(fullfile(outputDir, ['HadamardPatters', Ordered, '02_', num2str(sqrt(N)), 'x', num2str(sqrt(N))]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['HadamardPatters', Ordered, '02_', num2str(sqrt(N)), 'x', num2str(sqrt(N))]), '-deps');
%% Method 3: Direct Row Reshaping of H2
% Reshapes each row of H2 into sqrt(N)xsqrt(N) patterns, visualizing them 
% in a grid.
pat = ones(sqrt(N), sqrt(N)); % Placeholder for pattern
k = 1;                        % Row index counter
p = SubplotIndicesByColumn(sqrt(N),sqrt(N));

% Create Figure 3 at position (800,50) with size 400x400
fig7 = createFigure('left', 800, 'bottom', 50, 'width', 400, 'height', 400);

% Iterate over each row of H
for row = 1 : sqrt(N)
    for col = 1 : sqrt(N)
        pat = reshape(H2(k,:), sqrt(N), sqrt(N)); 
        subplot_tight(sqrt(N), sqrt(N), p(k), [esp2, esp2]); 
        imagesc(pat)                   % Display pattern
        % Format axes (same as previous methods)
        set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
            'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', gridOnOff, 'ygrid', gridOnOff, 'gridlinestyle', '-',...
            'xcolor', 'k', 'ycolor', 'k');
        axis image
        %add_matrix_annotations(pat, 'FontSize', 12);
        colormap gray
        caxis([-1 1])
        k = k + 1;                % Move to next row
    end
end

print(fullfile(outputDir, ['HadamardPatters', Ordered, '03_', num2str(sqrt(N)), 'x', num2str(sqrt(N))]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['HadamardPatters', Ordered, '03_', num2str(sqrt(N)), 'x', num2str(sqrt(N))]), '-deps');

%% Individual patterns Label

% pat = ones(sqrt(N), sqrt(N)); % Placeholder for pattern
% k = 1;                        % Row index counter
% 
% % Create Figure 3 at position (800,50) with size 400x400
% fig8 = createFigure('left', 800, 'bottom', 550, 'width', 400, 'height', 400);
% 
% % Iterate over each row of H
% for row = 1 : sqrt(N)
%     for col = 1 : sqrt(N)
%         pat = reshape(H2(k,:), sqrt(N), sqrt(N)); % Reshape row into matrix
%         subplot_tight(1, 1, 1, [esp, esp]); % Compact subplot
%         imagesc(pat)                   % Display pattern
%         % Format axes (same as previous methods)
%         set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
%             'xticklabel',{[]},'yticklabel',{[]});
%         set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
%             'xcolor', 'k', 'ycolor', 'k');
%         axis image
%         %add_matrix_annotations(pat, 'FontSize', 36);
%         colormap gray
%         caxis([-1 1])
% 
% 
%         print(fullfile(outputDir, ['IndividualHadamardPatters', Ordered, '03_', num2str(N), 'x', num2str(N), '_', num2str(k)]), '-dpng', '-r300');
%         set(gcf,'Renderer','painters');
%         print(fullfile(outputDir, ['IndividualHadamardPatters', Ordered, '03_', num2str(N), 'x', num2str(N), '_', num2str(k)]), '-deps');
%         k = k + 1;                % Move to next row
%     end
% end


%% Individual patterns - positive

% pat = ones(sqrt(N), sqrt(N)); % Placeholder for pattern
% k = 1;                        % Row index counter
% 
% % Create Figure 3 at position (800,50) with size 400x400
% fig8 = createFigure('left', 800, 'bottom', 550, 'width', 400, 'height', 400);
% 
% % Iterate over each row of H
% for row = 1 : sqrt(N)
%     for col = 1 : sqrt(N)
%         pat = reshape(H2(k,:), sqrt(N), sqrt(N)); % Reshape row into matrix
%         pat = (pat + 1)/2;
%         subplot_tight(1, 1, 1, [esp, esp]); % Compact subplot
%         imagesc(pat)                   % Display pattern
%         % Format axes (same as previous methods)
%         set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
%             'xticklabel',{[]},'yticklabel',{[]});
%         set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
%             'xcolor', 'k', 'ycolor', 'k');
%         axis image
%         %add_matrix_annotations(pat, 'FontSize', 36, 'NegativeValue', 0);
%         colormap gray
%         caxis([0 1])
% 
%         print(fullfile(outputDir, ['IndividualHadamardPattersPositive', Ordered, '03_', num2str(N), 'x', num2str(N), '_', num2str(k)]), '-dpng', '-r300');
%         set(gcf,'Renderer','painters');
%         print(fullfile(outputDir, ['IndividualHadamardPattersPositive', Ordered, '03_', num2str(N), 'x', num2str(N), '_', num2str(k)]), '-deps');
%         k = k + 1;                % Move to next row
%     end
% end
%% Individual patterns - negative


% pat = ones(sqrt(N), sqrt(N)); % Placeholder for pattern
% k = 1;                        % Row index counter
% 
% % Create Figure 3 at position (800,50) with size 400x400
% fig8 = createFigure('left', 800, 'bottom', 550, 'width', 400, 'height', 400);
% 
% % Iterate over each row of H
% for row = 1 : sqrt(N)
%     for col = 1 : sqrt(N)
%         pat = reshape(H2(k,:), sqrt(N), sqrt(N)); % Reshape row into matrix
%         pat = (1 - pat)/2;
%         subplot_tight(1, 1, 1, [esp, esp]); % Compact subplot
%         imagesc(pat)                   % Display pattern
%         % Format axes (same as previous methods)
%         set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
%             'xticklabel',{[]},'yticklabel',{[]});
%         set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
%             'xcolor', 'k', 'ycolor', 'k');
%         axis image
%         %add_matrix_annotations(pat, 'FontSize', 36, 'NegativeValue', 0);
%         colormap gray
%         caxis([0 1])
% 
%         print(fullfile(outputDir, ['IndividualHadamardPattersNegative', Ordered, '03_', num2str(N), 'x', num2str(N), '_', num2str(k)]), '-dpng', '-r300');
%         set(gcf,'Renderer','painters');
%         print(fullfile(outputDir, ['IndividualHadamardPattersNegative', Ordered, '03_', num2str(N), 'x', num2str(N), '_', num2str(k)]), '-deps');
%         k = k + 1;                % Move to next row
%     end
% end




%%


% Precompute subplot indices (p) for diagonal-like arrangement
% for i = 1 : sqrt(N)
%     c = -sqrt(N) + i;  
%     for j = 1 : sqrt(N)
%         c = c + sqrt(N);
%         p(k) = c;      % Store subplot index
%         k = k + 1;
%     end
% end