function [y] = CalcRMSE(x1, x2) 
if ~isvector(x1) || ~isvector(x2)
    error('Input must be a vector')
end

% skip nan data
nan_index = isnan(x2);
x1 = x1(~nan_index);
x2 = x2(~nan_index);

% calculate RMSE
y = sqrt(sum(((x1 - x2) .^ 2)) / max(size(x1)));

end