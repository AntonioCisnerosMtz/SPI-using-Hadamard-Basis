%% Timing function
function t = time_method(fcn_handle, num_trials)
% Measures median execution time across multiple trials
    times = zeros(num_trials, 1);
    for k = 1:num_trials
        tic;
        fcn_handle(); % Execute target function
        times(k) = toc;
    end
    t = median(times); % Use median for stable measurement
end