clear           % clear workspace
clc             % clear command lines
close all

format longG

preprocessing_cell = [{'raw'},{'max'},{'r'}];

for i = 1:3
    h_plot_k_error(char(preprocessing_cell(i)))
end
