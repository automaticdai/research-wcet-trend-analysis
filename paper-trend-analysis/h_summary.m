function [] = f_summary(PER_N, PER_VALID, PER_INVALID, ...
                            PER_COR,PER_INCOR,PER_TP,PER_FP,PER_TN,PER_FN)
% Summary of this function goes here
%   Detailed explanation goes here
    % print statistics
    fprintf('\n\n\nSummary:\n')
    % v / iv
    fprintf('valid: %d/%d, %0.2f\n', PER_VALID, PER_N, double(PER_VALID/PER_N))
    fprintf('invalid: %d/%d, %0.2f\n\n', PER_INVALID, PER_N, double(PER_INVALID/PER_N))

    % correct / incorrect
    fprintf('correct: %d/%d, %0.2f\n', PER_COR, PER_N, double(PER_COR/PER_N))
    fprintf('not correct: %d/%d, %0.2f\n\n', PER_INCOR, PER_N, double(PER_INCOR/PER_N))

    % positive / negative & true or false
    fprintf('true positive: %d/%d, %0.2f\n', PER_TP, PER_N, double(PER_TP/PER_N))
    fprintf('false positive: %d/%d, %0.2f\n', PER_FP, PER_N, double(PER_FP/PER_N))
    fprintf('true negative: %d/%d, %0.2f\n', PER_TN, PER_N, double(PER_TN/PER_N))
    fprintf('false negative: %d/%d, %0.2f\n', PER_FN, PER_N, double(PER_FN/PER_N))

    fprintf('\n\n\n')
end

