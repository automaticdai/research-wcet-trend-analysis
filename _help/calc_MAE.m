% calculate mean absoulte error

function [y] = CalcMAE(x1, x2) 
if ~isvector(x1) || ~isvector(x2)
    error('Input must be a vector')
end

y = mean(abs(x1 - x2));

end