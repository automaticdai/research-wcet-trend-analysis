function [p, EFP] = f_theil_sen(t_x_, t_y_, wcet_, order_)
%Summary of this function goes here
%   Detailed explanation goes here
    x = t_x_';
    y = t_y_';

    %% Algorithm
    [N c] = size(x);
    Comb = combnk(1:N,2);
    delta_y = diff(y(Comb),1,2);
    delta_x = diff(x(Comb),1,2);
    theil = delta_y ./ delta_x;
    est_k = median(theil);
    
    est_b = median(y - est_k .* x);
    
    p = [est_k est_b];
    
    if (est_k <= 0)
        %fprintf('t = %d, negative trend\n', i);
        EFP = Inf;
    else
        EFP = (wcet_ - est_b) / est_k;
    end
end

