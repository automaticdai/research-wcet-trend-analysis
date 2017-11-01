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

USE_YARCC  = 0;

%% Experiment Configuration
% the number of sampling instance
DATASET_NUM = 60;
WCET_MAX_LIMITATION = 200;
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

A = [0.9  0.1   0.0   0;
     0.8  0.2   0.15  0.05; 
     0.3  0.05  0.8   0.05; 
     0.2  0.0   0.0   0.8];

E = [20 100 140 150];

%% Generate Slopes
% Group A: 1 - 10
% Group B: 11 - 60
% k1: 11 - 20
% k2: 21 - 30
% k3: 31 - 40
% k4: 41 - 50
% k5: 51 - 60
trend_k_array = zeros(DATASET_NUM, 1);
trend_k_array(11:20) = 0.01;
trend_k_array(21:30) = 0.02;
trend_k_array(31:40) = 0.03;
trend_k_array(41:50) = 0.04;
trend_k_array(51:60) = 0.05;

if (USE_YARCC == 0)
    h = waitbar(0,'Initializing waitbar...');
end

%rpmat()

%% Generate Task Execution Times
for kk = 1:DATASET_NUM
    % sampling number
    if (trend_k_array(kk) == 0)
        SAMPLING_NUM = round((WCET_MAX_LIMITATION - 150.0) / 0.01);
    else
        SAMPLING_NUM = round((WCET_MAX_LIMITATION - 150.0) / trend_k_array(kk));
    end
    
    % trend
    x = 1:SAMPLING_NUM;
    trend = x.*trend_k_array(kk);
    
    % noise
    noise_std = randn(1, SAMPLING_NUM); 
    noise_std = noise_std / std(noise_std); 
    noise_std = noise_std - mean(noise_std);
    noise = NOISE_MEAN + sqrt(NOISE_VAR) * noise_std; 
    
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
    
    trend_k = trend_k_array(kk);
    % save to file
    if (USE_YARCC == 0)
        data_filename = sprintf('../_dataset_trend/data_%d', kk);
    else
        data_filename = sprintf('_dataset_trend//data_%d', kk);
    end
    
    save(data_filename, 'SAMPLING_NUM', 'x', 'y', 'trend', 'trend_k', ... 
        'noise', 'WCET_MAX_LIMITATION', '-v7.3');
    
    % print progress
    perc = kk/DATASET_NUM;
    
    if (USE_YARCC == 0)
        waitbar(perc, h, sprintf('Dataset Generated: %0.1f%%',perc * 100))
    end
end

close(h)