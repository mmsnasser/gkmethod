function w = circular_img(z1,t)
%
zv = complex(z1(:,1),z1(:,2));
%
rad=load('radf.mat', '-ascii');
%
rz=load('rzf.mat', '-ascii');
iz=load('izf.mat', '-ascii');
z = rz+i*iz;
%
rzet=load('rzetf.mat', '-ascii');
izet=load('izetf.mat', '-ascii');
zet = rzet+i*izet;
%
rzetp=load('rzetpf.mat', '-ascii');
izetp=load('izetpf.mat', '-ascii');
zetp = rzetp+i*izetp;
%
ret=load('retf.mat', '-ascii');
iet=load('ietf.mat', '-ascii');
et = ret+i*iet;
%
zv(abs(zv)>=1)=NaN+i*NaN;
zv(abs(zv-z(2))<=rad(2))=NaN+i*NaN;
zv(abs(zv-z(3))<=rad(3))=NaN+i*NaN;
zv(abs(zv-z(4))<=rad(4))=NaN+i*NaN;
zvv = zv(abs(zv)>=0).';
%
wvv=fcau(zet,zetp,et,zvv).';
%
wv = (1+i)*NaN(size(zv));
wv(abs(zv)>=0) = wvv.';
%
w(:,1) = real(wv);
w(:,2) = imag(wv);
end