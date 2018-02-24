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

% tbh not sure why we're using these:
% why did we only want b1u and b2v?
a_u = [0 1 0]';
a_v = [0 0 1]';

%a_u'*m_u + a_v'*m_v = 
% confused here- this seems redundance since we already have m_co above


% cov should be NxN matrix, correct? N being 5 here... or will it be 6x6?
% not sure what dimensions of identity matrix to use. Rn produces 6x6 cov
% matrix.
sigma = 3;
cov = Gco_g*(sigma^2*eye(10))*(Gco_g)'; % eqn 52 where sigma^2*I is <d'd'T>


% consider equation (55) in LSF notes? "If the function beta(m) is linear,
% alpha = beta(m) (eqn 53) can be rewritten as alpha = beta'*m;
%alpha = m

% vi - calcaulte resulting error in vort, div and aav
% equation 56 in LSF notes

% variance in alpha given the data covariance matrix (eqn 57)
% vorticity, divergence and aav are all scalar quantities alpha = beta(m)
% question: what is the b vector in equation 55?
% b = [];
% var_vort = sigma^2*b'*Gco_g*G_cog'*b;
% var_div = sigma^2*b'*Gco_g*Gco_g'*b;
% var_aav = sigma^2*b'*Gco_g*Gco_g'*b;

% part b - enforce constraint that flow has - divergence
% equation 19
% div = 0, figure out F and h
% solution is equation 25
% solution such that F*m_co = 0 (to represent div = 0) div = b1u + b2v

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
% already have this I think? All the above calcs are done with G_co because
% F is defined in terms of m_co

% d_co = [u ; v];
% m_co = [m_u ; m_v]; % model parameters matrix
% G_co = [G zeros(5,3); zeros(5,3) G];
% Gco_g = (inv(G_co'*G_co)*G_co'); % G^-g in DR notes


% vi - calcaulte resulting error in vort, div and aav
% equation 56 in LSF notes

% variance in alpha given the data covariance matrix (eqn 57)
% vorticity, divergence and aav are all scalar quantities alpha = beta(m)
% question: what is the b vector in equation 55?
% b = [];
% var_vort = sigma^2*b'*Gco_g*G_cog'*b;
% var_div = sigma^2*b'*Gco_g*Gco_g'*b;
% var_aav = sigma^2*b'*Gco_g*Gco_g'*b;

%% question 2

% Gm = d
% model params are transports

Ti = [2.5 0.0 4.0 -1.5];
Si = [34.9 34.7 34.4 -34.7];
Ci = [0.90 0.88 0.87 -0.77];

%A = [1 1 1 -1; 2.5 0.0 4.0 1.5; 34.9 34.7 34.4 34.7; 0.90 0.88 0.87 0.77];
G = [1 1 1 -1; Ti ; Si ; Ci ];
d = [0 -3.8e6 0 2.3e6*0.77]';

% use linsolve to solve AX = B for the vectors of unknowns X
X = linsolve(G,d);

% calculate the coefficient of each function in the fit
% solve for the transports of each water mass
m = inv(G'*G)*G'*d;

% results physically meaningful (all non-negative, where u1 u2 and u3 are
% incoming, and u4 is outgoing in equation 1

% proportions of water masses
CW = m(4);
NADW_frac = m(1)/CW;
AABW_frac = m(2)/CW;
PIW_frac = m(3)/CW;

% residence time
CW_volume = 6e17;
tau = CW_volume/CW; % in seconds

% part 2


% 3 data, 4 unknowns- underdetermined proble, did in class, smallest model
% in L2 norm)
%
% will have null space, can add any part of null space and satisfy the
% equation
%
% want all transports to be positive, add some something null space, find
% some of the null space via singular value decomposition- use MATLAB
% command
%
% can add in some of null space to bump up the transport so that they're
% all positive and physically reasonable

G_cut = G(1:3,:);
d_cut = d(1:3);
m_cut = G_cut'*inv(G_cut*G_cut')*d_cut; % smallest model in L2 norm (minimized)
% transports are not physical because some of them are negative

% can the ui be made non-negative while still satisfying the equations 1-3?
% null space of G: subspace consisting of all solutions to Gm = 0
null_G = null(G_cut); 
nullMin = min(null_G);
G_bump = G_cut + nullMin; %null_G(2); % maybe not right bc still neg?
m_bump = G_bump'*inv(G_bump*G_bump')*d_cut;


