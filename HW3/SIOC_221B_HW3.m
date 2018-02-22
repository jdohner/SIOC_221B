% HW 3
% SIOC 221B
% Feb 21, 2018
% Julia Dohner

%% question 1

x = [10 0 -10 0 0];
y = [0 10 0 -10 0];
u = [35.5 53.5 49.2 33.5 43.5]';
v = [21.3 30.4 24.8 18.4 25.5]';
G = [ones(5,1) x' y'];

% i - calculate the coefficient of each function in the fit
m_u = inv(G'*G)*G'*u;
m_v = inv(G'*G)*G'*v;

% ii - values of velocity at each instrument from the plane fit
calc_u = G*m_u;
calc_v = G*m_v;

% iii - the misfit as measured by the L2 norm
% misfit = Gm-d' - Gm-d
misfit_u = (G*m_u-u)'*(G*m_u-u);
misfit_v = (G*m_v-v)'*(G*m_v-v);

%iv - the vorticity, divergence, and area-averaged velocity

vort = m_v(2) - m_u(3);
div = m_u(2) + m_v(3);
aav = m_u(1) + m_v(1); % area averaged velocity "is just b0" - which b0?

%v - covariance matrix 

d_co = [u ; v];
m_co = [m_u ; m_v];
G_co = [G zeros(5,3); zeros(5,3) G];

% tbh not sure why we're using these:
% why did we only want b1u and b2v?
a_u = [0 1 0]';
a_v = [0 0 1]';

%a_u'*m_u + a_v'*m_v = 
% confused here- this seems redundance since we already have m_co above
m_co = (inv(G_co'*G_co)*G_co')*d_co;

% cov should be NxN matrix, correct? N being 5 here... or will it be 6x6?
% not sure what dimensions of identity matrix to use. Rn produces 6x6 cov
% matrix.
cov = ...
(inv(G_co'*G_co)*G_co')*(3*eye(10))*(inv(G_co'*G_co)*G_co')';


% consider equation (55) in LSF notes? "If the function beta(m) is linear,
% alpha = beta(m) (eqn 53) can be rewritten as alpha = beta'*m;
%alpha = m

% vi - calcaulte resulting error in vort, div and aav
% equation 56 in LSF notes


%% question 2

Ti = [2.5 0.0 4.0 -1.5];
Si = [34.9 34.7 34.4 -34.7];
Ci = [0.90 0.88 0.87 -0.77];

%A = [1 1 1 -1; 2.5 0.0 4.0 1.5; 34.9 34.7 34.4 34.7; 0.90 0.88 0.87 0.77];
A = [1 1 1 -1; Ti ; Si ; Ci ];
B = [0 -3.8e6 0 2.3e6*0.77];

% use linsolve to solve AX = B for the vectors of unknowns X
X = linsolve(A,B');
