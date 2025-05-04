clear
close all
clc

n = 7; % max n = 7
N = 2^n;
I = double( imread('cameraman.tif')); %original Image
Inew = imresize(I,[N,N]); % Resize Image

%% Method 1, H x I x H
disp('Running Method 1')
tic
H1 = kronecker_hadamard(N);
HT1 = hadamard_transform_method1(Inew); % Hadamard Transform 
IHT1 = inverse_hadamard_transform_method1(HT1); %Inverse Hadamard Transform
t1 = toc;

figure
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
title('Inverse Hadamard Transform')
axis image
colormap(gca,'gray')
%% Method 2, H x I
disp('Running Method 2')
tic
H2 = kronecker_hadamard(N^2);
HT2 = hadamard_transform_method2(Inew); %Hadamard Transform
IHT2 = inverse_hadamard_transform_method2(HT2); %Inverse Hadamard Transform
t2 = toc;

figure
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
title('Inverse Hadamard Transform')
axis image
colormap(gca,'gray')
%% Method 3, Sum
disp('Running Method 3')

% HT3(i) = H2(i,:) * Inew(:);
%HT3 = H2 * Inew(:);

tic
HT3 = hadamard_transform_method2(Inew); %Hadamard Transform
[IHT3, IHT_25, IHT_50, IHT_75] = iterative_inverse_hadamard_transform(HT3);  %Inverse Hadamard Transform
t3 = toc;


% tic
% IHT3 = zeros(N,N);
% 
% for i = 1 : N^2;
%     HT3(i) = H2(i,:) * Inew(:);   %Hadamard Transform 
%     IHT3 = HT3(i) * reshape(H2(i,:)', [N,N]) + IHT3; % Partial Hadamard transmosrm
%     if i == N^2/4
%         IHT3_25 = IHT3;
%     elseif i == N^2/2
%         IHT3_50 = IHT3;
%     elseif i == (3*N^2)/4
%         IHT3_75 = IHT3; 
% 
%     end
% end
% t3 = toc;
% % reshape(HT3, [N,N])
% IHT3 = (1/N^2)*IHT3; %Complete Inverse Hadamard Transform



figure
subplot(1,4,1)
imagesc(IHT_25)
title('Recovery 25%')
axis image
colormap(gca,'gray')

subplot(1,4,2)
imagesc(IHT_50)
title('Recovery 50%')
axis image
colormap(gca,'gray')

subplot(1,4,3)
imagesc(IHT_75)
title('Recovery 75%')
axis image
colormap(gca,'gray')

subplot(1,4,4)
imagesc(IHT3)
title('Recovery 100%')
axis image
colormap(gca,'gray')


%% Time results
disp("Execution times (seconds):");
disp(table(t1, t2, t3, 'VariableNames', {'Method 1', 'Method 2', 'Method 3'}));

%% 
figure;
bar([t1, t2, t3]);
set(gca, 'XTickLabel', {'Method 1', 'Method 2', 'Method 3'});
ylabel('Time (seconds)');
title('Comparison of execution times');