clear           % clear workspace
clc             % clear command lines
close all

format longG

preprocessing_cell = [{'raw'},{'max'},{'r'}];

DATASET_NUM = 50;
arr_k_pen = zeros(DATASET_NUM, 5, 3);

for m = 1:3
    premethod_str = char(preprocessing_cell(m));
    
    rmpath('./result_raw/')
    rmpath('./result_max/')
    rmpath('./result_r/')
    addpath(sprintf('./result_%s/', premethod_str))
    
    methods_cell = [{'ideal'}; {'linear_regression'}; {'theil_sen'}; {'svr'}; {'evd'}];
    %figure()
    for j = 1:5
        load(sprintf('stat_%s',char(methods_cell(j))));
        
        for i = 1:DATASET_NUM
            % handle NaN
            if isnan(stat(i).K_MEAN)
                stat(i).K_MEAN = 0;
            end
            if isnan(stat(i).K_VAR)
                stat(i).K_VAR = 0;
            end
            
            arr_k_pen(i, j, m) = stat(i).PENALTY;
        end

        %plot(arr_k_pen(:,j))
        hold on;
    end

    labels_cell = {'IDP','LR','THEIL','SVR','EVD'};
    for i = 1:5
        labels_cell(i) = cellstr(strcat(char(labels_cell(i)), upper(['-' premethod_str])));
    end
    %legend(labels_cell)
end

arr_k_pen_mean = zeros(DATASET_NUM / 10, 5, 3);

[mean(arr_k_pen(:,:,1));mean(arr_k_pen(:,:,2));mean(arr_k_pen(:,:,3))]
[std(arr_k_pen(:,:,1));std(arr_k_pen(:,:,2));std(arr_k_pen(:,:,3))]



