
%% clear environment & open dataset
clear           % clear workspace
clc             % clear command lines
format longG

addpath('../_help/')
addpath('../_dataset_trend/')
addpath('./result_max/')

DATASET_SIZE = 50;
GROUP_SIZE = 10;
GROUPED_SET_SIZE = DATASET_SIZE / GROUP_SIZE;

%% linear regression
sta_n = 0;
sta_valid_arr = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr = zeros(GROUPED_SET_SIZE,1);


load('stat_ideal');

for i = 1:(DATASET_SIZE/GROUP_SIZE)
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    g = 0;
    h = 0;
    for j = 1:(GROUP_SIZE)
        %a = a + stat(i * j + j).PER_N;
        b = b + stat((i-1) * GROUP_SIZE + j).PER_VALID;
        c = c + stat((i-1) * GROUP_SIZE + j).PER_INVALID;
        d = d + stat((i-1) * GROUP_SIZE + j).PER_COR;
        e = e + stat((i-1) * GROUP_SIZE + j).PER_INCOR;
        f = f + stat((i-1) * GROUP_SIZE + j).PER_TP;
        g = g + stat((i-1) * GROUP_SIZE + j).PER_FP;
        h = h + stat((i-1) * GROUP_SIZE + j).PER_FN;        
    end
    
    %sta_n = double(a) / GROUP_SIZE;
    sta_valid_arr(i) = double(b) / GROUP_SIZE;
    sta_invalid_arr(i) = double(c) / GROUP_SIZE;
    sta_cor_arr(i) = double(d) / GROUP_SIZE;
    sta_incor_arr(i) = double(e) / GROUP_SIZE;
    sta_tp_arr(i) = double(f) / GROUP_SIZE;
    sta_fp_arr(i) = double(g) / GROUP_SIZE;
    sta_fn_arr(i) = double(h) / GROUP_SIZE;
end

%% linear regression
sta_n = 0;
sta_valid_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr_a = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr_a = zeros(GROUPED_SET_SIZE,1);


load('stat_linear_regression');

for i = 1:(DATASET_SIZE/GROUP_SIZE)
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    g = 0;
    h = 0;
    for j = 1:(GROUP_SIZE)
        %a = a + stat(i * j + j).PER_N;
        b = b + stat((i-1) * GROUP_SIZE + j).PER_VALID;
        c = c + stat((i-1) * GROUP_SIZE + j).PER_INVALID;
        d = d + stat((i-1) * GROUP_SIZE + j).PER_COR;
        e = e + stat((i-1) * GROUP_SIZE + j).PER_INCOR;
        f = f + stat((i-1) * GROUP_SIZE + j).PER_TP;
        g = g + stat((i-1) * GROUP_SIZE + j).PER_FP;
        h = h + stat((i-1) * GROUP_SIZE + j).PER_FN;        
    end
    
    %sta_n = double(a) / GROUP_SIZE;
    sta_valid_arr_a(i) = double(b) / GROUP_SIZE;
    sta_invalid_arr_a(i) = double(c) / GROUP_SIZE;
    sta_cor_arr_a(i) = double(d) / GROUP_SIZE;
    sta_incor_arr_a(i) = double(e) / GROUP_SIZE;
    sta_tp_arr_a(i) = double(f) / GROUP_SIZE;
    sta_fp_arr_a(i) = double(g) / GROUP_SIZE;
    sta_fn_arr_a(i) = double(h) / GROUP_SIZE;
end

%% theil-sen
%%
sta_n_b = 0;
sta_valid_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_invalid_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_cor_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_incor_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_tp_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_fp_arr_b = zeros(GROUPED_SET_SIZE,1);
sta_fn_arr_b = zeros(GROUPED_SET_SIZE,1);

load('stat_theil_sen');

for i = 1:(DATASET_SIZE/GROUP_SIZE)
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    g = 0;
    h = 0;
    for j = 1:(GROUP_SIZE)
        %a = a + stat(i * j + j).PER_N;
        b = b + stat((i-1) * GROUP_SIZE + j).PER_VALID;
        c = c + stat((i-1) * GROUP_SIZE + j).PER_INVALID;
        d = d + stat((i-1) * GROUP_SIZE + j).PER_COR;
        e = e + stat((i-1) * GROUP_SIZE + j).PER_INCOR;
        f = f + stat((i-1) * GROUP_SIZE + j).PER_TP;
        g = g + stat((i-1) * GROUP_SIZE + j).PER_FP;
        h = h + stat((i-1) * GROUP_SIZE + j).PER_FN;        
    end
    
    %sta_n = double(a) / GROUP_SIZE;
    sta_valid_arr_b(i) = double(b) / GROUP_SIZE;
    sta_invalid_arr_b(i) = double(c) / GROUP_SIZE;
    sta_cor_arr_b(i) = double(d) / GROUP_SIZE;
    sta_incor_arr_b(i) = double(e) / GROUP_SIZE;
    sta_tp_arr_b(i) = double(f) / GROUP_SIZE;
    sta_fp_arr_b(i) = double(g) / GROUP_SIZE;
    sta_fn_arr_b(i) = double(h) / GROUP_SIZE;
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

