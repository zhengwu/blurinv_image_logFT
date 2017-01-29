function Q = ComputeImageQDirect(xi1,xi2,ft_r,b,e)

% e=0 is polynomial metric
% e=1 is exponential metric 

del1  = xi1(1,2) - xi1(1,1);
del2  = xi2(2,1) - xi2(1,1);


if e == 0

%Polynomial
%z = InnProdPoly(xi,xi.*xi,xi.*xi,b);
%h = -(xi.*xi)/sqrt(z);

z = InnProdPolyImage(xi1,xi2,pi*(xi1.*xi1+xi2.*xi2),pi*(xi1.*xi1+xi2.*xi2),b,e);
h = -(pi*(xi1.*xi1+xi2.*xi2))/sqrt(z);
%h = -sqrt(5/2)*(xi.*xi);
Q = InnProdPolyImage(xi1,xi2,ft_r,h,b,e);

else

z = InnProdPolyImage(xi1,xi2,pi*(xi1.*xi1+xi2.*xi2),pi*(xi1.*xi1+xi2.*xi2),b,e);
h = -(pi*(xi1.*xi1+xi2.*xi2))/sqrt(z);
Q = InnProdPolyImage(xi1,xi2,ft_r,h,b,e);

end