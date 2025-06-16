function [pfx, i] = getTimePrefix(t)
% GETTIMEPREFIX Returns the time unit string and scaling exponent for a given time.
%   [pfx, i] = getTimePrefix(t) scales the time value t (in seconds) by factors of 1000
%   until the integer part (fix) becomes positive. The scaling exponent (i) counts the number of multiplications.
%   The unit string (pfx) is assigned based on i and is formatted for TeX interpreter:
%       i = 0 -> 's'       (seconds)
%       i = 1 -> 'ms'      (milliseconds)
%       i = 2 -> '\\mu s'  (microseconds, TeX format)
%       i = 3 -> 'ns'      (nanoseconds)
%       i = 4 -> 'ps'      (picoseconds)
%       i = 5 -> 'fs'      (femtoseconds)
%       i >= 6 -> '?s'     (unknown scaled unit)

    % Initialize exponent counter
    i = 0;
    t_temp = t;
    max_iter = 20;
    
    % Scale until integer part is positive
    while fix(t_temp) <= 0 && t_temp ~= 0 && i < max_iter
        t_temp = t_temp * 1000;
        i = i + 1;
    end
    
    % Assign TeX-compatible unit strings
    switch i
        case 0
            pfx = 's';
        case 1
            pfx = 'ms';
        case 2
            pfx = '\mus';  % TeX format for mu symbol
        case 3
            pfx = 'ns';
        case 4
            pfx = 'ps';
        case 5
            pfx = 'fs';
        otherwise
            pfx = '?s';  % Fallback for higher scales
    end
end