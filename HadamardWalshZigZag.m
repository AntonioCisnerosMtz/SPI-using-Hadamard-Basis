clear
close all
clc




addpath(genpath('functions'))

path = [pwd, '\Matrix\'];

n = 2;
N = 2^n;

H = hadamard_sequency(N);
[ny, nx] = size(H);


x_vect = 1:1:N^2;
x_mat = invZigzag(x_vect);
%ZigZagscan(x_mat')
f = zeros(N,N);
Hzz = zeros(N^2:N^2);
p = 1;


figure
imagesc(H), axis image, colormap gray
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1), 'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', 'xcolor', 'k', 'ycolor', 'k');


% figure
for row = 1 : N

    for col = 1 : N
        f(row,col) = 1;
        pat = H  * f *  H;
        Hzz(x_mat(row, col), : ) = pat(:);

        subplot(N,N,p)
        imagesc(pat), axis image, colormap gray, caxis([-1 1])
        % title(num2str(p))
        xlabel(num2str(x_mat(row, col)))
        set(gca,'xtick', linspace(0.5,nx + 0.5, nx + 1), 'ytick', linspace(0.5, ny + .5, ny + 1), 'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', 'xcolor', 'k', 'ycolor', 'k');

        f(row,col) = 0;
        p = p + 1;
    end
end

save([path,  'Hzz_', num2str(N^2), 'x', num2str(N^2) '.mat'], 'Hzz');

figure
imagesc(Hzz), axis image, colormap gray 
set(gca,'xtick', linspace(0.5,nx^2 + 0.5, nx^2 + 1), 'ytick', linspace(0.5,ny^2 + .5, ny^2 + 1), 'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle' , '-', 'xcolor', 'k', 'ycolor', 'k');