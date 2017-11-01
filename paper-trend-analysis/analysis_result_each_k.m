
%% clear environment & open dataset
clear           % clear workspace
clc             % clear command lines
format longG

addpath('../_help/')
addpath('../_dataset_trend/')
addpath('./output/')

DATASET_SIZE = 50;
GROUP_SIZE = 10;
GROUPED_SET_SIZE = DATASET_SIZE;

%% ideal
sta_n = 0;
sta_valid_arr = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr = zeros(GROUPED_SET_SIZE,1);

load('stat_ideal');

for i = 1:(DATASET_SIZE)

    %a = a + stat(i * j + j).PER_N;
    b = stat(i).PER_VALID;
    c = stat(i).PER_INVALID;
    d = stat(i).PER_COR;
    e = stat(i).PER_INCOR;
    f = stat(i).PER_TP;
    g = stat(i).PER_FP;
    h = stat(i).PER_FN;        

    
    %sta_n = double(a) / GROUP_SIZE;
    sta_valid_arr(i) = double(b);
    sta_invalid_arr(i) = double(c);
    sta_cor_arr(i) = double(d);
    sta_incor_arr(i) = double(e);
    sta_tp_arr(i) = double(f);
    sta_fp_arr(i) = double(g);
    sta_fn_arr(i) = double(h);
end

%% linear regression
sta_n_a = 0;
sta_valid_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr_a = zeros(GROUPED_SET_SIZE,1);

load('stat_linear_regression');

for i = 1:(DATASET_SIZE)

    %a = a + stat(i * j + j).PER_N;
    b = stat(i).PER_VALID;
    c = stat(i).PER_INVALID;
    d = stat(i).PER_COR;
    e = stat(i).PER_INCOR;
    f = stat(i).PER_TP;
    g = stat(i).PER_FP;
    h = stat(i).PER_FN;        

    %sta_n_a = double(a) / GROUP_SIZE;
    sta_valid_arr_a(i) = double(b);
    sta_invalid_arr_a(i) = double(c);
    sta_cor_arr_a(i) = double(d);
    sta_incor_arr_a(i) = double(e);
    sta_tp_arr_a(i) = double(f);
    sta_fp_arr_a(i) = double(g);
    sta_fn_arr_a(i) = double(h);
end

%% theil-sen
sta_n_b = 0;
sta_valid_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr_b = zeros(GROUPED_SET_SIZE,1);

load('stat_theil_sen');

for i = 1:(DATASET_SIZE)

    %a = a + stat(i * j + j).PER_N;
    b = stat(i).PER_VALID;
    c = stat(i).PER_INVALID;
    d = stat(i).PER_COR;
    e = stat(i).PER_INCOR;
    f = stat(i).PER_TP;
    g = stat(i).PER_FP;
    h = stat(i).PER_FN;        

    
    %sta_n_b = double(a) / GROUP_SIZE;
    sta_valid_arr_b(i) = double(b);
    sta_invalid_arr_b(i) = double(c);
    sta_cor_arr_b(i) = double(d);
    sta_incor_arr_b(i) = double(e);
    sta_tp_arr_b(i) = double(f);
    sta_fp_arr_b(i) = double(g);
    sta_fn_arr_b(i) = double(h);
end

%% svr
sta_n_c = 0;
sta_valid_arr_c = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr_c = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr_c = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr_c = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr_c = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr_c = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr_c = zeros(GROUPED_SET_SIZE,1);

load('stat_svr');

for i = 1:(DATASET_SIZE)

    %a = a + stat(i * j + j).PER_N;
    b = stat(i).PER_VALID;
    c = stat(i).PER_INVALID;
    d = stat(i).PER_COR;
    e = stat(i).PER_INCOR;
    f = stat(i).PER_TP;
    g = stat(i).PER_FP;
    h = stat(i).PER_FN;        

    
    %sta_n_c = double(a) / GROUP_SIZE;
    sta_valid_arr_c(i) = double(b);
    sta_invalid_arr_c(i) = double(c);
    sta_cor_arr_c(i) = double(d);
    sta_incor_arr_c(i) = double(e);
    sta_tp_arr_c(i) = double(f);
    sta_fp_arr_c(i) = double(g);
    sta_fn_arr_c(i) = double(h);
end



%% evd
sta_n_d = 0;
sta_valid_arr_d = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr_d = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr_d = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr_d = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr_d = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr_d = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr_d = zeros(GROUPED_SET_SIZE,1);

load('stat_evd');

for i = 1:(DATASET_SIZE)

    %a = a + stat(i * j + j).PER_N;
    b = stat(i).PER_VALID;
    c = stat(i).PER_INVALID;
    d = stat(i).PER_COR;
    e = stat(i).PER_INCOR;
    f = stat(i).PER_TP;
    g = stat(i).PER_FP;
    h = stat(i).PER_FN;        

    
    %sta_n_d = double(a) / GROUP_SIZE;
    sta_valid_arr_d(i) = double(b);
    sta_invalid_arr_d(i) = double(c);
    sta_cor_arr_d(i) = double(d);
    sta_incor_arr_d(i) = double(e);
    sta_tp_arr_d(i) = double(f);
    sta_fp_arr_d(i) = double(g);
    sta_fn_arr_d(i) = double(h);
end


%% Plot result
ticks = ['0%';
            '1%';
            '2%';
            '3%';
            '4%';
            '5%';
            ];
        
subplot(7,1,1)
bar([sta_valid_arr, sta_valid_arr_a, sta_valid_arr_b, sta_valid_arr_c])
axis([-inf, +inf, -inf, +inf])
title('Valid')
legend('idl', 'lr','ts', 'svr')
set(gca,'XTickLabel',ticks)

subplot(7,1,2)
bar([sta_invalid_arr,sta_invalid_arr_a, sta_invalid_arr_b,sta_invalid_arr_c])
axis([-inf, +inf, -inf, 50])
title('Invalid')
set(gca,'XTickLabel',ticks)

subplot(7,1,3)
bar([sta_cor_arr, sta_cor_arr_a, sta_cor_arr_b,sta_cor_arr_c])
axis([-inf, +inf, -inf, 50])
title('Correct')
set(gca,'XTickLabel',ticks)

subplot(7,1,4)
bar([sta_incor_arr, sta_incor_arr_a, sta_incor_arr_b,sta_incor_arr_c])
axis([-inf, +inf, -inf, 30])
title('Incorrect')
set(gca,'XTickLabel',ticks)

subplot(7,1,5)
bar([sta_tp_arr, sta_tp_arr_a, sta_tp_arr_b,sta_tp_arr_c])
axis([-inf, +inf, -inf, 30])
title('True Positive')
set(gca,'XTickLabel',ticks)

subplot(7,1,6)
bar([sta_fp_arr, sta_fp_arr_a, sta_fp_arr_b,sta_fp_arr_c])
axis([-inf, +inf, -inf, 30])
title('False Positive')
set(gca,'XTickLabel',ticks)

subplot(7,1,7)
bar([sta_fn_arr, sta_fn_arr_a, sta_fn_arr_b,sta_fn_arr_c])
axis([-inf, +inf, -inf, 30])
title('False Negative')
set(gca,'XTickLabel',ticks)

%% Statistics
%stat_summary(PER_N, PER_VALID, PER_INVALID, PER_COR,PER_INCOR,PER_TP,PER_FP,PER_TN,PER_FN)
