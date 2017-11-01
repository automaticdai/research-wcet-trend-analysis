function [penalty_] = h_calc_penalty(t_, H_, D_, R_, alpha_)
% 
%   Detailed explanation goes here
    PENALTY_MAX = 10;
    penalty_ = 0;
    k1 = PENALTY_MAX / ((alpha_ - 1) * R_);
    k2 = PENALTY_MAX / (R_ - D_);
    RR_ = R_ * alpha_;
    
    if (t_ < H_ - RR_)
        penalty_ = PENALTY_MAX;
    elseif (t_ < H_ - R_)
        penalty_ = PENALTY_MAX - k1 * (t_ - (H_ - RR_));
    elseif (t_ < H_ - D_)
        penalty_ = k2 * (t_ - (H_ - R_));
    % H - D < t < H
    else
        penalty_ = PENALTY_MAX;
    end
    
end

