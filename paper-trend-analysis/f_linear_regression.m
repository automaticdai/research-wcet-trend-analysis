%--------------------------------------------------------------------------
% Xiaotian Dai
% Real-Time System Research Group
% University of York
%--------------------------------------------------------------------------

function [p, EFP] = f_linear_regression(t_x_, t_y_, wcet_, order_)
    [p, error] = polyfit(t_x_, t_y_, order_);
    
    % calculate EFP & calculate performance
    est_k = p(1);
    est_b = p(2);
    
    if (est_k <= 0)
        % negative trend
        EFP = Inf;
    else
%         pstr = poly2str(p, '*t');
%         str_wcet = int2str(wcet_);
%         pstr = strcat(pstr, '=');
%         pstr = strcat(pstr, str_wcet);
% 
%         EFP = solve(pstr, 't');
        
        EFP = (wcet_ - est_b) / est_k;
    end
end
