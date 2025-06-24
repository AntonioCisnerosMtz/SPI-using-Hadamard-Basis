function [Hzz] = hadamard_zigzag(N)



% addpath(genpath('functions'))
% 
% path = [pwd, '\Matrix\'];
% 
% n = 2;
% N = 2^n;

H = hadamard_sequency(sqrt(N));
% [ny, nx] = size(H);


x_vect = 1:1:N;
x_mat = invZigzag(x_vect);
%ZigZagscan(x_mat')
f = zeros(sqrt(N),sqrt(N));
Hzz = zeros(N:N);
p = 1;





% figure
for row = 1 : sqrt(N)

    for col = 1 : sqrt(N)
        f(row,col) = 1;
        pat = H  * f *  H;
        Hzz(x_mat(row, col), : ) = pat(:);

        % subplot(N,N,p)
        % imagesc(pat), axis image, colormap gray, caxis([-1 1])
        % % title(num2str(p))
        % xlabel(num2str(x_mat(row, col)))
        % set(gca,'xtick', linspace(0.5,nx + 0.5, nx + 1), 'ytick', linspace(0.5, ny + .5, ny + 1), 'xticklabel',{[]},'yticklabel',{[]});
        % set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', 'xcolor', 'k', 'ycolor', 'k');

        f(row,col) = 0;
        p = p + 1;
    end
end

%save([path,  'Hzz_', num2str(N^2), 'x', num2str(N^2) '.mat'], 'Hzz');








end