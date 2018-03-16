% utau problem 
% hw 4 question 3
%
% use page 2 of linear estimation notes

clear all
load utau.mat;

% wind stress tau
% velocity u as a function of depth z

% eastward part real, northward part imaginary

% calculate gain (aka a)
%a = mean(conj(tau).*u)/mean(conj(tau).*tau);
a = (tau'*u)/(tau'*tau);

% determine skill as a function of depth
%skill = (mean(conj(tau).*u).*mean(conj(u).*tau))./(mean(conj(u).*u).*mean(conj(tau).*tau));
skill = ((tau'*u)*(u'*tau))./((u'*u)*(tau'*tau));


% estimate Ekman depth and latitude of these data
% De = (2*Av/f)^(1/2) where Av is the eddy viscosity and f is coriolis
% e-folding scale; take the log of the gain?
% use ekman spiral equation at surface?




