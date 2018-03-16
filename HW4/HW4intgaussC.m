%HW4 intgauss part c
%
% code adapted from Dan Rudnick

clear all; close all

scale=1;
noise=0;
t=(-5:0.1:5)';
d = [0.5; 1];
vals = zeros(19,1);


for n=2:20
   t = linspace(scale*-1,scale,n)';
   cov = zeros(n,n);
   
   % populate covariance matrix
   for i=1:n % rows
       for j=1:n % cols
           cov(i,j) = (1+((t(i)-t(j))/scale)^2)^-1;
       end
   end
   cov = cov+eye(n,n)*noise;
   
   dx = -(1+((0-t)/scale).^2).^(-2).*(2*(0-t)/(scale^2)); % n x 1
   ddx = 2/(scale^2);
   skillt = (dx'*inv(cov)*dx)/(ddx);
   vals(n-1) = skillt;
   
end

figure
plot(2:20,vals,'x')
title('plot of skill at x = 0 with increasing number of data')
