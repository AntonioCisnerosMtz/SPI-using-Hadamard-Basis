% hadamard_cpu_benchmark.m
% Benchmark CPU implementations of Sylvester vs Kronecker Hadamard methods
% Includes speedup factor calculation

clc;
clear all;
close all;

addpath('functions\');

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
    time_sylvester(i) = time_method(@() sylvester_hadamard(n), num_trials);
    
    % Time Kronecker method
    time_kronecker(i) = time_method(@() kronecker_hadamard(n), num_trials);
    
    % Calculate speedup factor (Sylvester vs Kronecker)
    speedup(i) = time_sylvester(i)/time_kronecker(i);
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
% yline(1, 'k--', 'Reference Line', 'LineWidth', 1.5);
title('Speedup Factor (Sylvester/Kronecker)');
xlabel('Matrix Size');
ylabel('Speedup Factor');
grid on;
set(gca, 'FontSize', 12);

print(['figures/', 'BenchmarkCPU' ], '-dpng', '-r300');