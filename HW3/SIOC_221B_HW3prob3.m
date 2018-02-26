% hw 3
% julia dohner
% question 3


% 8 datum (sound speed thru each row and column)
% 16 model parameters
% underdetermined problem
% answer with smallest model size with L2 norm
% 16 parameters, 8 unknowns
% pinv to find

% d = Gm_real answer
% m by m matrix, every row is approximation of delta function


% G is 16x8 matrix
% d is 8x1 (da or db)
% m is 16x1 of slowness parameters
G = [ 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0; % summing first column of slowness vals
    0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0; % summing second column of slowness vals etc etc
    0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1;
    1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0; % same but thru rows
    0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0;
    0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0;
    0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 ];

% calculate m
%m_a = G'*inv(G*G')*da;
%m_b = G'*inv(G*G')*db;
m_a = pinv(G)*da;
m_b = pinv(G)*db;

% sing prec means here that rows aren't all linearly indepdentn, not all
% giving new info in the end, lin dep because can make one of the rows from the
% others. Have one too many conditions, one is redundant
% stabilization- can add value of lambda, tiny portion
% pseduo-inverse will work

% calculate resolution for matrix
G_g = pinv(G);%m_a; %(inv(G'*G)*G'); %G_g is whatever is multiplying the data
% a lot of different solutions, one is constraint, etc, long and torturous
% for part 1
R = G_g*G;
% each one of rows of R is the approximation to a delta fx I get from the
% solution, can take a row 9 would be approx of delta function to position
% 9 on the grid from the hw problem-- biggest at column 9, then get smaller

% i don't have perfect resolution because i dont have enough data to know
% it perfectly/have perfect resolution

%plot 
plot(1:size(R,1),R(6,:));