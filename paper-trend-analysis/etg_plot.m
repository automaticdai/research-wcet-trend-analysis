clear all       % clear workspace
close all       % clear windows
clc             % clear command lines
format longG

addpath('../_dataset_trend/')
load('data_41')

figure
scatter(1:length(y), y)

figure
plot(y)
axis([1 1000 0 300])
title('Execution Time Observations')
xlabel('t')
ylabel('C_i')