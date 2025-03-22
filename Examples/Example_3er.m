clear
clc
%%
res = [
            1       1.2249
            2     0.019039
            3    0.0046139
            4    0.0017422
            5   0.00075596
            6   0.00034811
            7   0.00016514
            8   7.9627e-05
            9   3.8766e-05
           10   1.8985e-05
           11    9.333e-06
           12   4.5994e-06
           13   2.2704e-06
           14    1.122e-06
           15   5.5491e-07
           16   2.7459e-07
           17   1.3592e-07
           18   6.7302e-08
           19    3.333e-08
           20   1.6508e-08
           21   8.1771e-09
           22   4.0507e-09
           23   2.0067e-09
           24   9.9411e-10
           25    4.925e-10
           26     2.44e-10
           27   1.2088e-10
           28   5.9889e-11
           29   2.9671e-11
           30     1.47e-11
           31   7.2829e-12
           32   3.6083e-12
           33   1.7877e-12
           34    8.859e-13
           35   4.3895e-13
           36   2.1791e-13
           37   1.0796e-13
           38   5.3874e-14
           39   2.7509e-14
           40   1.4157e-14
           41   7.4033e-15
           42    4.488e-15
           43   3.7225e-15
           44    2.758e-15
           45   3.4234e-15
           46   3.1816e-15
           47   2.5559e-15
           48   3.3546e-15
           49   2.8614e-15
           50   3.5027e-15
    ];
%%
k   = res(:,1);
err = res(:,2);
%
kk=0:45;
asy = 0.02*0.495.^kk;
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
legend({'$\|\omega^{k}-\omega^{k-1}\|$','$c(0.495)^k$'},'Interpreter','LaTeX',...
        'location','northeast');
set(gca,'FontSize',14)
axis([0 45 1e-15 1e1])
axis square
set(gca,'LooseInset',get(gca,'TightInset'))
grid on; 
ax=gca; 
set(ax,'xminorgrid','on','yminorgrid','on')
ax.GridAlpha=0.25; ax.MinorGridAlpha=0.25;
print -depsc FigErr3
%
%%