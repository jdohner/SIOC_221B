%HW4 intgauss part c
%
% code adapted from Dan Rudnick

clear all
close all

scale=1;
noise=0.1;
t=(-5:0.1:5)';
d = [0.5; 1];

figure(1)
for n=2:20%2:20 %:20;
    t = linspace(scale*-1,scale,n)';
    skill=zeros(length(t),length(scale));
    x=zeros(size(skill));
    skillt=zeros(size(skill));
    xt=zeros(size(skill));
    %skill_zero = zeros(19,1); %vector to hold skill at x = 0
   % cov = data covariance matrix
   cov=[1+noise (1+(2/scale)^2)^-1; (1+(2/scale)^2)^-1 1+noise];
   % ct = covariance of data with the signal
   ct=[(1+((t+1)/scale).^2).^-1 (1+((t-1)/scale).^2).^-1];
   skill(:,1)=diag(ct/cov*ct');
   x(:,1)=ct/cov*d;
   ctt=-2/(scale.^2)*[t+1 t-1].*(ct.^2);
   skillt(:,1)=diag(ctt/cov*ctt')/(2/(scale.^2));
   xt(:,1)=ctt/cov*d;
   
   figure(1)
   hold on
   %plot(t,skill(:,1)),xlabel('t'),ylabel('skill')
   plot(t,skillt),xlabel('t'),ylabel('skill-dxdt')
end

figure;
subplot(2,1,1)
plot(t,x),xlabel('t'),ylabel('x');
title('Interpolations between input data points 0.5 and 1 with 0.1 N:S');

subplot(2,1,2)
plot(t,skill(:,1),'x'),xlabel('t'),ylabel('skill')

figure;
subplot(2,1,1)
plot(t,xt),xlabel('t'),ylabel('dxdt');

subplot(2,1,2)
plot(t,skillt),xlabel('t'),ylabel('skill-dxdt')
