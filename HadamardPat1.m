clear var
close all
clc

n= 16;
H = hadamard(n);
[ny, nx] = size(H);


%%
clear createFigure
fig1 = createFigure('left', 200, 'bottom', 150, 'width', 400, 'height', 400);
esp = 0.01;
% subplot_tight(1,1,1, esp)
subplot_tight(1, 1, 1, [0.01, 0.01], 'LineWidth', 2);
%subplot(1,1,1)
imagesc(H)
axis image
set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),'xticklabel',{[]},'yticklabel',{[]});
set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-', 'xcolor', 'k', 'ycolor', 'k');
colormap gray

print(['HadamardMatrix_', num2str(n), 'x', num2str(n),'_paper'],'-dpng', '-r300')
print(['HadamardMatrix_', num2str(n), 'x', num2str(n),'_paper'],'-deps', '-r300')



%%
fig2 = createFigure('left', 200, 'bottom', 150, 'width', 400, 'height', 400);
p = 1;
esp = 0.015;
for i = 1 : sqrt(n)
    for j =  1 : sqrt (n)
        pat = reshape(H(:,p), sqrt(n), sqrt(n));
        
        subplot_tight(sqrt(n), sqrt(n), p, esp)
        % subplot(sqrt(n), sqrt(n), p)
        imagesc(pat')
        axis image
        colormap gray
        caxis([-1 1]);
        set(gca,'xtick', linspace(0.5,nx+0.5,nx+1), 'ytick', linspace(0.5,ny+.5,ny+1),'xticklabel',{[]},'yticklabel',{[]});
        set(gca,'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-', 'xcolor', 'k', 'ycolor', 'k');
        p = p + 1; 
    end
end

print(['HadamardPat_', num2str(sqrt(n)), 'x', num2str(sqrt(n)),'_paper'],'-dpng', '-r300')
print(['HadamardPat_', num2str(n), 'x', num2str(n),'_paper'],'-deps', '-r300')


