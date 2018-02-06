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



%% Question 3

clear all
num = 100000;
nvar=input('Number of random variables to sum ');
limit = 5*nvar; % just set limits for different cases
bin=-limit:0.1:limit;

xp=((rand(nvar,num))+1);
xn=((rand(nvar,num))-2);
x = horzcat(xp,xn);
for i = 1:size(x,1)
    x(i,:) = x(i,randperm(length(x)));
end


% each dataset is a row
y=sum(x,1); % row vector containing sum of each column

%histogram(y,bin'Normalization','pdf');
n=hist(y,bin);
pdfy=n/num/(bin(2)-bin(1));
bar(bin,pdfy);



fprintf('mean = %f\n',mean(y));
fprintf('2nd moment = %f\n',moment(y,2));
fprintf('3rd moment = %f\n',moment(y,3));
fprintf('4th moment = %f\n',moment(y,4));
fprintf('5th moment = %f\n',moment(y,5));
fprintf('6th moment = %f\n',moment(y,6));


%% Question 4

clear all

% Generate joint-normally-distributed variables x and y such that the mean 
% of x and y are 0, the variance of x = 2, variance of y = 0.25, and the 
% mean of x*y = 0.5.
% Do this by generating two independent normally distributed
% variables, then scaling and rotating them. 

num=100000;

varx = 2;
vary = .25;
varxy = .5;

theta=0.5*atan(2*varxy/(varx-vary));
xox=sqrt((varx.*cos(theta)^2)+(2*varxy*cos(theta)*sin(theta))+(vary*sin(theta)^2));
yox=sqrt(vary.*cos(theta)^2-2*varxy*cos(theta)*sin(theta)+varx*sin(theta)^2);

x=xox*randn(num,1);
y=yox*randn(num,1);

z=x+i*y;
z=z*exp(i*theta);
x=real(z);
y=imag(z);

histogram2(x, y, 100,'Normalization', 'pdf')

calcmean_y = mean(y);
calcvar_y = var(y);

calcmean_x = mean(x);
calcvar_x = var(x);

calcmean_z = mean(z);
calccov = cov(x,y);

fprintf('calculated mean of y = %f\n',calcmean_y);
fprintf('calculated mean of x = %f\n',calcmean_x);
fprintf('calculated mean of z = %f\n',calcmean_z);
fprintf('calculated variance of y = %f\n',calcvar_y);
fprintf('calculated variance of x = %f\n',calcvar_x);
fprintf('calculated covariance of x and y = %f\n',calccov);
