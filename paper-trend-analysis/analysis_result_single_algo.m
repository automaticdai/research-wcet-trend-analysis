%% read result from ./output/ans_*
%% clear environment & open dataset
clear           % clear workspace
clc             % clear command lines
format longG

addpath('../_help/')
addpath('../_dataset_trend/')
addpath('./output/')

DATASET_SIZE = 50;

sta_n = 0;
sta_valid_arr = zeros(DATASET_SIZE,1);
sta_invalid_arr = zeros(DATASET_SIZE,1);
sta_cor_arr = zeros(DATASET_SIZE,1);
sta_incor_arr = zeros(DATASET_SIZE,1);
sta_tp_arr = zeros(DATASET_SIZE,1);
sta_fp_arr = zeros(DATASET_SIZE,1);
sta_fn_arr = zeros(DATASET_SIZE,1);

%% openfile
for i = 1:DATASET_SIZE
    dataset_num = i;
    data_filename = sprintf('./output/ans_%d', dataset_num);
    load(data_filename);

    sta_n = sta_n + PER_N;
    sta_valid_arr(i) = PER_VALID;
    sta_invalid_arr(i) = PER_INVALID;
    sta_cor_arr(i) = PER_COR;
    sta_incor_arr(i) = PER_INCOR;
    sta_tp_arr(i) = PER_TP;
    sta_fp_arr(i) = PER_FP;
    sta_fn_arr(i) = PER_FN;
end

%% Plot result
subplot(7,1,1)
plot(sta_valid_arr)
title('Valid')

subplot(7,1,2)
plot(sta_invalid_arr)
title('Invalid')

subplot(7,1,3)
plot(sta_cor_arr)
title('Correct')

subplot(7,1,4)
plot(sta_incor_arr)
title('Incorrect')

subplot(7,1,5)
plot(sta_tp_arr)
title('True Positive')

subplot(7,1,6)
plot(sta_fp_arr)
title('False Positive')

subplot(7,1,7)
plot(sta_fn_arr)
title('False Negative')

%% Statistics
%stat_summary(PER_N, PER_VALID, PER_INVALID, PER_COR,PER_INCOR,PER_TP,PER_FP,PER_TN,PER_FN)
