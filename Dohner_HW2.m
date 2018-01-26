% SIOC 221B
% HW #2
%
% January 25, 2018

% Question 2:
% Consider two independent random variables x and y, uniformly distributed between 0 and a.
% What is the probability density function of the variable z = xy? Hint: First, find the cumulative
% distribution function of z.  

a = 0;
b = 50;
x = (b-a).*rand(10e3,1) + a;
y = (b-a).*rand(10e3,1) + a;

z = x.*y;

figure
histogram(x,100,'Normalization','pdf')
figure
histogram(z,100,'Normalization','cdf')
figure
histogram(z,100,'Normalization','pdf')

