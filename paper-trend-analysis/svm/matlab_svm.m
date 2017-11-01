%% Linear Regression with LibSVM
% Xiaotian Dai
% University of York

%% configurations
tic;
close all;
clear;
clc;
format compact;

%% parameters
TRAINING_NUMBER = 1000;

% generate data
load('../../_dataset_trend/data_11')
x = x(1:TRAINING_NUMBER)';
y = y(1:TRAINING_NUMBER);

START_IDX = 400;
i = 400;
N_WINDOW_SIZE = 400;
nDataIndexStart = i - N_WINDOW_SIZE + 1;
nDataIndexEnd = i;
n = nDataIndexStart:nDataIndexEnd;
y_TrainingData = y(nDataIndexStart:nDataIndexEnd);  
    
BLOCK_SIZE = 40;
BLOCK_NUMBER = N_WINDOW_SIZE / BLOCK_SIZE;
t_y = reshape(y_TrainingData, BLOCK_SIZE, BLOCK_NUMBER);
[t_y, I] = max(t_y, [], 1);

t_i = 0:BLOCK_NUMBER - 1;
t_x = (i - START_IDX) + I + t_i .* BLOCK_SIZE;

% build regression model
model = svmtrain(t_y', t_x','-s 3 -t 0 -c 10 -p 0.1');

% predict data based on the trained model
py = svmpredict(y, x, model);
subplot(2,1,1);
scatter(x, y, '+');
hold on;
scatter(x, py, 'r*');
legend('Raw Data', 'Regression Data');
title('Data Set 1')
grid on;

% plot residuals
subplot(2,1,2);
title('Residuals Plot')
residual = y - py;
hold on;
line([1,TRAINING_NUMBER],[0,0])
scatter(x, residual, 'gx');
