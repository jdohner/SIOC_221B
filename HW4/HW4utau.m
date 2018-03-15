% utau problem 
% hw 4 question 3
%
% use page 2 of linear estimation notes

clear all
load utau.mat;

% wind stress tau
% velocity u as a function of depth z

% eastward part real, northward part imaginary

% determine the gain a for each depth z that minimizes the MSE

% prediction of u (y) based on tau (x)
% choose an optimum value for alpha (minimize MSE)

a = cov(u,tau);

% a. determine the gain a for each depth z (11 depths) that minimizes MSE
gain=zeros(11,1);
for i = 1:length(z)
    gain(i) = a;
end

% b. determine the skill as a function of depth



