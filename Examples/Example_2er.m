clear
clc
%%
res = [
    1    7.6276e+00
    2    5.8914e-04
    3    2.0640e-06
    4    3.9944e-08
    5    6.4015e-10
    6    9.5696e-12
    7    1.4049e-13
    8    3.3325e-15
    9    2.2037e-15
    10   3.0201e-15
    ];
%%
k   = res(:,1);
err = res(:,2);
%
kk=0:10;
asy = 0.6*0.016.^kk;
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
legend({'$\|\omega^{k}-\omega^{k-1}\|$','$c(0.016)^k$'},'Interpreter','LaTeX',...
        'location','northeast');
set(gca,'FontSize',14)
axis([0 10 1e-15 1e1])
axis square
set(gca,'LooseInset',get(gca,'TightInset'))
grid on; 
ax=gca; 
set(ax,'xminorgrid','on','yminorgrid','on')
ax.GridAlpha=0.25; ax.MinorGridAlpha=0.25;
print -depsc FigErr2
%
%%