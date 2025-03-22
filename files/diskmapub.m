function map = diskmapub(et,etp,n,zi)
% diskmapub.m
% Nasser, Aug 24, 2024
% 
% the function diskmapub(et,etp,n,zi) computes the conformal mapping
% w = Phi(z) from the unbounded domain onto the unit disk
% with the normalizations Phi(inf)=0 and c=Phi'(inf)>0. 
%
% Input:
% 1) et, etp: the parametrization of the boundary of G and its derivative
% 2) zi is a point in the exterior of G, i.e., zo is G^c which is 
%    bounded  
% 
% Output:
% 1) zet=Phi(et) and zetp is the derivative of zet.
% 2) c=Phi'(inf)>0 
% 
% Note that the boundary of G must be oriented such that G is on the 
% left of its boundary.
% 
% See Section 3.3 in:
% M.M.S. Nasser, Fast computation of the circular map, Comput. Methods 
% Funct. Theory (2015) 15:187–223
%
A       =  ones(size(et)); 
gam     =  log(abs(et-zi));
[phn,h] =  fbie(et,etp,A,gam,n,5,[],1e-14,100);
c       =  exp(-mean(h)); fet = gam+h+i.*phn;
zet     = (c./(et-zi)).*exp(fet);
zetp    =  derfft(real(zet))+i*derfft(imag(zet));
%
map.zet  =  zet;
map.zetp =  zetp;
map.c    =  c;
%
end