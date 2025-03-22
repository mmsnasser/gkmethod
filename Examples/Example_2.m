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
Ro        =   6+0.8.*cos(18.*t);
Rop       =  -14.4.*sin(18.*t);
at        =   -0.1-0.4i+Ro.*exp(i.*t);
atp       =  (Rop+Ro.*i).*exp(i.*t);
%%
et(1:n,1)      = at;  
etp(1:n,1)     = atp;  
%%
zo = [-1-3i;-2+2i;1];
%%
R2        =   01.2+0.4.*cos(8.*t);
R2p       =       -3.2.*sin(8.*t);
R3        =   1.0+0.4.*cos(6.*t);
R3p       =      -2.4.*sin(6.*t);
R4        =   1.0+0.6.*cos(4.*t);
R4p       =      -2.4.*sin(4.*t);
%%
k  =  2; Jk = 1+(k-1)*n:k*n;
et( Jk,1) = zo(1)+R2.*exp(-i.*t);
etp(Jk,1) =   (R2p-i.*R2).*exp(-i.*t);
k  =  3; Jk = 1+(k-1)*n:k*n;
et( Jk,1) =  zo(2)+R3.*exp(-i.*t);
etp(Jk,1) =    (R3p-i.*R3).*exp(-i.*t);
k  =  4; Jk = 1+(k-1)*n:k*n;
et( Jk,1) = zo(3)+R4.*exp(-i.*t);
etp(Jk,1) =    (R4p-i.*R4).*exp(-i.*t);
%%
alpha     =   3.5;
zo     =  [inf;zo];
m      =  length(zo);
%
map   =  gkiteran(et,etp,n,alpha,zo,gktol,maxgkitr);
zet   =  map.zet;
zetp  =  map.zetp;
z     =  map.z;
rad   =  map.rad;
%%

%%
[xh,yh]   =   meshgrid(-7.25:0.725:7.25,-7.25:0.05:7.25);
zh2 = xh+i.*yh;
zh1 = zh2(abs(zh2)>=0);
node  =  [real(et(1:n)) imag(et(1:n))];
p1h = [real(zh1) imag(zh1)];
inh = inpoly(p1h,node);
zh1(~inh) = NaN+i*NaN;
for k=1:m-1
    Jk = k*n+1:(k+1)*n;
    node  =  [real(et(Jk)) imag(et(Jk))];
    inh = inpoly(p1h,node);
    zh1(inh) = NaN+i*NaN;
end
zhv = zh1(abs(zh1)>=0).';
%%
[xv,yv]   =   meshgrid(-7.25:0.05:7.25,-7.25:0.725:7.25);
zv2 = xv+i.*yv;
zv1 = zv2(abs(zv2)>=0);
node  =  [real(et(1:n)) imag(et(1:n))];
p1v = [real(zv1) imag(zv1)];
inv = inpoly(p1v,node);
zv1(~inv) = NaN+i*NaN;
for k=1:m-1
    Jk = k*n+1:(k+1)*n;
    node  =  [real(et(Jk)) imag(et(Jk))];
    inv = inpoly(p1v,node);
    zv1(inv) = NaN+i*NaN;
end
zvv = zv1(abs(zv1)>=0).';
%% 
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
axis equal
axis([-7.125  7.125  -7.25   7.0])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGd2
%%
whv       =  fcau(et,etp,zet,zhv);
wvv       =  fcau(et,etp,zet,zvv);
%%
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
print -depsc FigOd2
%%
[xih,yih]=meshgrid(-1:0.001:1,-0.95:0.1:0.95);
zih=xih+i.*yih;
zih(abs(zih)>=1)=NaN+i*NaN;
zih(abs(zih-z(2))<=rad(2)-1e-6)=NaN+i*NaN;
zih(abs(zih-z(3))<=rad(3)-1e-6)=NaN+i*NaN;
zih(abs(zih-z(4))<=rad(4)-1e-6)=NaN+i*NaN;
zihv = zih(abs(zih)>=0).';
%%
[xiv,yiv]=meshgrid(-0.95:0.1:0.95,-1:0.001:1);
ziv=xiv+i.*yiv;
ziv(abs(ziv)>=1)=NaN+i*NaN;
ziv(abs(ziv-z(2))<=rad(2)-1e-6)=NaN+i*NaN;
ziv(abs(ziv-z(3))<=rad(3)-1e-6)=NaN+i*NaN;
ziv(abs(ziv-z(4))<=rad(4)-1e-6)=NaN+i*NaN;
zivv = ziv(abs(ziv)>=0).';
%%
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
print -depsc FigOv2
%%
wihv       =  fcau(zet,zetp,et,zihv);
wivv       =  fcau(zet,zetp,et,zivv);
%%
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
axis([-7.125  7.125  -7.25   7.0])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGv2
%%