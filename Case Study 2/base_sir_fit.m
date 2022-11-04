load("COVIDdata.mat");

coviddata = [COVID_STLmetro(1:100,"cases") COVID_STLmetro(1:100,"deaths")];
t = 100; % TO SPECIFY


% The following line creates an 'anonymous' function that will return the cost (i.e., the model fitting error) given a set
% of parameters.  There are some technical reasons for setting this up in this way.
% Feel free to peruse the MATLAB help at
% https://www.mathworks.com/help/optim/ug/fmincon.html
% and see the sectiono on 'passing extra arguments'
% Basically, 'sirafun' is being set as the function siroutput (which you
% will be designing) but with t and coviddata specified.
sirafun= @(x)siroutput(x,t,coviddata);

%% set up rate and initial condition constraints
% Set A and b to impose a parameter inequality constraint of the form A*x < b
% Note that this is imposed element-wise
% If you don't want such a constraint, keep these matrices empty.
A = [];
b = [];

%% set up some fixed constraints
% Set Af and bf to impose a parameter constraint of the form Af*x = bf
% Hint: For example, the sum of the initial conditions should be
% constrained
% If you don't want such a constraint, keep these matrices empty.
Af = [0 0 0 1 1 1 1];
bf = 1;

%% set up upper and lower bound constraints
% Set upper and lower bounds on the parameters
% lb < x < ub
% here, the inequality is imposed element-wise
% If you don't want such a constraint, keep these matrices empty.
ub = [1 1 1 0.999, 0.00001, 0.00001, 0.00001]';
lb = [0 0 0 0.9 0, 0, 0]';

% Specify some initial parameters for the optimizer to start from
x0 = [0.05, 0.01, 0.01, 0.999, 0.001,0,0]; 

% This is the key line that tries to opimize your model parameters in order to
% fit the data
% note tath you 
x = fmincon(sirafun,x0,A,b,Af,bf,lb,ub);

%plot(Y);
%legend('S','I','R','D');
%xlabel('Time')

Y_fit = siroutput_full(x,t);

figure(1);
plot((ones([t,1])'-Y_fit(1:100,1)).*STLmetroPop*10^4);
hold on;
plot(Y_fit(1:100,4).*STLmetroPop*10^4);
plot(table2array(coviddata(:,1)));
plot(table2array(coviddata(:,2)));
hold off;

% Make some plots that illustrate your findings.
% TO ADD