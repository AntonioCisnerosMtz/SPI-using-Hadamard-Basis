% This script demonstrates a differential Hadamard transform approach on an image.
% It computes positive/negative Hadamard transforms, their inverses, and visualizes results.
% Key steps include matrix generation, transform computation, inverse reconstruction, and plotting.

% --- Initial Setup ---
clear; close all; clc;  % Clear workspace and figures
n = 5;                  % Set exponent (max n = 7;)
N = 2^n;                % Image dimension (power of 2 for Hadamard compatibility)
I = im2double(imread('cameraman.tif')); % Load image (uint8 to double conversion)
Inew = imresize(I, [N, N]);          % Resize image to NxN
addpath('functions\');
% --- Hadamard Matrix Generation ---
H = kronecker_hadamard(N^2);     % Generate N^2 x N^2 Hadamard matrix (Kronecker method)
Hp = (H + 1)/2;                  % Positive Hadamard matrix (values: 0-1)
Hn = (1 - H)/2;                  % Negative Hadamard matrix (complement of Hp)

% --- Hadamard Transforms ---
HTp = reshape(Hp * Inew(:), [N, N]); % Positive transform (vectorize -> multiply -> reshape)
HTn = reshape(Hn * Inew(:), [N, N]); % Negative transform
HT = HTp - HTn;                     % Differential Hadamard transform

% --- Inverse Transforms ---
IHTp = reshape(H * HTp(:), [N, N]); % Inverse of positive transform
IHTn = reshape(H * HTn(:), [N, N]); % Inverse of negative transform
IHT = reshape(H * HT(:), [N, N]);   % Inverse of differential transform

% Adjust DC component for better visualization
IHTp(1,1) = 0;  % Set (1,1) to zero (prevents DC component from dominating colormap)
IHTn(1,1) = 0;  

% --- Visualization Parameters ---
yf = max([max(max(HTp)) max(max(HTn)) max(max(HT))]); % Upper plot limit
yi = min([min(min(HTp)) min(min(HTn)) min(min(HT))]); % Lower plot limit
%%
% --- Plot 1: Transform Coefficients ---
clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 50, 'width', 800, 'height', 400);
subplot_tight(1,1,1, 10/100)
plot(HTp(:), 'LineWidth', 2);  % Plot positive transform coefficients
grid on;
axis([1 N^2 yi yf]);           % Set axis limits
xlabel('Pattern number');      % X-axis: Hadamard basis index
ylabel('Intensity (a.u.)');    % Y-axis: Coefficient magnitude
hold on;
plot(HTn(:), 'LineWidth', 2);  % Overlay negative coefficients
plot(HT(:), 'LineWidth', 2);   % Overlay differential coefficients
hold off;
legend('Positive', 'Negative', 'Difference'); % Add legend

print(['figures/', 'PlotSignalPositiveNegativeDifference' ], '-dpng', '-r300');
%%
esp = 5/100;
% --- Plot 2: Transform Visualizations (Log Scale) ---
fig2 = createFigure('left', 0, 'bottom', 50, 'width', 800, 'height', 300);

% Positive transform (log scale +1 to avoid log(0))
subplot_tight(1,3,1, esp)
imagesc(log(abs(HTp) + 1));    
axis image;                    % Equal aspect ratio
title('Transform (Positive)');
colormap(gca, 'jet');          % Color map: jet

% Negative transform

subplot_tight(1,3,2, esp)
imagesc(log(abs(HTn) + 1));
axis image;
title('Transform (Negative)');
colormap(gca, 'jet');

% Differential transform
subplot_tight(1,3,3, esp)
imagesc(log(abs(HT) + 1));
axis image;
title('Transform (Difference)');
colormap(gca, 'jet');

print(['figures/', 'HadamardTransformPositiveNegativeDifference' ], '-dpng', '-r300');
%%
% --- Plot 3: Inverse Transforms (Grayscale) ---
fig2 = createFigure('left', 0, 'bottom', 50, 'width', 800, 'height', 300);
% Inverse positive transform
subplot_tight(1,3,1, esp)
imagesc(IHTp);
axis image;
title('Inverse (Positive)');
colormap(gca, 'gray');         % Grayscale for image reconstruction

% Inverse negative transform
subplot_tight(1,3,2, esp)
imagesc(IHTn);
axis image;
title('Inverse (Negative)');
colormap(gca, 'gray');

% Inverse differential transform
subplot_tight(1,3,3, esp)
imagesc(IHT);
axis image;
title('Inverse (Difference)');
colormap(gca, 'gray');
print(['figures/', 'InverseHadamardTransformPositiveNegativeDifference' ], '-dpng', '-r300');