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