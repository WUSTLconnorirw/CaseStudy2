%% This function takes three inputs
% x - a set of parameters
% t - the number of time-steps you wish to simulate

function f = siroutput_full(x,t)

% Here is a suggested framework for x.  However, you are free to deviate
% from this if you wish.

% set up transmission constants
k_infections = x(1);
k_fatality = x(2);
k_recover_immuned = x(3);
k_recover_not_immuned = x(4);
% set up initial conditions
ic_susc = x(5);
ic_inf = x(6);
ic_rec = x(7);
ic_fatality = x(8);

% Set up SIRD within-population transmission matrix
A = [1-k_infections k_recover_not_immuned 0 0; 
     k_infections   1-k_recover_immuned-k_recover_not_immuned-k_fatality...
     0 0; 0 k_recover_immuned 1 0; 0 k_fatality 0 1];

% The next line creates a zero vector that will be used a few steps.
B = zeros(4,1);

% Set up the vector of initial conditions
x0 = [x(5) x(6) x(7) x(8)];

% Here is a compact way to simulate a linear dynamical system.
% Type 'help ss' and 'help lsim' to learn about how these functions work!!
sys_sir_base = ss(A,B,eye(4),zeros(4,1),1);
y = lsim(sys_sir_base,zeros(t,1),linspace(0,t-1,t),x0);

% return the output of the simulation
f = y;

end
