clear
close all
clc

n = 6; % max n = 7
N = 2^n;
I = double( imread('cameraman.tif')); %original Image
f = imresize(I,[N,N]); % Resize Image
ratio = 0.25;
% addpath('functions\');
path(path,genpath(pwd));
%addpath(genpath('functions'))
%% Method 1, H x I x H
disp('Running Method 1')


H1 = kronecker_hadamard(N);
HT1 = hadamard_transform_method1(f); % Hadamard Transform 


HT1_temp = zeros(N,N);
%ratio = round(0.25 * N);
HT1_temp(1 : round(ratio * N) , : ) = HT1(1 : round(ratio * N ), : );

tic
IHT1 = inverse_hadamard_transform_method1(HT1_temp); %Inverse Hadamard Transform
t1 = toc;

clear createFigure; % Clear persistent counter in createFigure (if needed)
fig1 = createFigure('left', 0, 'bottom', 550, 'width', 700, 'height', 400);
subplot(1,3,1)

imagesc(H1)
title('Hadamard Matrix')
axis image
colormap(gca,'gray')

subplot(1,3,2)
imagesc(log(abs(HT1) + 1)) %% better visualitation
title('Hadamard Transform')
axis image
colormap(gca,'jet')

subplot(1,3,3)
imagesc(IHT1)
title('Inverse Transform')
axis image
colormap(gca,'gray')
%% Method 2, H x I
disp('Running Method 2')




H2 = kronecker_hadamard(N^2);
HT2 = hadamard_transform_method2(f); %Hadamard Transform


%ratio = 0.25;
HT2 = HT2(1 : round(ratio * N), : );
tic
IHT2 = inverse_hadamard_transform_method2(HT2); %Inverse Hadamard Transform



t2 = toc;

fig2 = createFigure('left', 700, 'bottom', 550, 'width', 700, 'height', 400);
subplot(1,3,1)
imagesc(H2)
title('Hadamard Matrix')
axis image
colormap(gca,'gray')

subplot(1,3,2)
% imagesc(HT1)
imagesc(log(abs(HT2) + 1)) % better visualitation
title('Hadamard Transform')
axis image
colormap(gca,'jet')

subplot(1,3,3)
imagesc(IHT2)
title('Inverse Transform')
axis image
colormap(gca,'gray')
%% Method 3, Sum
disp('Running Method 3')

% HT3(i) = H2(i,:) * Inew(:);
%HT3 = H2 * Inew(:);
%ratio = .5;
H3 = kronecker_hadamard(N^2);
HT3 = hadamard_transform_method2(f); %Hadamard Transform
HT3 = HT3(1 : round(ratio * N), : );

tic
[IHT3] = iterative_inverse_hadamard_transform_01(HT3);  %Inverse Hadamard Transform
%[IHT3_full, IHT3_25, IHT3_50, IHT3_75] = iterative_inverse_hadamard_transform_02(HT3);  %Inverse Hadamard Transform
t3 = toc;



fig3 = createFigure('left', 0, 'bottom', 50, 'width', 700, 'height', 400);
subplot(1,3,1)
imagesc(H3)
title('Hadamard Matrix')
axis image
colormap(gca,'gray')

subplot(1,3,2)
% imagesc(HT1)
imagesc(log(abs(HT3) + 1)) % better visualitation
title('Hadamard Transform')
axis image
colormap(gca,'jet')

subplot(1,3,3)
imagesc(IHT3)
title('Inverse Transform')
axis image
colormap(gca,'gray')


%% Method 4, TVAL3
disp('Running Method 4')
HT4 = hadamard_transform_method2(f);
HT4 = HT4(1 : round(ratio * N), : );
HT4 = HT4';


p = N; q = N; % p x q is the size of image
clear opts
opts.mu = 2^8;
opts.beta = 2^5;
opts.tol = 1E-3;
opts.maxit = 300;
opts.TVnorm = 1;
opts.nonneg = true;


H4_temp = H2(1 : round(ratio * N) * N , : );

tic;
[U, out] = TVAL3(H4_temp, HT4(:),p,q,opts);
t4 = toc;

fig4 = createFigure('left', 700, 'bottom', 50, 'width', 700, 'height', 400);
imagesc(U')
axis image
colormap gray

%% Time results
disp("Execution times (seconds):");
disp(table(t1, t2, t3, t4,'VariableNames', {'Method 1', 'Method 2', 'Method 3', 'Method 4'}));

%% 
% fig5 = createFigure('left', 700, 'bottom', 50, 'width', 700, 'height', 400);
% bar([t1, t2, t3, t4]);
% set(gca, 'XTickLabel', {'Method 1', 'Method 2', 'Method 3', 'Method 4'});
% ylabel('Time (seconds)');
% title('Comparison of execution times');

