% Plot distribution of estimation error k 
% this function plot all results in a folder (a single preprocessing method)

function [] = h_plot_k_error(premethod_str)
    DATASET_NUM = 50;
    arr_k_mean = zeros(DATASET_NUM, 5);
    
    rmpath('./result_raw/')
    rmpath('./result_max/')
    rmpath('./result_r/')
    addpath(sprintf('./result_%s/', premethod_str))
    
    methods_cell = [{'ideal'}; {'linear_regression'}; {'theil_sen'}; {'svr'}; {'evd'}];
    figure()
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
            
            arr_k_mean(i, j) = stat(i).K_MEAN;
            arr_k_var(i, j) = stat(i).K_VAR;
        end

        plot(arr_k_mean(:,j), '-x')
        hold on;
    end

    labels_cell = {'IDP','OLR','TSE','SVR','EVD'};
    for i = 1:5
        labels_cell(i) = cellstr(strcat(char(labels_cell(i)), upper(['-' premethod_str])));
    end
    legend(labels_cell)
    
    % axis
    xlabel('Dataset Index')
    
    % plot subgroup lines
    for i = 1:5
        xxx = ones(1,100) * i * 10;
        a = ylim;
        yyy = linspace(a(1), a(2), 100);
        plot(xxx, yyy, 'Color', [0.5, 0.5, 0.5], 'LineStyle', '--');
        
        hold on;
    end
    
    figure()
    boxplot(arr_k_mean, 'labels',labels_cell)
    %title(premethod_str)
    hold on;
    
    filename_str = sprintf('k_mean_%s', premethod_str);
    save(filename_str, 'arr_k_mean')
end
