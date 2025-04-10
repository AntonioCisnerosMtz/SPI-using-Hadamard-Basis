% hadamard_cpu_benchmark.m
% Benchmark CPU implementations of Sylvester vs Kronecker Hadamard methods
% Includes speedup factor calculation

clc;
clear all;
close all;

%% Parameters
max_power = 14;              % Max matrix size: 2^12 = 4096
sizes = 2.^(2:max_power);     % Tested matrix sizes (powers of 2)
num_sizes = length(sizes);
num_trials = 5;               % Number of timing trials per method

%% Preallocate arrays
time_sylvester = zeros(num_sizes, 1);
time_kronecker = zeros(num_sizes, 1);
speedup = zeros(num_sizes, 1);  % Kronecker vs Sylvester speedup

%% Benchmark loop
for i = 1:num_sizes
    n = sizes(i);
    fprintf('Testing n = %d (2^%d)\n', n, log2(n));
    
    % Time Sylvester method
    time_sylvester(i) = time_method(@() sylvester_cpu(n), num_trials);
    
    % Time Kronecker method
    time_kronecker(i) = time_method(@() kronecker_cpu(n), num_trials);
    
    % Calculate speedup factor (Sylvester vs Kronecker)
    speedup(i) = time_kronecker(i)/time_sylvester(i);
end

%% Plot results
figure('Position', [100 100 1200 500]);

% Execution time comparison
subplot(1, 2, 1);
loglog(sizes, time_sylvester, 'ro-', 'LineWidth', 2, 'DisplayName', 'Sylvester');
hold on;
loglog(sizes, time_kronecker, 'bo-', 'LineWidth', 2, 'DisplayName', 'Kronecker');
title('CPU Execution Time Comparison');
xlabel('Matrix Size');
ylabel('Time (seconds)');
legend('Location', 'northwest');
grid on;
set(gca, 'FontSize', 12);

% Speedup factor
subplot(1, 2, 2);
semilogx(sizes, speedup, 'mo-', 'LineWidth', 2);
yline(1, 'k--', 'Reference Line', 'LineWidth', 1.5);
title('Method Speedup Factor (Kronecker/Sylvester)');
xlabel('Matrix Size');
ylabel('Speedup Factor');
grid on;
set(gca, 'FontSize', 12);

%% Timing function
function t = time_method(fcn_handle, num_trials)
% Measures median execution time across multiple trials
    times = zeros(num_trials, 1);
    for k = 1:num_trials
        tic;
        fcn_handle();  % Execute target function
        times(k) = toc;
    end
    t = median(times);  % Use median for stable measurement
end

%% CPU Implementations
function H = sylvester_cpu(n)
% Recursive Sylvester implementation
    if n == 1
        H = 1;
        return;
    end
    m = n/2;
    H_prev = sylvester_cpu(m);
    H = [H_prev,  H_prev;
         H_prev, -H_prev];
end

function H = kronecker_cpu(n)
% Iterative Kronecker product implementation
    H_base = [1 1; 1 -1];
    k = log2(n);
    H = 1;
    for i = 1:k
        H = kron(H, H_base);
    end
end