clear
close all
clc

n = 2; % max n = 7
N = 2^n;
I = double( imread('cameraman.tif')); %original Image
f = imresize(I,[N,N]); % Resize Image
Ordered = 'paley';
HadamardOrder = 2;
M = Ordered; %'kronecker', 'sylvester', 'walsh', 'paley'

path(path,genpath(pwd));

num_trials = 5;
p = 5;

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

%%
I = zeros(N, N); 
% f_temp = zeros(N, N);
[ny, nx] = size(H1);
%esp = 2/100;   
p = 1;  
% sign_change = count_sign_changes(H1);
HT1 = H1 * f * H1;

figure
for row = 1 : N
    for col = 1 : N
        I(row,col) = 1;  
        pat = H1 * I * H1;   
        % subplot_tight(N, N, p, [esp2, esp2]); 
        subplot(N, N, p)
        imagesc(pat), axis image, colormap gray, 
        caxis([-1 1]) 
        xlabel(num2str(HT1(row,col)))
        ylabel(num2str((p)))
        % Format axes (remove labels, add grid)
        set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1), 'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-', 'xcolor', 'k', 'ycolor', 'k');
            
        %add_matrix_annotations(pat, 'FontSize', 12);
        I(row,col) = 0; 
         p = p + 1;                %
    end
end




%% 

N = N^2;
I = zeros(N, 1);       
[ny, nx] = size(H2);
% k = 1;      
% HT2 = reshape( H2 * f(:), sqrt(N), sqrt(N));
p = SubplotIndicesByColumn(sqrt(N),sqrt(N))
HT2 =  H2 * f(:);
HT2_temp = reshape( H2 * f(:), sqrt(N), sqrt(N));
% Iterate over each element in vector I
figure
for row = 1 : N
    I(row,1) = 1;                  
    pat = reshape( H2 * I, sqrt(N), sqrt(N)); 
    % subplot_tight(sqrt(N), sqrt(N), p(row), [esp2, esp2]);
    subplot(sqrt(N), sqrt(N), p(row) );%p(row)
    imagesc(pat), axis image, colormap gray   
    caxis([-1 1])
    title(['row=', num2str(row)])
    xlabel(num2str(HT2(row)))
    ylabel(num2str(p(row)))
    % Format axes (same as Method 1)
    set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1), 'xticklabel',{[]},'yticklabel',{[]});
    set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-', 'xcolor', 'k', 'ycolor', 'k');
    %add_matrix_annotations(pat, 'FontSize', 12);
        
    I(row,1) = 0;                  
end

%% 
pat = ones(sqrt(N), sqrt(N)); % Placeholder for pattern
k = 1;                        % Row index counter
p = SubplotIndicesByColumn(sqrt(N),sqrt(N));



% Iterate over each row of H
figure
for row = 1 : sqrt(N)
    for col = 1 : sqrt(N)
        pat = reshape(H2(k,:), sqrt(N), sqrt(N)); 
        %pat .* f
        %subplot_tight(sqrt(N), sqrt(N), p(k), [esp2, esp2]);
        subplot(sqrt(N), sqrt(N), p(k));
        imagesc(pat), axis image, colormap gray    
        caxis([-1 1])
        title(['row=', num2str(k)])
        xlabel([num2str(HT2(k))])
        ylabel(num2str(p(k)))%, ' _ ', num2str(k)
        % Format axes (same as previous methods)
        set(gca,'xtick', linspace(0.5,nx + 0.5,nx + 1), 'ytick', linspace(0.5,ny+.5,ny+1),...
            'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
            'xcolor', 'k', 'ycolor', 'k');
       
        
        
        k = k + 1;                % Move to next row
    end
end
%%