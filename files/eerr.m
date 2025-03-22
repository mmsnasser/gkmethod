function ee = eerr(zet,m,n)
% 
for k=1:m
    Jk       =  (k-1)*n+1:k*n;
    [xo yo rad(k,1)] = circle_fit(real(zet(Jk)),imag(zet(Jk)));
    z(k,1)=xo+i*yo;
end    
for k=1:m
    Jk = (k-1)*n+1:k*n;
    d  = abs(zet(Jk)-z(k));
    R  = sum(d)/n;
    e(k) = (1/R)*sqrt(sum((d-rad(k)).^2)/n);
end
ee = mean(e);
% 
end