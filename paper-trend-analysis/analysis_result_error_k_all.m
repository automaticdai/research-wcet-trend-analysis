% plot all k_errors in a single graph
% generate k_mean_raw/max/r before running this script
% 1. lr-raw  2. lr-max  3. lr-r
% 4. ts-raw  5. ts-max  6. ts-r
% 7. svr-raw 8. svr-max 9. svr-r
% 10.evr-raw 11.evd-max 12.evd-r

k_mean = zeros(50, 12);
load('k_mean_raw')
k_mean(:,1) = arr_k_mean(:,2);
k_mean(:,4) = arr_k_mean(:,3);
k_mean(:,7) = arr_k_mean(:,4);
k_mean(:,10) = arr_k_mean(:,5);

load('k_mean_max')
k_mean(:,2) = arr_k_mean(:,2);
k_mean(:,5) = arr_k_mean(:,3);
k_mean(:,8) = arr_k_mean(:,4);
k_mean(:,11) = arr_k_mean(:,5);

load('k_mean_r')
k_mean(:,3) = arr_k_mean(:,2);
k_mean(:,6) = arr_k_mean(:,3);
k_mean(:,9) = arr_k_mean(:,4);
k_mean(:,12) = arr_k_mean(:,5);


methods_cell = [{'olr-raw'}; {'olr-max'}; {'olr-r'}; {'tse-raw'}; {'tse-max'}; ...
    {'tse-r'}; {'svr-raw'}; {'svr-max'}; {'svr-r'}; {'evd-raw'}; {'evd-max'}; {'evd-r'}];
boxplot(k_mean, 'labels',methods_cell)
set(gca,'FontSize',10,'XTickLabelRotation',45)


set(gcf, 'Color', 'white'); % white bckgr
print(gcf, '-djpeg', '-r300', 'a')