for i = 1:(DATASET_SIZE/GROUP_SIZE)
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    g = 0;
    h = 0;
    for j = 1:(GROUP_SIZE)
        %a = a + stat(i * j + j).PER_N;
        b = b + stat((i-1) * GROUP_SIZE + j).PER_VALID;
        c = c + stat((i-1) * GROUP_SIZE + j).PER_INVALID;
        d = d + stat((i-1) * GROUP_SIZE + j).PER_COR;
        e = e + stat((i-1) * GROUP_SIZE + j).PER_INCOR;
        f = f + stat((i-1) * GROUP_SIZE + j).PER_TP;
        g = g + stat((i-1) * GROUP_SIZE + j).PER_FP;
        h = h + stat((i-1) * GROUP_SIZE + j).PER_FN;        
    end
    
    %sta_n = double(a) / GROUP_SIZE;
    sta_valid_arr_c(i) = double(b) / GROUP_SIZE;
    sta_invalid_arr_c(i) = double(c) / GROUP_SIZE;
    sta_cor_arr_c(i) = double(d) / GROUP_SIZE;
    sta_incor_arr_c(i) = double(e) / GROUP_SIZE;
    sta_tp_arr_c(i) = double(f) / GROUP_SIZE;
    sta_fp_arr_c(i) = double(g) / GROUP_SIZE;
    sta_fn_arr_c(i) = double(h) / GROUP_SIZE;
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

for i = 1:(DATASET_SIZE/GROUP_SIZE)
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    g = 0;
    h = 0;
    for j = 1:(GROUP_SIZE)
        %a = a + stat(i * j + j).PER_N;
        b = b + stat((i-1) * GROUP_SIZE + j).PER_VALID;
        c = c + stat((i-1) * GROUP_SIZE + j).PER_INVALID;
        d = d + stat((i-1) * GROUP_SIZE + j).PER_COR;
        e = e + stat((i-1) * GROUP_SIZE + j).PER_INCOR;
        f = f + stat((i-1) * GROUP_SIZE + j).PER_TP;
        g = g + stat((i-1) * GROUP_SIZE + j).PER_FP;
        h = h + stat((i-1) * GROUP_SIZE + j).PER_FN;        
    end
    
    %sta_n = double(a) / GROUP_SIZE;
    sta_valid_arr_d(i) = double(b) / GROUP_SIZE;
    sta_invalid_arr_d(i) = double(c) / GROUP_SIZE;
    sta_cor_arr_d(i) = double(d) / GROUP_SIZE;
    sta_incor_arr_d(i) = double(e) / GROUP_SIZE;
    sta_tp_arr_d(i) = double(f) / GROUP_SIZE;
    sta_fp_arr_d(i) = double(g) / GROUP_SIZE;
    sta_fn_arr_d(i) = double(h) / GROUP_SIZE;
end

%% Plot result
% !!!d not included in invalid and incor!!!
% 0 /0 ?

