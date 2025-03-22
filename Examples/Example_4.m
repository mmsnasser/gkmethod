clear
clc
%
addpath ../bie; addpath ../fmm; addpath ../files; addpath ../other;
%%
n =  2^10;
t       =  (0:2*pi/n:2*pi-2*pi/n).';
%%
gktol   =   1e-13;  maxgkitr = 10;
%%
Aof=[
2.00    1.0     0                0.0  
0.50   -0.10    0.00+.2i         0.0

0.06   -0.02    0.90i            0.0  
0.10   -0.04    0.75+0.8i        0.0 
0.10   -0.02    0.0+0.7i         0.0 
0.08   -0.04    0.4+0.82i        1.5 
0.08   -0.02    0.0+0.8i         0.0 
0.08   -0.04   -0.4+0.82i        1.5 
0.10   -0.04   -0.75+0.8i        0.0  

0.15   -0.05    0.57i            0.0 
0.09   -0.04    1.27+0.6i        1.5 
0.15   -0.05    1.00+0.6i        1.5 
0.09   -0.04    0.75+0.6i        1.5 
0.12   -0.05    0.55+0.6i        1.5 
0.10   -0.04    0.30+0.6i        1.5 
0.09   -0.04   -1.27+0.6i        1.5 
0.15   -0.05   -1.00+0.6i        1.5 
0.09   -0.04   -0.75+0.6i        1.5 
0.12   -0.05   -0.55+0.6i        1.5 
0.10   -0.04   -0.30+0.6i        1.5 

0.15   -0.05    1.50+.4i         0.0
0.12   -0.04    1.15+.4i         1.5
0.15   -0.03    0.75+.4i         0.0
0.08   -0.04    0.43+.4i         1.5
0.10   -0.03    0.20+.4i         0.0
0.04   -0.04    0.00+.4i         1.5
0.15   -0.05   -1.50+.4i         0.0
0.12   -0.04   -1.15+.4i         1.5
0.15   -0.03   -0.75+.4i         0.0
0.08   -0.04   -0.43+.4i         1.5
0.10   -0.03   -0.20+.4i         0.0

0.15   -0.05    1.75+.2i         1.57
0.09   -0.07    1.50+.2i         1.57
0.12   -0.04    1.28+.2i         1.57
0.15   -0.05    1.00+.2i         1.57
0.10   -0.05    0.75+.2i         1.57
0.10   -0.05   -0.75+.2i         0.0
0.15   -0.05   -1.00+.2i         1.57
0.12   -0.04   -1.28+.2i         1.57
0.09   -0.07   -1.50+.2i         1.57
0.15   -0.05   -1.75+.2i         1.57

0.15   -0.05    1.50             0.0  
0.15   -0.05    1.15             1.57  
0.12   -0.04    0.85             0.0  
0.12   -0.04    0.60             1.57  
0.12   -0.04    0.35             0.00  
0.15   -0.05   -1.50             0.0  
0.15   -0.05   -1.15             1.57 
0.12   -0.04   -0.84             0.0  
0.12   -0.04   -0.60             1.57  
0.12   -0.04   -0.35             0.00  

0.12   -0.05    1.75-.2i         1.57
0.07   -0.07    1.50-.2i         1.57
0.10   -0.04    1.28-.2i         1.57
0.12   -0.05    1.00-.2i         1.57
0.10   -0.05    0.75-.2i         0.0
0.07   -0.03    0.45-.2i         1.57
0.07   -0.03    0.30-.2i         1.57
0.20   -0.08    0.00-.2i         0.0
0.12   -0.05   -1.75-.2i         1.57
0.07   -0.07   -1.50-.2i         1.57
0.10   -0.04   -1.28-.2i         1.57
0.12   -0.05   -1.00-.2i         1.57
0.10   -0.05   -0.75-.2i         0.0
0.07   -0.03   -0.45-.2i         1.57
0.07   -0.03   -0.30-.2i         1.57

0.30   -0.1     0.00-0.54i       0.75 
0.10   -0.04    1.60-0.40i      -0.75 
0.10   -0.04    1.40-0.40i      -0.75 
0.10   -0.04    1.20-0.40i      -0.75 
0.10   -0.04    0.85-0.40i      -0.75 
0.10   -0.04    0.65-0.40i      -0.75 
0.10   -0.04   +0.45-0.40i      -0.75 
0.10   -0.04   -0.25-0.40i      -0.75 
0.10   -0.04   -0.45-0.40i      -0.75 
0.10   -0.04   -0.65-0.40i      -0.75 
0.10   -0.04   -0.85-0.40i      -0.75 
0.10   -0.04   -1.20-0.40i      -0.75 
0.10   -0.04   -1.40-0.40i      -0.75 
0.10   -0.04   -1.60-0.40i      -0.75 

0.10   -0.04    1.35-0.60i       0.75
0.10   -0.04    1.15-0.60i       0.75
0.10   -0.04    0.85-0.57i       0.00
0.10   -0.04    0.55-0.57i       0.00
0.10   -0.04    0.27-0.57i       0.75
0.10   -0.04   -0.55-0.57i       0.00
0.10   -0.04   -0.85-0.57i       0.00
0.10   -0.04   -1.15-0.60i      -0.75
0.10   -0.04   -1.35-0.60i      -0.75

0.08   -0.05   -0.95-0.75i      -0.75
0.08   -0.05   -0.75-0.75i      -0.75
0.08   -0.05   -0.55-0.75i      -0.75
0.08   -0.05   -0.35-0.75i      -0.75
0.08   -0.05    0.15-0.75i      -0.75
0.08   -0.05    0.35-0.75i      -0.75
0.08   -0.05    0.55-0.75i      -0.75
0.08   -0.05    0.75-0.75i      -0.75
0.08   -0.05    0.95-0.75i       0.75

0.06   -0.04    0.00-0.88i       0.0
0.06   -0.04   -0.20-0.88i       0.0
];
%
aof       =   Aof(:,1);
bof       =   Aof(:,2);
cent      =   Aof(:,3);  
thof      =   Aof(:,4);
%
alpha  =  0.00;
zo     =  [inf;cent(2:end)];
m      =  length(zo);
% 
%
oo     =  zeros(n,1);
for k=1:m
    thet(1+(k-1)*n:k*n,1)    = thof(k)+oo;
