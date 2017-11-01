function [p, EFP] = f_svr(t_x_, t_y_, wcet_, order_)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    % build regression model
    model = svmtrain(t_y_', t_x_','-s 3 -t 0 -c 1 -p 0.1'); 
    
    % predict data based on the trained model
    % py = svmpredict(t_y_', t_x_', model);
    %[p, error] = polyfit(t_x_', py, order_);
    
    % calculate EFP & calculate performance
    est_k = model.SVs' * model.sv_coef;
    est_b = -model.rho;
    
    p = [est_k est_b];
    
    if (est_k <= 0)
        %fprintf('t = %d, negative trend\n', i);
        EFP = Inf;
    else
        EFP = (wcet_ - est_b) / est_k;
    end
end