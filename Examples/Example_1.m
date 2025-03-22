clear
clc
%
addpath ../bie; addpath ../fmm; addpath ../files; addpath ../other;
%%
n =  2^10;
t       =  (0:2*pi/n:2*pi-2*pi/n).';
%%
gktol   =   1e-13;  maxgkitr = 100;
%%
cent      =  [ -0.0+0.2i;  0.1-0.3i; -0.1+0.5i];
alpha  =  cent(1);
zo     =  [inf;cent(2:end)];
m      =  length(zo);
% 
%%
p          =   0.5;
r          =   sqrt(1-(1-p^2).*(cos(t)).^2);
rp         =  (1-p^2).*sin(2.*t)./(2.*r);
k  =  1; Jk = 1+(k-1)*n:k*n;
et( Jk,1) =   r.*exp(i.*t);
etp(Jk,1) =  (rp+i.*r).*exp(i.*t);
k  =  2; Jk = 1+(k-1)*n:k*n;
et( Jk,1) =  cent(2)+0.2.*cos(t)-0.4i.*sin(t);
etp(Jk,1) =         -0.2.*sin(t)-0.4i.*cos(t);
k  =  3; Jk = 1+(k-1)*n:k*n;
et( Jk,1) =  cent(3)+0.3.*cos(t)-0.2i.*sin(t);
etp(Jk,1) =         -0.3.*sin(t)-0.2i.*cos(t);
%%
map   =  gkiteran(et,etp,n,alpha,zo,gktol,maxgkitr);
zet   =  map.zet;
zetp  =  map.zetp;
z     =  map.z;
rad   =  map.rad;
%%

%%
[xh , yh] = meshgrid([-1:0.1:1],[-1:0.01:1]);
zh2 = xh+i.*yh;
zh1 = zh2(abs(zh2)>=0);
node  =  [real(et(1:n)) imag(et(1:n))];
p1h = [real(zh1) imag(zh1)];
inh = inpoly(p1h,node);
zh1(~inh) = NaN+i*NaN;
zh1((real(zh1-zo(2))./0.2).^2+(imag(zh1-zo(2))./0.4).^2<=1)=NaN+i*NaN;
zh1((real(zh1-zo(3))./0.3).^2+(imag(zh1-zo(3))./0.2).^2<=1)=NaN+i*NaN;
zhv = zh1(abs(zh1)>=0).';
%%
[xv , yv] = meshgrid([-1:0.01:1],[-1:0.1:1]);
zv2 = xv+i.*yv;
zv1 = zv2(abs(zv2)>=0);
node  =  [real(et(1:n)) imag(et(1:n))];
p1v = [real(zv1) imag(zv1)];
inv = inpoly(p1v,node);
zv1(~inv) = NaN+i*NaN;
zv1((real(zv1-zo(2))./0.2).^2+(imag(zv1-zo(2))./0.4).^2<=1)=NaN+i*NaN;
zv1((real(zv1-zo(3))./0.3).^2+(imag(zv1-zo(3))./0.2).^2<=1)=NaN+i*NaN;
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
axis([-1.01  1.01  -1.01   1.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGd1
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
print -depsc FigOd1
%%
[xih,yih]=meshgrid(-1:0.001:1,-0.95:0.1:0.95);
zih=xih+i.*yih;
zih(abs(zih)>=1)=NaN+i*NaN;
zih(abs(zih-z(2))<=rad(2)-1e-6)=NaN+i*NaN;
zih(abs(zih-z(3))<=rad(3)-1e-6)=NaN+i*NaN;
zihv = zih(abs(zih)>=0).';
%%
[xiv,yiv]=meshgrid(-0.95:0.1:0.95,-1:0.001:1);
ziv=xiv+i.*yiv;
ziv(abs(ziv)>=1)=NaN+i*NaN;
ziv(abs(ziv-z(2))<=rad(2)-1e-6)=NaN+i*NaN;
ziv(abs(ziv-z(3))<=rad(3)-1e-6)=NaN+i*NaN;
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
print -depsc FigOv1
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
axis([-1.01  1.01  -1.01   1.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGv1
%%