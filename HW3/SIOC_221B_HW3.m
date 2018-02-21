% HW 3
% SIOC 221B
% Feb 21, 2018
% Julia Dohner

%% question 1

x = [10 0 -10 0 0];
y = [0 10 0 -10 0];
u = [35.5 53.5 49.2 33.5 43.5];
v = 21.3 30.4 24.8 18.4 25.5];

% y = b0 + b1*x + error


%% question 2

% Ti = [2.5 0.0 4.0 1.5];
% Si = [34.9 34.7 34.4 34.7];
% Ci = [0.90 0.88 0.87 0.77];

A = [1 1 1 -1; 2.5 0.0 4.0 1.5; 34.9 34.7 34.4 34.7; 0.90 0.88 0.87 0.77];
B = [0 -3.8e6 0 2.3e6*0.77];

% use linsolve to solve AX = B for the vectors of unknowns X
X = linsolve(A,B');
