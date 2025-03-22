function map = gkiteran(et,etp,n,alpha,zo,gktol,maxgkitr)
% gkiteran.m
% Nasser, Sep 7, 2024
%
m    =  length(zo);
zet  =  et;  zetp  =  etp;
% 
for itr =1:maxgkitr
    zetold  = zet;
    zetpold = zetp;
    zold    = zo;
    %
    for k=3:2:m      
        [zet,zetp,zo,alpha] = inmap(zet,zetp,zo,alpha,n,m,k);
    end
    [zet,zetp,zo,alpha] = inmap(zet,zetp,zo,alpha,n,m,1);
    %
    zet   =  exp(-i*angle(alpha))*zet;
    zetp  =  exp(-i*angle(alpha))*zetp;
    zo    =  exp(-i*angle(alpha))*zo;
    alpha =  exp(-i*angle(alpha))*alpha;
    %
    [itr norm(zet-zetold,inf)]
    itr_no(itr,1)  = itr;
    Err_itr(itr,1) = norm(zet-zetold,inf);
    %
    ee = eerr(zet,m,n)
    %
    figure(10)
    clf
    axis equal
    axis([-1.01  1.01  -1.01   1.01])
    hold on; box on
    % colr{1} = 'k'; colr{2} = 'b'; colr{3} = 'r'; colr{4} = 'm'; colr{5} = [0 0.5 0];
    for j=1:m
        crv   = zet((j-1)*n+1:j*n);crv(n+1) = crv(1);
        % plot(crv,'color',colr{j},'LineWidth', 1.5);
        plot(crv,'k','LineWidth', 1.5);
    end
    plot(real(alpha),imag(alpha),'pk','MarkerFaceColor','k','MarkerSize',8)
    % plot(real(zo),imag(zo),'sb')    
    set(gca,'FontSize',14)
    set(gca,'LooseInset',get(gca,'TightInset'))
    % print -depsc Fig_an_itr
    drawnow
    %
    if (norm(zet-zetold,inf)<gktol)
        break;
    end
    if itr>1 & Err_itr(itr)>2*Err_itr(itr-1)
        zet  =  zetold;
        zetp =  zetpold;
        zo    =  zold;
        break;
    end
end
% 
for k=1:m
    Jk       =  (k-1)*n+1:k*n;
    [xo yo rad(k,1)] = circle_fit(real(zet(Jk)),imag(zet(Jk)));
    z(k,1)=xo+i*yo;
end
%
map.zet    =  zet;
map.zetp   =  zetp;
map.z      =  z;
map.rad    =  rad;
map.alpha  =  alpha;
% 
%%
function [zet,zetp,zo,alpha] = inmap(zet,zetp,zo,alpha,n,m,k)
    if k<m
        Jk    = (k-1)*n+1:(k+1)*n; z1 = zo(k); z2 = zo(k+1);
        etm   =  zet(Jk);  etmp  =  zetp(Jk);
        map   =  annmapu(etm,etmp,n,z1,z2);
        cm    =  map.c;
    elseif k==m
        Jk    = (k-1)*n+1:k*n; z1 = zo(k);
        etm   =  zet(Jk);  etmp  =  zetp(Jk);
        map   =  diskmapub(etm,etmp,n,z1);
        cm    =  0;
    end
    %
    zetm  = map.zet;
    zetmp = map.zetp;        
    %
    zet(Jk) =  alpha;
    zet     =  fcau(etm,etmp,zetm,zet.',n,cm).';
    for j=1:m
        Jj=(j-1)*n+1:j*n;
        zetp(Jj) = derfft(real(zet(Jj)))+i*derfft(imag(zet(Jj)));
    end
    zet(Jk)  =  zetm;  zetp(Jk)  =  zetmp;
    %
    alpha  =  fcau(etm,etmp,zetm,alpha,n,cm);
    %
    if k<m
        for j=1:m
            if j==k
                zo(j) = inf;
            elseif j==k+1
                zo(j)=0;
            else
                if abs(zo(j))>1e6
                    zo(j)  =  cm; 
                else
                    zo(j)  =  fcau(etm,etmp,zetm,zo(j),n,cm);
                end
            end
        end
    end
    if k==m
        zo(m) = inf;
        for j=1:m-1
            if abs(zo(j))>1e6
                zo(j)  =  0; 
            else
                zo(j)  =  fcau(etm,etmp,zetm,zo(j),n,cm);
            end
        end
    end
end
%
end