% normalize data
% sta_valid_arr_a = sta_valid_arr_a ./ sta_valid_arr;
% sta_valid_arr_b = sta_valid_arr_b ./ sta_valid_arr;
% sta_valid_arr_c = sta_valid_arr_c ./ sta_valid_arr;
% sta_valid_arr_d = sta_valid_arr_d ./ sta_valid_arr;
% sta_valid_arr = sta_valid_arr ./ sta_valid_arr;
% 
% sta_max = max([sta_invalid_arr, sta_invalid_arr_a, sta_invalid_arr_b, sta_invalid_arr_c],[],2);
% sta_invalid_arr_a = sta_invalid_arr_a ./ sta_max;
% sta_invalid_arr_b = sta_invalid_arr_b ./ sta_max;
% sta_invalid_arr_c = sta_invalid_arr_c ./ sta_max;
% sta_invalid_arr_d = sta_invalid_arr_d ./ sta_max;
% 
% sta_cor_arr_a = sta_cor_arr_a ./ sta_cor_arr;
% sta_cor_arr_b = sta_cor_arr_b ./ sta_cor_arr;
% sta_cor_arr_c = sta_cor_arr_c ./ sta_cor_arr;
% sta_cor_arr_d = sta_cor_arr_d ./ sta_cor_arr;
% sta_cor_arr = sta_cor_arr ./ sta_cor_arr;
% 
% sta_max = max([sta_incor_arr, sta_incor_arr_a, sta_incor_arr_b, sta_incor_arr_c],[],2);
% sta_incor_arr_a = sta_incor_arr_a ./ sta_max;
% sta_incor_arr_b = sta_incor_arr_b ./ sta_max;
% sta_incor_arr_c = sta_incor_arr_c ./ sta_max;
% sta_incor_arr_d = sta_incor_arr_d ./ sta_max;
% 
% sta_tp_arr_a = sta_tp_arr_a ./ sta_tp_arr;
% sta_tp_arr_b = sta_tp_arr_b ./ sta_tp_arr;
% sta_tp_arr_c = sta_tp_arr_c ./ sta_tp_arr;
% sta_tp_arr_d = sta_tp_arr_d ./ sta_tp_arr;
% sta_tp_arr = sta_tp_arr ./ sta_tp_arr;
% 
% sta_max = max([sta_fp_arr, sta_fp_arr_a, sta_fp_arr_b, sta_fp_arr_c],[],2);
% sta_fp_arr_a = sta_fp_arr_a ./ sta_max;
% sta_fp_arr_b = sta_fp_arr_b ./ sta_max;
% sta_fp_arr_c = sta_fp_arr_c ./ sta_max;
% sta_fp_arr_d = sta_fp_arr_d ./ sta_max;
% 
% sta_max = max([sta_fn_arr, sta_fn_arr_a, sta_fn_arr_b, sta_fn_arr_c],[],2);
% sta_fn_arr_a = sta_fn_arr_a ./ sta_max;
% sta_fn_arr_b = sta_fn_arr_b ./ sta_max;
% sta_fn_arr_c = sta_fn_arr_c ./ sta_max;
% sta_fn_arr_d = sta_fn_arr_d ./ sta_max;

% plot data
% subplot(7,1,1)
% bar([sta_valid_arr,sta_valid_arr_a, sta_valid_arr_b, sta_valid_arr_c])
% title('Valid')
% legend('ideal', 'lr','ts', 'svr')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
% ax.XTickLabelRotation = 45;
% 
% subplot(7,1,2)
% bar([sta_invalid_arr,sta_invalid_arr_a, sta_invalid_arr_b,sta_invalid_arr_c])
% title('Invalid')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
% ax.XTickLabelRotation = 45;
% 
% subplot(7,1,3)
% bar([sta_cor_arr, sta_cor_arr_a, sta_cor_arr_b,sta_cor_arr_c])
% title('Correct')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
% ax.XTickLabelRotation = 45;
% 
% subplot(7,1,4)
% bar([sta_incor_arr, sta_incor_arr_a, sta_incor_arr_b,sta_incor_arr_c])
% title('Incorrect')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
% ax.XTickLabelRotation = 45;
% 
% subplot(7,1,5)
% bar([sta_tp_arr, sta_tp_arr_a, sta_tp_arr_b,sta_tp_arr_c])
% title('True Positive')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
% ax.XTickLabelRotation = 45;
% 
% subplot(7,1,6)
% bar([sta_fp_arr, sta_fp_arr_a, sta_fp_arr_b,sta_fp_arr_c])
% title('False Positive')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
% ax.XTickLabelRotation = 45;
% 
% subplot(7,1,7)
% bar([sta_fn_arr, sta_fn_arr_a, sta_fn_arr_b,sta_fn_arr_c])
% title('False Negative')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
% ax.XTickLabelRotation = 45;

%%%%
sta_valid_arr_a = sta_valid_arr_a ./ sta_valid_arr;
sta_valid_arr_b = sta_valid_arr_b ./ sta_valid_arr;
sta_valid_arr_c = sta_valid_arr_c ./ sta_valid_arr;
sta_valid_arr_d = sta_valid_arr_d ./ sta_valid_arr;
sta_valid_arr = sta_valid_arr ./ sta_valid_arr;

sta_max = max([sta_invalid_arr, sta_invalid_arr_a, sta_invalid_arr_b, sta_invalid_arr_c, sta_invalid_arr_d],[],2);
sta_invalid_arr_a = sta_invalid_arr_a ./ sta_max;
sta_invalid_arr_b = sta_invalid_arr_b ./ sta_max;
sta_invalid_arr_c = sta_invalid_arr_c ./ sta_max;
sta_invalid_arr_d = sta_invalid_arr_d ./ sta_max;

