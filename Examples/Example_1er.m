clear
clc
%%
res = [
    1    1.8968e+00
    2    5.2166e-03
    3    1.7541e-04
    4    7.0823e-06
    5    2.9302e-07
    6    1.2179e-08
    7    5.0663e-10
    8    2.1079e-11
    9    8.7679e-13
    10   3.6886e-14
    11   3.9830e-15
    12   3.1264e-15
    ];
%%
k   = res(:,1);
err = res(:,2);
%
kk=0:12;
asy = 2.25*(0.042).^kk;
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
legend({'$\|\omega^{k}-\omega^{k-1}\|$','$c(0.042)^k$'},'Interpreter','LaTeX',...
        'location','northeast');
set(gca,'FontSize',14)
axis([0 12 1e-15 1e1])
axis square
set(gca,'LooseInset',get(gca,'TightInset'))
grid on; 
ax=gca; 
set(ax,'xminorgrid','on','yminorgrid','on')
ax.GridAlpha=0.25; ax.MinorGridAlpha=0.25;
print -depsc FigErr1
%
%%