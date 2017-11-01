function [p, EFP, pd] = f_evd(t_x_, t_y_, wcet_, order_, step_size, x_cur, pd_previous)
%Summary of this function goes here
%   Detailed explanation goes here
    
    x = t_x_';
    y = t_y_';

    %% Algorithm
    % fit generalized extreme value distribtuion
    pd = fitdist(y, 'ExtremeValue'); % ExtremeValue GeneralizedExtremeValue
    
    if (pd_previous.mu == 1234)
        EFP = Inf;
        p = [0 0];
    else
        est_k = (pd.mu - pd_previous.mu) / step_size;
        est_b = pd.mu - est_k * (x_cur - step_size/2);
        
        p = [est_k est_b];
    
        if (est_k <= 0)
            %fprintf('t = %d, negative trend\n', i);
            EFP = Inf;
        else
            EFP = (wcet_ - est_b) / est_k;
        end
    end
       
end