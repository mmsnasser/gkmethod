clear
clc
%%
rese = [
    1    0.0096057
    2    0.00031686
    3    1.3374e-05
    4    6.0399e-07
    5    2.8189e-08
    6    1.5411e-09
    7    2.1322e-10
    8    9.3901e-11
    9    4.6883e-11
    10   2.3441e-11
    11   1.1722e-11
    12   5.8657e-12
    13   2.9355e-12
    14   1.4778e-12
    15   7.5717e-13
    ];
%%
res = [
    1    3.9521e+02
    2    6.0444e-03
    3    2.5759e-04
    4    1.1697e-05
    5    5.3607e-07
    6    2.4557e-08
    7    1.0559e-09
    8    3.3720e-10
    9    1.7774e-10
    10   1.1752e-10
    11   1.0109e-10
    12   9.6539e-11
    13   9.5361e-11
    14   9.5062e-11
    15   9.4988e-11
    ];
%%
k   = res(:,1);
err = res(:,2);
erre = rese(:,2);
%
kk=0:12;
asy = 3*0.045.^kk;
% 
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
semilogy(k,err,'-or','LineWidth',1.5);
hold on; box on
semilogy(k,erre,'-db','LineWidth',1.5);
semilogy(kk,asy,'-.k','LineWidth',1.5);
xlabel('$k$','interpreter','latex')
% ylabel('Error','interpreter','latex')
legend({'$\|\omega^{k}-\omega^{k-1}\|$','$e(\Gamma)$','$c(0.045)^k$'},'Interpreter','LaTeX',...
        'location','northeast');
set(gca,'FontSize',14)
axis([0 15 1e-15 1e0])
axis square
set(gca,'LooseInset',get(gca,'TightInset'))
grid on; 
ax=gca; 
set(ax,'xminorgrid','on','yminorgrid','on')
ax.GridAlpha=0.25; ax.MinorGridAlpha=0.25;
print -depsc FigErr5
%
%%