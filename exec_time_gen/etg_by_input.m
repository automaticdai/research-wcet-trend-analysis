%% Execution Time Generator
% Generat Execution Time from A Parametric Model
% C(t) = f(size_of_data(t))

%% Project configuration
clc
clf
clear

format long;

%% Main
SAMPLING_NUM = 1000;
NOISE_MEAN = 0;    % white noise
NOISE_VAR = 10;    % variance

noise_std = randn(1, SAMPLING_NUM); 
noise_std = noise_std / std(noise_std); 
noise_std = noise_std - mean(noise_std);
noise = NOISE_MEAN + sqrt(NOISE_VAR) * noise_std; 

% input data
t = 1:1000;
d = ((sin(t./20) + t.*0.002) .* 20) + 80 + noise;

plot(d);
hold on;

C_i = 0.01 * d .^ 2 + 50;
C_i2 = 0.5 * d .* log2(d);
C_i3 = 1.05 .^d + 350;

plot(C_i);
plot(C_i2);
plot(C_i3);

legend('input data', 'C_1(t): n^2', 'C_2(t): n*log2(n)', 'C_3(t): C^n');

%% Seasonal Naive Approach
y = zeros(1,1000);
y(1:200) = d(1:200);
T = 127;

for h = 1:600
    k = ceil((h - 1)/T + 0.1);
    y(200 + h) = y(200 + h - k*T);
end

%plot(y);
