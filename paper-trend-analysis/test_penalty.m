clc;
clear;

HFP = 5000;
R = 400;
D = 200;
alpha = 3;

for i = 1: HFP
    p(i) = h_calc_penalty(i, HFP, D, R, alpha);
end

plot(p)