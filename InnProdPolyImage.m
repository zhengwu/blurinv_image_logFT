function x = InnProdPolyImage(xi1,xi2,ft_r1,ft_r2,b,e)
% e=0 polynomial metric
% e=1 exponential metric

dxi1 = xi1(1,2) - xi1(1,1);
dxi2 = xi2(2,1) - xi2(1,1);

%id = find(xi == 0);

if e==0
ax1  = abs(xi1);
ax2  = abs(xi2);

%if xi1 is not a matrix
%Polynomial Metric
tmp=sqrt(ax1.^2+ax2.^2);
term = (1./(1 + tmp).^b);
%Exponential Metric
%term = exp(-pi*xi.*xi);
x = sum(sum(dxi1*real(ft_r1.*ft_r2).*term,1)*dxi2);
else 
    eterm = exp(-pi*(xi1.^2+xi2.^2));
    x = sum(sum(dxi1*real(ft_r1.*ft_r2.*eterm),1)*dxi2);
end;
