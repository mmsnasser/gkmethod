clear
clc
%%
res = [
    1    2.6105e+00
    2    4.1011e-03
    3    8.7495e-05
    4    8.0735e-07
    5    1.7438e-08
    6    1.9657e-10
    7    2.3401e-12
    8    1.6055e-13
    9    1.7518e-13
    10   1.9077e-13
    11   1.7449e-13
    12   1.9153e-13
    ];
%%
k   = res(:,1);
err = res(:,2);
%
kk=0:12;
asy = 40*0.013.^kk;
% 
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
semilogy(k,err,'-or','LineWidth',1.5);
hold on; box on
semilogy(kk,asy,'-.k','LineWidth',1.5);
xlabel('$k$','interpreter','latex')
% ylabel('Error','interpreter','latex')
legend({'$\|\omega^{k}-\omega^{k-1}\|$','$c(0.012)^k$'},'Interpreter','LaTeX',...
        'location','northeast');
set(gca,'FontSize',14)
axis([0 12 1e-15 1e1])
axis square
set(gca,'LooseInset',get(gca,'TightInset'))
grid on; 
ax=gca; 
set(ax,'xminorgrid','on','yminorgrid','on')
ax.GridAlpha=0.25; ax.MinorGridAlpha=0.25;
print -depsc FigErr4
%
%%