end
%
for k=1:m
    et(1+(k-1)*n:k*n,1)  = cent(k)+exp(i*thof(k)).*( aof(k).*cos(t)+i*bof(k).*sin(t));
    etp(1+(k-1)*n:k*n,1) =         exp(i*thof(k)).*(-aof(k).*sin(t)+i*bof(k).*cos(t));
end
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
hold on; box on
for k=1:m
    c_cr    =  et((k-1)*n+1:k*n,1); c_cr(n+1)  =  c_cr(1);
    plot(real(c_cr),imag(c_cr),'k','LineWidth',1.5)
end
plot(real(alpha),imag(alpha),'pr')
axis equal
axis([-2.01  2.01  -2.01   2.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
%%

%%
map   =  gkiteran(et,etp,n,alpha,zo,gktol,maxgkitr);
zet   =  map.zet;
zetp  =  map.zetp;
z     =  map.z;
rad   =  map.rad;
%%

%%
[xh,yh] =   meshgrid(-1.995:0.01:1.995,-0.95:0.1:0.95);
zh       =   xh+1i.*yh;
for k=2:m
    zzh     =   exp(-i*thof(k)).*(zh-cent(k));
    qh1     =  (real(zzh)./aof(k)).^2+(imag(zzh)./bof(k)).^2>1.001;
    zh(~qh1)=  NaN+1i*NaN;
end
zzh      =   exp(-i*thof(1)).*(zh-cent(1)); 
qh1      =  (real(zzh)./aof(1)).^2+(imag(zzh)./bof(1)).^2<0.999;
zh(~qh1) =  NaN+1i*NaN;
zhv = zh(abs(zh)>=0).';
%
[xv,yv] =   meshgrid(-1.95:0.1:1.95,-0.99:0.01:0.99);
zv       =   xv+1i.*yv;
for k=2:m
    zzv     =   exp(-i*thof(k)).*(zv-cent(k));
    qv1     =  (real(zzv)./aof(k)).^2+(imag(zzv)./bof(k)).^2>1.001;
    zv(~qv1)=  NaN+1i*NaN;
end
zzv      =   exp(-i*thof(1)).*(zv-cent(1)); 
qv1      =  (real(zzv)./aof(1)).^2+(imag(zzv)./bof(1)).^2<0.999;
zv(~qv1) =  NaN+1i*NaN;
zvv = zv(abs(zv)>=0).';
%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
hold on; box on
plot(real(zhv),imag(zhv),'or','MarkerSize',1)
plot(real(zvv),imag(zvv),'ob','MarkerSize',1)
for k=1:m
    c_cr    =  et((k-1)*n+1:k*n,1); c_cr(n+1)  =  c_cr(1);
    plot(real(c_cr),imag(c_cr),'k','LineWidth',1.5)
end
% plot(real(alpha),imag(alpha),'pr')
axis equal
axis([-2.01  2.01  -2.01   2.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
set(gcf,'Renderer','painters')
print  -depsc -r500 FigGd4
%
whv       =  fcau(et,etp,zet,zhv);
wvv       =  fcau(et,etp,zet,zvv);
%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
hold on; box on
plot(real(whv),imag(whv),'or','MarkerSize',1)
plot(real(wvv),imag(wvv),'ob','MarkerSize',1)
for k=1:m
    c_cr    =  zet((k-1)*n+1:k*n,1); c_cr(n+1)  =  c_cr(1);
    plot(real(c_cr),imag(c_cr),'k','LineWidth',1.5)
end
axis equal
axis([-1.01  1.01  -1.01   1.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
set(gcf,'Renderer','painters')
print  -depsc -r500 FigOd4
%%
[xih,yih]=meshgrid([-1:0.001:1],[-0.95:0.1:0.95]);
zih=xih+i.*yih;
zih(abs(zih)>=1)=NaN+i*NaN;
for k=2:m
    zih(abs(zih-z(k))<=rad(k)-1e-6)=NaN+i*NaN;
end
zihv = zih(abs(zih)>=0).';
%
[xiv,yiv]=meshgrid([-0.95:0.1:0.95],[-1:0.001:1]);
ziv=xiv+i.*yiv;
ziv(abs(ziv)>=1)=NaN+i*NaN;
for k=2:m
    ziv(abs(ziv-z(k))<=rad(k)-1e-6)=NaN+i*NaN;
end
zivv = ziv(abs(ziv)>=0).';
%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
hold on; box on
plot(real(zihv),imag(zihv),'or','MarkerSize',1)
plot(real(zivv),imag(zivv),'ob','MarkerSize',1)
for k=1:m
    c_cr    =  zet((k-1)*n+1:k*n,1); c_cr(n+1)  =  c_cr(1);
    plot(real(c_cr),imag(c_cr),'k','LineWidth',1.5)
end
axis equal
axis([-1.01  1.01  -1.01   1.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
set(gcf,'Renderer','painters')
print  -depsc -r500 FigOv4
%
wihv       =  fcau(zet,zetp,et,zihv);
wivv       =  fcau(zet,zetp,et,zivv);
%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
hold on; box on
plot(real(wihv),imag(wihv),'or','MarkerSize',1)
plot(real(wivv),imag(wivv),'ob','MarkerSize',1)
for k=1:m
    c_cr    =  et((k-1)*n+1:k*n,1); c_cr(n+1)  =  c_cr(1);
    plot(real(c_cr),imag(c_cr),'k','LineWidth',1.5)
end
axis equal
axis([-2.01  2.01  -2.01   2.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
set(gcf,'Renderer','painters')
print  -depsc -r500 FigGv4
%%