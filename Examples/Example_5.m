clear
clc
%
addpath ../bie; addpath ../fmm; addpath ../files; addpath ../other;
%%
I = imread('image1.png');
%% Resize the image if image is to big then the number of boundary points is decrease 
[yrow,xcolm] = size(I);
xcolm        = xcolm/3;
uData = [ -xcolm/2   xcolm/2];  % Bounds for REAL(w)(input)
vData = [ +yrow/2   -yrow/2];  % Bounds for IMAG(w)(input)
xData = [ -1   1];  % Bounds for REAL(z)(output)
yData = [ +1   -1];  % Bounds for IMAG(z)(output)
figure, imshow(I)
figure(1)
imshow(I)
%% 2nd step
B = rgb2gray(I);
bw = im2bw(I, 0.99); %0.99 for example8,
%% 3rd step
bw = bwareaopen(bw,180); %% to remove the small white dots in the region
se = strel('disk',2);
bw = imclose(bw, se);
[row1 col1] = size (bw);
for k=1:row1
    for j=1:col1
        if bw(k,j)==0
            bw1(k,j)=1;
        else
            bw1(k,j)=0;
        end
    end
end
%%
[C1,L1] = bwboundaries(bw1,'noholes'); % C is for connectivity
[C,L]   = bwboundaries(bw,'noholes');
temp = 0;
for k = 2:length(C)
    boundaryb(1+temp:temp+size(C{k},1),:)=C{k};
    boundary = C{k};
    temp = temp+size(C{k},1);
end
boundarya = C1{1};
boundarya(:,2)=boundarya(:,2)-xcolm/2;
boundarya(:,1)=yrow/2-boundarya(:,1);
boundaryb(:,2)=boundaryb(:,2)-xcolm/2;
boundaryb(:,1)=yrow/2-boundaryb(:,1);
%%
zo = [-125+135i;0-225i;150+135i]; 
alpha = 120i;
%
figure
plot(boundarya(:,2), boundarya(:,1), 'k', 'LineWidth', 2)
hold on
plot(boundaryb(:,2), boundaryb(:,1), 'r', 'LineWidth', 2)
plot(real(zo),imag(zo),'pr')
plot(real(alpha),imag(alpha),'pb')
axis equal
%%
[row1 col1]=size(boundarya);
for k=1:row1 % Change the orentation from -ive to +ive orentation
    boundaryaa(k,1)=boundarya(row1-(k-1),2);
    boundaryaa(k,2)=boundarya(row1-(k-1),1);
end
[row1 col1]=size(boundaryb);
for k=1:row1 % don't Change the orentation because its inner boundary and should have -ive orentation
    boundarybb(k,1)=boundaryb(k,2);
    boundarybb(k,2)=boundaryb(k,1);
end
dlmwrite('myFileaa.txt', boundaryaa);
dlmwrite('myFilebb.txt', boundarybb);
%% parameterization
n =  2^12;
t       =  (0:2*pi/n:2*pi-2*pi/n).';
%
boundary2 = boundaryaa; 
% 
n1 = length(boundary2(:,1));
h1 = 2*pi/(n1-1);
t1 = [0:h1:2*pi].';
% 
xo = boundary2(:,1);    yo = boundary2(:,2);
px     = csape(t1,xo,'periodic');
px_d   = fnder(px,1);
xx     = ppval(px, t);
xxp    = ppval(px_d,t);
py     = csape(t1,yo,'periodic');
py_d   = fnder(py,1);
yy     = ppval(py, t);
yyp    = ppval(py_d,t);
% 
et     = xx + 1i * yy;
etp    = xxp + 1i * yyp;
%
con=1;
temp = 0;
for k = 2:length(C)
    boundary2 = boundarybb(1+temp:temp+size(C{k},1),:); 
    n1 = length(boundary2(:,1));
    h1 = 2*pi/(n1-1);
    t1 = [0:h1:2*pi].';
    temp = temp+size(C{k},1);
    xo = boundary2(:,1);
    yo = boundary2(:,2);
    px     = csape(t1,xo,'periodic');
    px_d   = fnder(px,1);
    xx     = ppval(px, t);
    xxp    = ppval(px_d,t);
    py     = csape(t1,yo,'periodic');
    py_d   = fnder(py,1);
    yy     = ppval(py, t);
    yyp    = ppval(py_d,t);
    %
    et(n*(k-1)+1:n*(k),1)     = xx + 1i * yy;
    etp(n*(k-1)+1:n*(k),1)    = xxp + 1i * yyp;
    %
    con = con+1;
end
%%
zo     =  [inf;zo];
m      =  length(zo);
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
hold on; box on
for k=1:m
    c_cr    =  et((k-1)*n+1:k*n-00,1); 
    plot(real(c_cr),imag(c_cr),'k','LineWidth',1.5)
    plot(real(zo(k)),imag(zo(k)),'pr')
end
% plot(real(zo),imag(zo),'pr')
plot(real(alpha),imag(alpha),'pb')
axis equal
axis([-400 400 -400 400])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
%%

%% select interior point
[xh,yh]  =  meshgrid(-400:25:400,-400:2:400);
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
[xv,yv]   =   meshgrid(-400:2:400,-400:25:400);
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
    c_cr    =  et((k-1)*n+1:k*n-00,1); c_cr(n+1)  =  c_cr(1);
    plot(real(c_cr),imag(c_cr),'k','LineWidth',1.5)
end
axis equal
axis([-400 400 -400 400])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGd5
%%
gktol =  1e-15;  maxgkitr = 15;
map   =  gkiteran(et,etp,n,alpha,zo,gktol,maxgkitr);
zet   =  map.zet;
zetp  =  map.zetp;
z     =  map.z;
rad   =  map.rad;
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
print -depsc FigOd5
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
print -depsc FigOv5
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
axis([-400  400 -400  400])
set(gca,'FontSize',14)
set(gca,'LooseInset',get(gca,'TightInset'))
print -depsc FigGv5
%%
for k=1:m
    Jk = (k-1)*n+1:k*n;
    d  = abs(zet(Jk)-z(k));
    R  = sum(d)/n;
    e(k) = (1/R)*sqrt(sum((d-rad(k)).^2)/n);
end
ee = mean(e)
%%
rz   =real(z);     iz   =imag(z);  
rzet =real(zet);   izet =imag(zet);  
rzetp=real(zetp);  izetp=imag(zetp);  
ret  =real(et);    iet  =imag(et);  
%
save('radf.mat', 'rad', '-ascii', '-double');
save('rzf.mat', 'rz', '-ascii', '-double');
save('izf.mat', 'iz', '-ascii', '-double');
save('rzetf.mat', 'rzet', '-ascii', '-double');
save('izetf.mat', 'izet', '-ascii', '-double');
save('rzetpf.mat', 'rzetp', '-ascii', '-double');
save('izetpf.mat', 'izetp', '-ascii', '-double');
save('retf.mat', 'ret', '-ascii', '-double');
save('ietf.mat', 'iet', '-ascii', '-double');
%%
im = I;
ring1 = maketform('custom', 2, 2, [], @circular_img, []);
Bring1 = imtransform(im, ring1, 'cubic',...
                    'UData', uData,  'VData', vData,...
                    'XData', xData, 'YData', yData,...
                    'Size', [800 800], 'FillValues', 255 );

% axes(handles.axes2);
figure
imshow(Bring1)
print -dpng image2
%%