% -------------------------------------------------------------------------
% Experimental Data Generator
% Generate Data Set with Random Sampled Execution Time and Ejected Trend.
% -------------------------------------------------------------------------
% Xiaotian Dai
% RTS Group
% University of York
% -------------------------------------------------------------------------
format longG
clc
clf
clear

%% Experiment Configures
% the number of sampling instance
SAMPLING_NUM = 1000;

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

%% Generate Task Execution Times
%               BCET --> Nominal ET -->  WCET
SAMPLE_SET    = [50     80      100     120];
SAMPLE_WEIGHT = [0.5    0.2     0.2     0.1];

%C_i = randsample(SAMPLE_SET, SAMPLING_NUM, true, SAMPLE_WEIGHT);
[C_i ,C_idx] = datasample(SAMPLE_SET, SAMPLING_NUM, ...
                        'Weights', SAMPLE_WEIGHT);

% Add Gaussian Noise
noise_std = randn(1, SAMPLING_NUM); 
noise_std = noise_std / std(noise_std); 
noise_std = noise_std - mean(noise_std);
noise = NOISE_MEAN + sqrt(NOISE_VAR) * noise_std; 

% Eject Trend
t = 0 :SAMPLING_NUM - 1;

switch TREND_TYPE
    case 'Linear'
        trend = t.*0.07;
    case 'Quadratic'
        trend = t.^2*0.0001;
    case 'Log'
        trend = log2(t./200 + 1).* 20; 
    case 'None'
        trend = t.*0;
end

% Add delay
trend = [zeros(TREND_DELAY, 1)' trend(1: SAMPLING_NUM - TREND_DELAY)];

% Produce synthesized data
x = 1:SAMPLING_NUM;

y = C_i + noise;
idx = (C_idx == TREND_PATH);
y(idx) = y(idx) + trend(idx);


% plot indicator lines
x_tmp = ones(1, 100) * SAMPLING_NUM * 0.3;
y_tmp = linspace(1, max(y), 100);
plot(x_tmp, y_tmp, 'g');
hold on;

x_tmp = ones(1, 100) * SAMPLING_NUM * 0.7;
y_tmp = linspace(1, max(y), 100);
plot(x_tmp, y_tmp, 'g');

x_tmp = 1:SAMPLING_NUM;
y_tmp = ones(1, SAMPLING_NUM) * 150;
plot(x_tmp, y_tmp, 'g');

% plot y and the original trend
plot(x, y)

hold on;
plot(x, trend, 'g')

% save to file
%save('../_dataset/data_g2s4', 'SAMPLING_NUM', 'x', 'y', 'trend', 'noise', 'C_i', 'C_idx');
