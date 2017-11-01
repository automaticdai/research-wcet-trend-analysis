clear; clc;

load('k_mean_max.mat')
k_max = arr_k_mean;

for i = 2:5
   a = k_max(:,i);
   [min(a) median(a) mean(a) max(a) std(a)]
end

load('k_mean_r.mat')
k_r = arr_k_mean;

for i = 2:5
   a = k_r(:,i);
   [min(a) median(a) mean(a) max(a) std(a)]
end