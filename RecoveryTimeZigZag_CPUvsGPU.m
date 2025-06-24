
clear
close all
clc
reset(gpuDevice)
n = 7; % max n = 7
N = 2^n;
I = double( imread('cameraman.tif')); %original Image
f = imresize(I,[N,N]); % Resize Image
Ordered = 'zigzag';  % opts = 'kronecker', 'sylvester', 'walsh', 'paley', zigzag
M = Ordered; 
% addpath('functions\');
path(path,genpath(pwd));
%addpath(genpath('functions'))
num_trials = 5;
p = 5;


%%
outputDir = 'C:\Users\annto\OneDrive\Doctorado\Paper\figures\MATLAB\';  %<================ change dir
currentFile = mfilename('fullpath');  
[~, filename] = fileparts(currentFile);  
outputDir = [outputDir, filename];
[status,msg] = mkdir(outputDir);



%% Method 1, H x I x H
disp('Running Method 1')


HT1 = hadamard_transform_method1(f,'walsh'); % Hadamard Transform 
I = zeros(N,N,p);
HT1_zz = ZigZagscan(HT1');
HT1_zz = HT1_zz';


for i = 1 : p
    ratio = (1/p) * i;
    percentage(i) = ratio * 100;



    HT1_temp = zeros(N^2,1); 
    HT1_temp(1 : round(ratio * N^2 ) , 1 ) = HT1_zz(1 : round(ratio * N^2 ), 1 );
    HT1_temp = invZigzag(HT1_temp);
    
    % figure(i)
    % imagesc(log(abs(HT1_temp) + 1)), axis image, colormap(gca,'jet')

    [I(:,:,i), time1(i)] = inverse_hadamard_transform_method1(HT1_temp, 'walsh', num_trials);
    [ ~ , time1_gpu(i)] = inverse_hadamard_transform_method1_GPU(HT1_temp, 'walsh', num_trials);
    S1(i) = ssim(I(:,:,i), f);
end

[pfx, pfx_num] = getTimePrefix( mean(time1) );

figure
for i = 1 : p
    label_str = sprintf('CPU: %4.2f %s\nGPU: %4.2f %s', time1(i) * (10^(3 * pfx_num)), pfx, time1_gpu(i) * (10^(3 * pfx_num)), pfx);
    subplot(2,p,i)
    imagesc(I(:,:,i)), axis image, colormap gray
    title([ num2str(percentage(i)), '%' ] )
    xticks([])
    yticks([])
    %xlabel(sprintf('CPU: %4.2f %s', time1(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex');
    xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
end 
subplot(2,p,[i+1:2*p])
plot(percentage, time1, LineWidth=2)
xlabel('%')
ylabel('time (s)')
grid on



% figure
% for i = 1 : p
%     label_str = sprintf('CPU: %4.2f %s\nGPU: %4.2f %s', time1(i) * (10^(3 * pfx_num)), pfx, time1_gpu(i) * (10^(3 * pfx_num)), pfx);
%     subplot(1,p,i)
%     imagesc(I(:,:,i)), axis image, colormap gray
%     title({[ num2str(percentage(i)), '%' ]}, {' '}, 'FontName', 'Arial', 'FontSize', 10)
%     xticks([])
%     yticks([])
%     %xlabel(sprintf('%4.2f %s', time1(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex', 'FontName', 'Arial');
%     xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
% end 
% 
% print(fullfile(outputDir, ['PartialRecoveryMethod1_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['PartialRecoveryMethod1_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-depsc');


%% Method 2, H x I
disp('Running Method 2')
HT2 = hadamard_transform_method2(f,M); %Hadamard Transform
% HT2 = Hzz * f(:);
% HT2 = reshape(HT2,N,N);

I = zeros(N,N,p);


for i = 1 : p
    ratio = (1/p) * i;
    % percentage(i) = ratio * 100;
    HT2_temp = zeros(N,N);
    HT2_temp( : , 1 : round(ratio * N) ) = HT2(: , 1 : round(ratio * N) );
    %time_method_2(i) = time_method(@() inverse_hadamard_transform_method2(HT2_temp, M), num_trials);
    [I(:,:,i), time2(i)] = inverse_hadamard_transform_method2(HT2_temp, M,num_trials);
    [ ~ , time2_gpu(i)] = inverse_hadamard_transform_method2_GPU(HT2_temp, M, num_trials);
    S2(i) = ssim(I(:,:,i), f);
end

[pfx, pfx_num] = getTimePrefix( mean(time2) );


figure
for i = 1 : p
    label_str = sprintf('CPU: %4.2f %s\nGPU: %4.2f %s', time2(i) * (10^(3 * pfx_num)), pfx, time2_gpu(i) * (10^(3 * pfx_num)), pfx);
    subplot(2,p,i)
    imagesc(I(:,:,i)), axis image, colormap gray
    title([ num2str(percentage(i)), '%' ] )
    xticks([])
    yticks([])
    %xlabel(sprintf('%4.2f %s', time2(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex');
    xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
end 
subplot(2,p,[i+1:2*p])
plot(percentage, time2, LineWidth=2)
xlabel('%')
ylabel('time (s)')
grid on



% figure
% for i = 1 : p
%     label_str = sprintf('CPU: %4.2f %s\nGPU: %4.2f %s', time2(i) * (10^(3 * pfx_num)), pfx, time2_gpu(i) * (10^(3 * pfx_num)), pfx);
%     subplot(1,p,i)
%     imagesc(I(:,:,i)), axis image, colormap gray
%     xticks([])
%     yticks([])
%     % xlabel(sprintf('%4.2f %s', time2(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex', 'FontName', 'Arial');
%     xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
% end 
% 
% print(fullfile(outputDir, ['PartialRecoveryMethod2_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['PartialRecoveryMethod2_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-depsc');


%% Method 3, Sum
disp('Running Method 3')

HT3 = hadamard_transform_method2(f,M); %Hadamard Transform
I = zeros(N,N,p);
for i = 1 : p
    ratio = (1/p) * i;
    percentage(i) = ratio * 100;
    HT3_temp = HT3(: , 1 : round(ratio * N) );
    %time_method_3(i) = time_method(@() iterative_inverse_hadamard_transform_01(HT3_temp, M), num_trials);
    [I(:,:,i), time3(i)] = iterative_inverse_hadamard_transform_01(HT3_temp,M, num_trials);
    [ ~ , time3_gpu(i)] = iterative_inverse_hadamard_transform_01_GPU(HT3_temp,M, num_trials);
    S3(i) = ssim(I(:,:,i), f);
end


[pfx, pfx_num] = getTimePrefix( max(time3) );

figure
for i = 1 : p
    label_str = sprintf('CPU: %4.2f %s\nGPU: %4.2f %s', time3(i) * (10^(3 * pfx_num)), pfx, time3_gpu(i) * (10^(3 * pfx_num)), pfx);
    subplot(2,p,i)
    imagesc(I(:,:,i)), axis image, colormap gray
    title([ num2str(percentage(i)), '%' ] )
    % xlabel(sprintf('%4.2f %s', time3(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex');
    xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
end 
subplot(2,p,[i+1:2*p])
plot(percentage, time3, LineWidth=2)
xlabel('%')
ylabel('time (s)')
grid on

% figure
% for i = 1 : p
%     label_str = sprintf('CPU: %4.2f %s\nGPU: %4.2f %s', time3(i) * (10^(3 * pfx_num)), pfx, time3_gpu(i) * (10^(3 * pfx_num)), pfx);
%     subplot(1,p,i)
%     imagesc(I(:,:,i)), axis image, colormap gray
%     %title([ num2str(percentage(i)), '%' ] )
%     xticks([])
%     yticks([])
%     % xlabel(sprintf('%4.2f %s', time3(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex', 'FontName', 'Arial');
%     xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
% end 
% 
% print(fullfile(outputDir, ['PartialRecoveryMethod3_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['PartialRecoveryMethod3_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-depsc');





%% Method 4, TVAL3
disp('Running Method 4')

switch M
    case 'kronecker'
        H4 = kronecker_hadamard(N^2);
    case 'sylvester'
        H4 = sylvester_hadamard(N^2);
    case 'walsh'
        H4 = hadamard_sequency(N^2);
    case 'paley'
        H4 = hadamard_paley(N^2);
    case 'zigzag'
        H4 = hadamard_zigzag(N^2);
    otherwise
        error('Invalid method. Use ''kronecker'' or ''sylvester''.');
end




HT4 = hadamard_transform_method2(f,M);
I = zeros(N,N,p);

p0 = N; q0 = N; % p x q is the size of image
clear opts
opts.mu = 2^8;
opts.beta = 2^5;
opts.tol = 1E-3;
opts.maxit = 300;
opts.TVnorm = 1;
opts.nonneg = true;

for i = 1 : p
    ratio = (1/p) * i;
    %percentage(i) = ratio * 100;
    HT4_temp = HT4(: , 1 : round(ratio * N) );
    H4_temp = H4(1 : round(ratio * N) * N , : );
    time4(i) = time_method(@() TVAL3(H4_temp, HT4_temp(:),p0 ,q0 ,opts), num_trials);
    [I(:,:,i), out] = TVAL3(H4_temp, HT4_temp(:),p0 ,q0 ,opts);
    S4(i) = ssim(I(:,:,i), f);
end 


[pfx, pfx_num] = getTimePrefix( mean(time4) );
figure
for i = 1 : p
    label_str = sprintf('CPU: %4.2f %s', time4(i) * (10^(3 * pfx_num)), pfx);
    subplot(2,p,i)
    imagesc(I(:,:,i)), axis image, colormap gray
    title([ num2str(percentage(i)), '%' ] )
    % xlabel(sprintf('CPU: %4.2f %s', time4(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex','FontSize', 8);
    xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
end 

subplot(2,p,[i+1:2*p])
plot(percentage, time4, LineWidth=2)
xlabel('%')
ylabel('time (s)')
grid on

% figure
% for i = 1 : p
%     label_str = sprintf('CPU: %4.2f %s', time4(i) * (10^(3 * pfx_num)), pfx);
%     subplot(1,p,i)
%     imagesc(I(:,:,i)), axis image, colormap gray
%     %title([ num2str(percentage(i)), '%' ] )
%     xticks([])
%     yticks([])
%     % xlabel(sprintf('%4.2f %s', time4(i) * (10^(3 * pfx_num)), pfx),'Interpreter', 'tex', 'FontName', 'Arial','FontSize', 8);
%     xlabel(label_str, 'Interpreter', 'tex','FontSize', 6, 'FontName', 'Arial');
% end 
% 
% print(fullfile(outputDir, ['PartialRecoveryMethod4_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['PartialRecoveryMethod4_', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-depsc');



%%

figure
plot(percentage, time1, LineWidth=2)
xlabel('%')
ylabel('time (s)')
hold on
plot(percentage, time2,LineWidth=2)
plot(percentage, time3,LineWidth=2)
plot(percentage, time4,LineWidth=2)
hold off
%%
figure
semilogy(percentage, time1, '-','LineWidth', 2,'Color', [0 0.4470 0.741], 'DisplayName', 'Inverse1-CPU')
xlabel('%')
ylabel('time (s)')
grid on
hold on 
semilogy(percentage,time1_gpu, '--','LineWidth', 2,'Color', [0 0.4470 0.741], 'DisplayName', 'Inverse1-GPU')
semilogy(percentage,time2, '-','LineWidth', 2,'Color', [0.8500 0.3250 0.0980], 'DisplayName', 'Inverse2-CPU')
semilogy(percentage,time2_gpu, '--','LineWidth', 2,'Color', [0.8500 0.3250 0.0980], 'DisplayName', 'Inverse2-GPU')
semilogy(percentage,time3, '-','LineWidth', 2,'Color', [0.9290 0.6940 0.1250], 'DisplayName', 'Sum-CPU')
semilogy(percentage,time3_gpu, '--','LineWidth', 2,'Color', [0.9290 0.6940 0.1250], 'DisplayName', 'Sum-GPU')
semilogy(percentage,time4, '-','LineWidth', 2,'Color', [0.4940 0.1840 0.5560], 'DisplayName', 'TVAL3')

hold off
legend('Location', 'northoutside', 'NumColumns',4, FontSize=8);

% print(fullfile(outputDir, ['PartialRecoveryTime', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-dpng', '-r300');
% set(gcf,'Renderer','painters');
% print(fullfile(outputDir, ['PartialRecoveryTime', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-depsc');

%%

figure
plot(percentage, S1, '-o', 'LineWidth', 2, 'DisplayName', 'Inverse1' )
xlabel('%')
ylabel('SSIM')
grid on
hold on
plot(percentage, S2, '-o','LineWidth', 2, 'DisplayName', 'Inverse2' )
plot(percentage, S3, '-o','LineWidth', 2, 'DisplayName', 'Sum' )
plot(percentage, S4, '-o','LineWidth', 2, 'DisplayName', 'TVAL3' )
hold off
legend('Location', 'northoutside', 'NumColumns',4, FontSize=8);

print(fullfile(outputDir, ['SSIM', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-dpng', '-r300');
set(gcf,'Renderer','painters');
print(fullfile(outputDir, ['SSIM', num2str(p) ,'parts_', num2str(N),'x', num2str(N), '_', Ordered]), '-depsc');