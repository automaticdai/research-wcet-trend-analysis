 %--------------------------------------------------------------------------
% Xiaotian Dai
% Real-Time System Research Group
% University of York
%--------------------------------------------------------------------------
% [main.m]
% change ANALYSIS_METHOD and PROCESSING_METHOD
%
% [analysis_result_combined]
% bar charts comparison of block maxima (valid/invliad etc.)
%
% [analysis_result_error_k_all]
% error analysis of k
% !run analysis_result_error_k first!


%% clear environment & open dataset
clear all       % clear workspace
close all       % clear windows
clc             % clear command lines
format longG
%warning off all

DATASET_NUMBER = 50;

%ANALYSIS_METHOD = 'ideal';
%ANALYSIS_METHOD = 'linear_regression';
%ANALYSIS_METHOD = 'theil_sen';
%ANALYSIS_METHOD = 'svr';
ANALYSIS_METHOD = 'evd';

%PROCESSING_METHOD = 'raw';
PROCESSING_METHOD = 'max';
%PROCESSING_METHOD = 'r';

addpath('../_help/')
addpath('../_dataset_trend/')
addpath('./svm/')

stat = struct('PER_N',0,'PER_VALID',0,'PER_INVALID',0,'PER_COR', 0, ...
           'PER_INCOR',0,'PER_TP',0,'PER_FP',0,'PER_TN',0,'PER_FN',0, ...
           'K_MEAN', 0, 'K_VAR', 0, 'PENALTY', 0);
       