sta_cor_arr_a = sta_cor_arr_a ./ sta_cor_arr;
sta_cor_arr_b = sta_cor_arr_b ./ sta_cor_arr;
sta_cor_arr_c = sta_cor_arr_c ./ sta_cor_arr;
sta_cor_arr_d = sta_cor_arr_d ./ sta_cor_arr;
sta_cor_arr = sta_cor_arr ./ sta_cor_arr;

sta_max = max([sta_incor_arr, sta_incor_arr_a, sta_incor_arr_b, sta_incor_arr_c, sta_incor_arr_d],[],2);
sta_incor_arr_a = sta_incor_arr_a ./ sta_max;
sta_incor_arr_b = sta_incor_arr_b ./ sta_max;
sta_incor_arr_c = sta_incor_arr_c ./ sta_max;
sta_incor_arr_d = sta_incor_arr_d ./ sta_max;

sta_tp_arr_a = sta_tp_arr_a ./ sta_tp_arr;
sta_tp_arr_b = sta_tp_arr_b ./ sta_tp_arr;
sta_tp_arr_c = sta_tp_arr_c ./ sta_tp_arr;
sta_tp_arr_d = sta_tp_arr_d ./ sta_tp_arr;
sta_tp_arr = sta_tp_arr ./ sta_tp_arr;

sta_max = max([sta_fp_arr, sta_fp_arr_a, sta_fp_arr_b, sta_fp_arr_c, sta_fp_arr_d],[],2);
sta_fp_arr_a = sta_fp_arr_a ./ sta_max;
sta_fp_arr_b = sta_fp_arr_b ./ sta_max;
sta_fp_arr_c = sta_fp_arr_c ./ sta_max;
sta_fp_arr_d = sta_fp_arr_d ./ sta_max;

sta_max = max([sta_fn_arr, sta_fn_arr_a, sta_fn_arr_b, sta_fn_arr_c, sta_fn_arr_d],[],2);
sta_fn_arr_a = sta_fn_arr_a ./ sta_max;
sta_fn_arr_b = sta_fn_arr_b ./ sta_max;
sta_fn_arr_c = sta_fn_arr_c ./ sta_max;
sta_fn_arr_d = sta_fn_arr_d ./ sta_max;

% plot data
subplot(5,1,1)
bar([sta_valid_arr,sta_valid_arr_a, sta_valid_arr_b, sta_valid_arr_c, sta_valid_arr_d])
title('Valid Estimations')
legend('IDP-MAX', 'LR-MAX','TSE-MAX', 'SVR-MAX', 'EVD-MAX', 'Orientation', 'horizontal')

ax = gca;
ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
set(gca,'xtick',[]);

subplot(5,1,2)
bar([sta_invalid_arr,sta_invalid_arr_a, sta_invalid_arr_b,sta_invalid_arr_c, sta_invalid_arr_d])
title('Invalid Estimations')
ax = gca;
ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
set(gca,'xtick',[]);

% subplot(5,1,3)
% bar([sta_cor_arr, sta_cor_arr_a, sta_cor_arr_b,sta_cor_arr_c, sta_cor_arr_d])
% title('Correct Behaviour')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};


% subplot(5,1,4)
% bar([sta_incor_arr, sta_incor_arr_a, sta_incor_arr_b,sta_incor_arr_c, sta_incor_arr_d])
% title('Incorrect Behaviour')
% ax = gca;
% ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};


subplot(5,1,3)
bar([sta_tp_arr, sta_tp_arr_a, sta_tp_arr_b,sta_tp_arr_c, sta_tp_arr_d])
title('True Positives')
ax = gca;
ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
set(gca,'xtick',[]);

subplot(5,1,4)
bar([sta_fp_arr, sta_fp_arr_a, sta_fp_arr_b,sta_fp_arr_c, sta_fp_arr_d])
title('False Positives')
ax = gca;
ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};
set(gca,'xtick',[]);

subplot(5,1,5)
bar([sta_fn_arr, sta_fn_arr_a, sta_fn_arr_b,sta_fn_arr_c, sta_fn_arr_d])
title('False Negatives')
ax = gca;
ax.XTickLabel = {'k = 0','k = 1%','k = 2%','k = 3%','k = 4%','k = 5%'};


%% Statistics
%stat_summary(PER_N, PER_VALID, PER_INVALID, PER_COR,PER_INCOR,PER_TP,PER_FP,PER_TN,PER_FN)
