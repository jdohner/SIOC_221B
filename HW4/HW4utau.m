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
for i = 1
    skill(i) = ((tau'*u(i))*(u(i)'*tau))/((u(i)'*u(i))*(tau'*tau));
end



% estimate Ekman depth and latitude of these data
% De = (2*Av/f)^(1/2) where Av is the eddy viscosity and f is coriolis
% e-folding scale; take the log of the gain?
% use ekman spiral equation at surface?




