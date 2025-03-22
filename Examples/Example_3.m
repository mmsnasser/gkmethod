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
cent      =  [ 0;   -0.70; 0.90];
radx      =  [ 4.00; 0.16; 2.00];
rady      =  [ 2.00;-1.60;-1.40];
%%
alpha  = -0.3;
zo     =  [inf;cent(2:end)];
m      =  length(zo);
% 
for k=1:m
    et(1+(k-1)*n:k*n,1)    =  cent(k)+0.5.*(+radx(k).*cos(t)+i*rady(k).*sin(t));
    etp(1+(k-1)*n:k*n,1)   =          0.5.*(-radx(k).*sin(t)+i*rady(k).*cos(t));
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
map   =  gkiteran(et,etp,n,alpha,zo,gktol,maxgkitr);
zet   =  map.zet;
zetp  =  map.zetp;
z     =  map.z;
rad   =  map.rad;
%%
[xh,yh]=meshgrid([-2:0.001:2],[-0.98,-0.95:0.1:0.95,0.98]);
zh=xh+i.*yh;
zho = 2.*(zh-cent(1));
zh((real(zho)./radx(1)).^2+(imag(zho)./rady(1)).^2>=1)=NaN+i*NaN;
zho = 2.*(zh-cent(2));
zh((real(zho)./radx(2)).^2+(imag(zho)./rady(2)).^2<=1)=NaN+i*NaN;
zho = 2.*(zh-cent(3));
zh((real(zho)./radx(3)).^2+(imag(zho)./rady(3)).^2<=1)=NaN+i*NaN;
zhv = zh(abs(zh)>=0).';
%%
[xv,yv]=meshgrid([-1.95,-1.9:0.2:1.9,1.95],[-1:0.001:1]);
zv=xv+i.*yv;
zvo = 2.*(zv-cent(1));
zv((real(zvo)./radx(1)).^2+(imag(zvo)./rady(1)).^2>=1)=NaN+i*NaN;
zvo = 2.*(zv-cent(2));
zv((real(zvo)./radx(2)).^2+(imag(zvo)./rady(2)).^2<=1)=NaN+i*NaN;
zvo = 2.*(zv-cent(3));
zv((real(zvo)./radx(3)).^2+(imag(zvo)./rady(3)).^2<=1)=NaN+i*NaN;
zvv = zv(abs(zv)>=0).';
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
% plot(real(alpha),imag(alpha),'pr')
axis equal
axis([-2.01  2.01  -2.01   2.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGd3
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
print -depsc FigOd3
%%
[xih,yih]=meshgrid([-1:0.001:1],[-0.98,-0.95:0.1:0.95,0.98]);
zih=xih+i.*yih;
zih(abs(zih)>=1)=NaN+i*NaN;
zih(abs(zih-z(2))<=rad(2)-1e-6)=NaN+i*NaN;
zih(abs(zih-z(3))<=rad(3)-1e-6)=NaN+i*NaN;
zihv = zih(abs(zih)>=0).';
%%
[xiv,yiv]=meshgrid([-0.98,-0.95:0.1:0.95,0.98],[-1:0.001:1]);
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
print -depsc FigOv3
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
axis([-2.01  2.01  -2.01   2.01])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGv3
%%