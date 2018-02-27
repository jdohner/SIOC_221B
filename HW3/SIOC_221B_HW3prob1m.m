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
m_co = [m_u ; m_v]; % model parameters matrix
G_co = [G zeros(5,3); zeros(5,3) G];
Gco_g = (inv(G_co'*G_co)*G_co'); % G^-g in DR notes
% solution for model parameters in form m_co = Gco_g*d_co + v (eqn 50)

sigma = 3;
cov = Gco_g*(sigma^2*eye(10))*(Gco_g)'; % eqn 52 where sigma^2*I is <d'd'T>

% vi - calcaulte resulting error in vort, div and aav
% equation 56 in LSF notes

% variance in alpha given the data covariance matrix (eqn 57)
% vorticity, divergence and aav are all scalar quantities alpha = beta(m)
% question: what is the b vector in equation 55?
% b = [];
b_vort = [ 0 0 -1 0 1 0]';
b_div = [0 1 0 0 0 1]';
b_aav = [1 0 0 1 0 0]';
var_vort = sigma^2*b_vort'*Gco_g*Gco_g'*b_vort;
var_div = sigma^2*b_div'*Gco_g*Gco_g'*b_div;
var_aav = sigma^2*b_aav'*Gco_g*Gco_g'*b_aav;

% part b - enforce constraint that flow has - divergence

% i constr - calculate coefficient of each function in the fit (find m)
F = [0 1 0 0 0 1]; 
h = 0;
% solution to constraint given by equation 25:
m_cons = inv(G_co'*G_co)*(G_co'*d_co-F'*inv(F*inv(G_co'*G_co)*F')...
    *(F*inv(G_co'*G_co)*G_co'*d_co-h));

% ii constr - values of velocity at each instrument from the plane fit
calc_cons = G_co*m_cons;

% iii constr - misfit from L2 norm
% misfit = Gm-d' - Gm-d
misfit_cons = (G_co*m_cons-d_co)'*(G_co*m_cons-d_co);

%iv constr - the vorticity, divergence, and area-averaged velocity
vort_cons = m_cons(5) - m_cons(3);
div_cons = m_cons(2) + m_cons(6); % m_cons goes [b0u;b1u;b2u;b0v;b1v;b2v]
aav_cons = m_cons(1) + m_cons(4);

% v constr - covariance matrix 
Gcons_g = (eye(6,6) - inv(G_co'*G_co)*F'*inv(F*inv(G_co'*G_co)*F')*F)*inv(G_co'*G_co)*G_co';
cons_cov = Gcons_g*(sigma^2*eye(10))*(Gcons_g)';


% vi - calcaulte resulting error in vort, div and aav
% equation 56 in LSF notes

% variance in alpha given the data covariance matrix (eqn 57)
var_vort_cons = sigma^2*b_vort'*Gcons_g*Gcons_g'*b_vort;
var_div_cons = sigma^2*b_div'*Gcons_g*Gcons_g'*b_div;
var_aav_cons = sigma^2*b_aav'*Gcons_g*Gcons_g'*b_aav;