% loop through dataset
for dataset_num = 1:DATASET_NUMBER
    
    close all;         % clear figures
    pd_previous = makedist('Normal','mu',1234,'sigma',0);  % for evd (hack)
   
    %% load dataset
    % dataset description
    %   1:100   no trend
    % 101:1000  [0.05 0.30]
    dataset_name = sprintf('data_%d.mat', dataset_num);
    load(dataset_name)

    %% Experiment Configurations
    % training set size
    % trainging_num + cross_valid_num + improvement_num = overall_sampling_num
    % 1 - 300, 301 - 700, 701 - 1000
    TRAINING_SAMPLING_NUM = SAMPLING_NUM * 0.3;
    IMPROVEMENT_SAMPLING_NUM = SAMPLING_NUM * 0.4;
    CROSS_VALID_INDEX = 1 + TRAINING_SAMPLING_NUM + IMPROVEMENT_SAMPLING_NUM;
 
    CURVE_ORDER = 1;

    % index for the dataset
    N_WINDOW_SIZE = 400; % 400
    BLOCK_SIZE = 20; % 20
    
    START_IDX = N_WINDOW_SIZE;
    STEP_SIZE = 0.1 * N_WINDOW_SIZE; % 40
    END_IDX = SAMPLING_NUM;
    
    % performance measurements
    PER_N = 0;

    PER_VALID = 0;
    PER_INVALID = 0;
    PER_COR = 0;
    PER_INCOR = 0;
    PER_TP = 0;
    PER_FP = 0;
    PER_TN = 0;
    PER_FN = 0;
    
    Penalty = 0;
    
    % important regions
    D = 200;      % deadline
    R = 400;      % response time, algorithm stops at (A - R)
    B = N_WINDOW_SIZE * 10;    % boundary that treats as no trend
    S = 800;      % satisfactory region
    R_alpha = 3;  % for penalty function
    
    % find the HFP
    HFP = h_find_hfp(trend_k, 150, WCET_MAX_LIMITATION);
    
    fprintf('\n\n\nDataset = %d, HFP = %d, S = %d, R = %d, B = %d \n\n\n', ...
            dataset_num, HFP, S, R, B)

    %% Plot 
    % plot raw data
    subplot(2,1,1);
    plot(x, y);
    xlabel('Sampling Num');
    ylabel('WCET');
    title('WCET Observations and Estimation');
    hold on;
    grid on;

    % plot indicator lines
    % HFP
    if (HFP <= SAMPLING_NUM)
        xxx = ones(1, 100) * double(HFP);
        yyy = linspace(1, max(y), 100);
        plot(xxx, yyy, 'r', 'LineWidth', 2);
    end
    
    % HFP - D
    if (HFP - D <= SAMPLING_NUM)
        xxx = ones(1, 100) * double(HFP - D);
        yyy = linspace(1, max(y), 100);
        plot(xxx, yyy, 'y', 'LineWidth', 2);
    end
    
    % HFP - R
    if (HFP - R <= SAMPLING_NUM)
        xxx = ones(1, 100) * double(HFP - R);
        yyy = linspace(1, max(y), 100);
        plot(xxx, yyy, 'g', 'LineWidth', 2);
    end

    % plot S region
    subplot(2,1,2)
    axis([0 SAMPLING_NUM -inf inf])

    xxx = linspace(1, SAMPLING_NUM, 100);
    yyy = ones(1,100) * 0;
    plot(xxx, yyy, 'g');
    hold on;

    xxx = linspace(1, SAMPLING_NUM, 100);
    yyy = ones(1,100) * double(S);
    plot(xxx, yyy, 'g');
    hold on;
    
    xxx = linspace(1, SAMPLING_NUM, 100);
    yyy = ones(1,100) * double(-S);
    plot(xxx, yyy, 'g');
    hold on;

    %input('pause');

    %% Identify the trend using polynomial curve fitting
    k_est_array = zeros(1, SAMPLING_NUM);
    
    % loop inside a dataset
    % use 'parfor' to improve performances
    for i = START_IDX:END_IDX
        if rem((i - START_IDX), STEP_SIZE) ~= 0
            continue
        end
        
        fprintf('t = %4d \t', i)

        nDataIndexStart = i - N_WINDOW_SIZE + 1;
        nDataIndexEnd = i;
        x_TrainingData = nDataIndexStart:nDataIndexEnd;
        y_TrainingData = y(nDataIndexStart:nDataIndexEnd);   

        % data pre-processing
        % (x,y_TrainingData -> t_x, t_y)
        switch PROCESSING_METHOD
            case 'raw'
                t_x = x_TrainingData;
                t_y = y_TrainingData';
            case 'max'
                BLOCK_NUMBER = N_WINDOW_SIZE / BLOCK_SIZE;
                % one column one block
                t_y = reshape(y_TrainingData, BLOCK_SIZE, BLOCK_NUMBER);
                [t_y, I] = max(t_y, [], 1);

                t_i = 0:BLOCK_NUMBER - 1;
                t_x = (i - START_IDX) + I + t_i .* BLOCK_SIZE;
            case 'r'
                a = 1;
                t_x = x_TrainingData;
                t_y = y_TrainingData;
                
                BLOCK_NUMBER = N_WINDOW_SIZE / BLOCK_SIZE;
                % one column one block
                t_y = reshape(y_TrainingData, BLOCK_SIZE, BLOCK_NUMBER);
                
                % 3-largest values
                [t_y, idx] = sort(t_y, 'descend');
                t_y = t_y(1:3,:);
                t_i = [0:BLOCK_NUMBER - 1; 0:BLOCK_NUMBER - 1; 0:BLOCK_NUMBER - 1];
                t_x = (i - START_IDX) + idx(1:3,:) + t_i .* BLOCK_SIZE;
                t_x = t_x(:)';
                t_y = t_y(:)';
            otherwise
                warning('Unexpected type.')
        end
  
        % apply analysis method
        switch ANALYSIS_METHOD
            case 'ideal' 
                [p, EFP] = f_ideal(WCET_MAX_LIMITATION, trend_k, S);
            case 'linear_regression'
                [p, EFP] = f_linear_regression(t_x, t_y, WCET_MAX_LIMITATION, CURVE_ORDER);
            case 'theil_sen'
                [p, EFP] = f_theil_sen(t_x, t_y, WCET_MAX_LIMITATION, CURVE_ORDER);
            case 'svr'
                [p, EFP] = f_svr(t_x, t_y, WCET_MAX_LIMITATION, CURVE_ORDER);
            case 'evd'
                [p, EFP, pd] = f_evd(t_x, t_y, WCET_MAX_LIMITATION, CURVE_ORDER, STEP_SIZE, i, pd_previous); pd_previous = pd;
            otherwise
                warning('Unexpected type.')
        end
              
        est_k = p(1);
        est_b = p(2);
        EFP = floor(EFP);
        
        e_k = trend_k - est_k;
        e_h = HFP - EFP;
        k_est_array(i) = e_k;
        
        fprintf('est_k = %.3f \t est_b = %.1f \t', est_k, est_b)
        fprintf('e_k = %0.4f \t', e_k)
        fprintf('e_h = %0.1f \t', e_h)
        
       %% performance measurement
        PER_N = PER_N + 1;
        
        % valid / invalid for estiamtion
        if (EFP == inf)
            fprintf('EFP = inf, no trend (k < 0), ')
            if (HFP == inf)
                PER_VALID = PER_VALID + 1;
            else
                PER_INVALID = PER_INVALID + 1;
            end
        elseif (EFP > i + B)
            fprintf('EFP = %d, no trend (P(t) > t + B), ', EFP)
            if (HFP > i + B)
                PER_VALID = PER_VALID + 1;
            else
                PER_INVALID = PER_INVALID + 1;
            end            
        else
            fprintf('EFP = %d, error = %d, ', EFP, e_h)
            subplot(2,1,2)
            if (e_h <= S && e_h >= -S) 
                scatter(i, e_h, 'gx');
                PER_VALID = PER_VALID + 1;
            else
                scatter(i, e_h, 'rx');
                PER_INVALID = PER_INVALID + 1;
            end
            hold on;
        end
        
        fprintf('\n')
        
        % tp / tn / fn / fp for control behaviour
        % FN is domanitaing as this is the normal behaviour
        if (i < HFP - R)
            if (i >= EFP - R)
                PER_FP = PER_FP + 1;
                PER_INCOR = PER_INCOR + 1;
                Penalty = Penalty + h_calc_penalty(i, HFP, D, R, R_alpha);
            else
                PER_TN = PER_TN + 1;
                PER_COR = PER_COR + 1;
            end            
        else
            if (i >= EFP - R)
                PER_TP = PER_TP + 1;
                PER_COR = PER_COR + 1;
            else
                PER_FN = PER_FN + 1;
                PER_INCOR = PER_INCOR + 1;
                Penalty = Penalty + h_calc_penalty(i, HFP, D, R, R_alpha);
            end
        end
 
        
        subplot(2,1,1);
       
        % plot selected points
        scatter(t_x, t_y);
        
        % plot estimated y
        y_hat = polyval(p, t_x);
        l = plot(t_x, y_hat, 'r', 'LineWidth', 1); l.Color(4) = 0.2;
        
        pause(0.05);

