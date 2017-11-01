%--------------------------------------------------------------------------
% Xiaotian Dai
% Real-Time System Research Group
% University of York
%--------------------------------------------------------------------------

function [p, EFP] = f_ideal(wcet_, actual_trend, S)

    p(1) = actual_trend;
    p(2) = 150;
    
    % calculate EFP & calculate performance
    est_k = p(1);
    est_b = p(2);
    
    if (est_k <= 0)
        %fprintf('t = %d, negative trend\n', i);
        EFP = Inf;
    else
        EFP = (wcet_ - est_b) / est_k;
    end
end
