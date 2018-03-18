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
a = zeros(1,length(z));
for i = 1:length(z)
    a(i) = (tau(i)'*u(i))/(tau(i)'*tau(i));
end

% determine skill as a function of depth
skill = zeros(1,length(z));
for i = 1:length(z)
    skill(i) = ((tau'*u(i))*(u(i)'*tau))/((u(i)'*u(i))*(tau'*tau));
end


% estimate Ekman depth and latitude of these data
% De = (2*Av/f)^(1/2) where Av is the eddy viscosity and f is coriolis
% e-folding scale; take the log of the gain?
% use ekman spiral equation at surface?

% Ekman spiral surface equation
rho = 1025;
De = (1+i)*z(2)/log(a(2)/a(1));
depthEk = real(De);

f = (1-i)/a(1)/rho/depthEk;
lat = real(asind(real(f)/2/7.29E-5));
