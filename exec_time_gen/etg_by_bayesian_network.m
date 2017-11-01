% -------------------------------------------------------------------------
% Experimental Data Generator
% Generate Data Set with Random Sampled Execution Time and Ejected Trend.
% -------------------------------------------------------------------------
% Xiaotian Dai
% RTS Group
% University of York
% -------------------------------------------------------------------------
format longG
clc; close all; clear

%% Experiment Configures
% the number of sampling instance
SAMPLING_NUM = 1000;
STEPS = 10;

% trend type
%TREND_TYPE = 'None'
TREND_TYPE = 'Linear';
%TREND_TYPE = 'Quadratic';
%TREND_TYPE = 'Log';

TREND_PATH = 4;
TREND_DELAY = 300;

% noise config
NOISE_MEAN = 0;    % white noise
NOISE_VAR = 10;    % variance

S = [1 2 3 4];
A = [0.9  0.1   0.0  0;
     0.8  0.0   0.15 0.05; 
     0.7  0.05  0.2  0.05; 
     0.2  0     0    0.8];
 
%  A = [0.8  0.2  0   0;
%      0.7  0.1  0.7 0; 
%      0.7  0.1  0   0.2; 
%      1.0  0    0   0];
E = [80 100 120 150];
 
%% Generate Task Execution Times
% noise
noise_std = randn(1, SAMPLING_NUM); 
noise_std = noise_std / std(noise_std); 
noise_std = noise_std - mean(noise_std);
noise = NOISE_MEAN + sqrt(NOISE_VAR) * noise_std; 

% trend
x = 1:SAMPLING_NUM;
trend = x.*0.05;

% init ct, wcet and state
ct = zeros(STEPS, 1);
y = zeros(SAMPLING_NUM, 1);
current_state = 1;

for j = 1:SAMPLING_NUM
    for i = 1:STEPS
        next_state = randsample(S, 1, true, A(current_state,:));
        ct(i) = E(next_state) + noise(j);
        if next_state == 4
            ct(i) = ct(i) + trend(j);
        end
        current_state = next_state;
    end
    y(j) = max(ct);
end

%%
figure
scatter(1:length(y), y)

figure
plot(y)
axis([1 length(y) 0 max(y)])
title('Execution Time Observations')
xlabel('t')
ylabel('y')

% save to file
%5save('../_dataset/data_g3s1', 'SAMPLING_NUM', 'x', 'y', 'trend', 'noise');