%%
    end % end for 

    %% Statistics  
    stat(dataset_num).PER_N = PER_N;    
    stat(dataset_num).PER_VALID = PER_VALID;
    stat(dataset_num).PER_INVALID = PER_INVALID;
    stat(dataset_num).PER_COR = PER_COR;
    stat(dataset_num).PER_INCOR = PER_INCOR;
    stat(dataset_num).PER_TP = PER_TP;
    stat(dataset_num).PER_FP = PER_FP;
    stat(dataset_num).PER_TN = PER_TN;
    stat(dataset_num).PER_FN = PER_FN;
    stat(dataset_num).K_MEAN = mean(k_est_array(k_est_array ~= 0));
    stat(dataset_num).K_VAR = var(k_est_array(k_est_array ~= 0));
    stat(dataset_num).PENALTY = Penalty;
    
    h_summary(PER_N, PER_VALID, PER_INVALID, ...
                PER_COR,PER_INCOR,PER_TP,PER_FP,PER_TN,PER_FN)

    %% Save result of a single dataset to file
    data_filename = sprintf('./output/ans_%d', dataset_num);
    save(data_filename, 'PER_N', 'PER_VALID', 'PER_INVALID', 'PER_COR', ...
        'PER_INCOR', 'PER_TP', 'PER_FP', 'PER_TN', 'PER_FN');

end

%% save result of all datasets
data_filename = sprintf('./result_%s/stat_%s', PROCESSING_METHOD, ANALYSIS_METHOD);
save(data_filename, 'stat');