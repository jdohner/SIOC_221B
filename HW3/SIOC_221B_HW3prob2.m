% HW 3 question 2

%% question 2

clear all

% Gm = d
% model params are transports

Ti = [2.5 0.0 4.0 -1.5];
Si = [34.9 34.7 34.4 -34.7];
Ci = [0.90 0.88 0.87 -0.77];

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
const = 0;
ratio = m_cut./null_G;
min = min(ratio);
%G_bump = G_cut + null_G.*const;
m_bump = m_cut-min.*null_G;

% proportions of different water masses
CW_und = m_bump(4);
NADW_frac_und = m_bump(1)/CW_und;
AABW_frac_und = m_bump(2)/CW_und;
PIW_frac_und = m_bump(3)/CW_und;

% residence time CW
tau_und = CW_volume/CW_und;

