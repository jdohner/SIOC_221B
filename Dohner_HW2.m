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

x1=(rand(nvar,num/2)+1)*sqrt(12/nvar);
x2=(rand(nvar,num/2)-2)*sqrt(12/nvar);
x = horzcat(x1,x2);


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

var_x = 2;
mean_x = 0; % mean
x = var_x.*randn(100000,1) + mean_x;


var_y = 0.25;
mean_y = 0; % mean
y = var_y.*randn(100000,1) + mean_y;


% theta=0.5*atan(2*0.5/(1-0.5));
% xox=sqrt(cos(theta)^2+2*0.5*cos(theta)*sin(theta)+0.5*sin(theta)^2);
% yox=sqrt(0.5*cos(theta)^2-2*0.5*cos(theta)*sin(theta)+sin(theta)^2);
% xlim=5;
% nbin=50;

z = x.*y;


