function map = annmapbu(et,etp,n,zf,z0)
% annmap.m
% Nasser, Aug 24, 2024
% This function computes the conformal mapping w=Phi(z) from bounded or
% unbounde doubly connected domain G onto the annulus q<|w|<1 where:
% et, etp:  the parametrization of the boundary of G and its derivative 
% n: the number of discretization points
% alpha is a given point in $G$ for bounded G
% z0 is a given point interior to the curve that will be maped onto the 
% circle |w|=q
% zf is a given point interior to the curve that will be maped onto the 
% circle |w|=1 for unbounded G and zo=inf for bounded G
% See Section 4.1 (m=1) in:
% M.M.S. Nasser, Numerical conformal mapping via a boundary integral
% equation with the generalized Neumann kernel, SIAM J. SCI. COMPUT. Vol.
% 31, No. 3, pp. 1695-1715.  
% 
A   =  ones(size(et)); 
gam = -log(abs((et-z0)./(et-zf)));
[mun,h] =  fbie(et,etp,A,gam,n,5,[],1e-14,100); 
c = exp(-mean(h(1:n)));
zet = c*((et-z0)./(et-zf)).*exp(gam+h+i.*mun);    
%
for k=1:2
    Jk=(k-1)*n+1:k*n;
    zetp(Jk,1) = derfft(real(zet(Jk)))+i*derfft(imag(zet(Jk)));
end
% 
map.zet  =  zet;
map.zetp =  zetp;
map.c    =  c;
% 
end