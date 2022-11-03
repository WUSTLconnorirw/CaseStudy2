suscept = 0.75;
infected = 0.10;
recovered = 0.10;
dead = 0.05;

% (xt+1)1 = 0.95(xt)1 + 0.04(xt)2.
% (xt+1)2 = 0.85(xt)2 + 0.05(xt)1;
% (xt+1)3 = (xt)3 + 0.10(xt)2
% (xt+1)4 = (xt)4 + 0.01(xt)2

initialCondition = [1;
                    0;
                    0;
                    0];

A = [0.95,0.05,0,0;
     0.05,0.85,0,0;
     0,0.10,1,0;
     0,0.01,0,1];
X = [0.5 0.01 0.1 0.4 0.9 0.1 0 0];
y = siroutput_full(X,1000);
plot(y);


% function timeMatrix = model(t)
%     for i = 1:t
%         timeMatrix = A * A;
%     end



%matrix = zeros(4,100);
%matrix(:,1)=A * transpose([1,0,0,0]);

%for i = 2:100
%    matrix(:,i)=A*matrix(:,i-1);
%end

%figure(1)
%plot(1:100, matrix(1,:));
%hold on;
%plot(1:100, matrix(2,:));
%plot(1:100, matrix(3,:));
%plot(1:100, matrix(4,:));
%legend('Susceptible', 'Infected', 'Recovered', 'Dead')

% The model assumes the following happens over each day.
% • 5% of the susceptible population will acquire the disease. (The other 95%
% will remain susceptible.)
% • 1% of the infected population will die from the disease, 10% will recover
% and acquire immunity, and 4% will recover and not acquire immunity (and
% therefore, become susceptible). The remaining 85% will remain infected.
