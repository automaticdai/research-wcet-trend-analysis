function [HFP] = h_find_hfp(trend_, c_init_, wcet_)
% Summary of this function goes here
%   Detailed explanation goes here
    if (trend_ > 0)
        pstr = poly2str([trend_, c_init_], '*t');
        str_wcet = int2str(wcet_);
        pstr = strcat(pstr, '=');
        pstr = strcat(pstr, str_wcet);

        HFP = int32(solve(pstr, 't'));
    else
        HFP = inf;
    end

end

