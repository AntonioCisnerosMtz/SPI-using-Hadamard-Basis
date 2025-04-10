% Benchmark CPU vs GPU implementations of Sylvester and Kronecker methods
% Includes speedup calculation (GPU vs CPU)

clc;
clear all;
close all;

%% Parameters
max_power = 14;              % Max matrix size: 2^16 = 65536
sizes = 2.^(2:1:max_power);   % Tested sizes (powers of 2, even exponents)
num_sizes = length(sizes);
num_trials = 5;               % Number of timing trials
speedup_threshold = 1;        % Minimum speedup to display in plot

%% Preallocate arrays
% Execution times
time_sylvester_cpu = zeros(num_sizes, 1);
time_sylvester_gpu = zeros(num_sizes, 1);
time_kronecker_cpu = zeros(num_sizes, 1);
time_kronecker_gpu = zeros(num_sizes, 1);

% Speedup factors
speedup_sylvester = zeros(num_sizes, 1);
speedup_kronecker = zeros(num_sizes, 1);

%% Benchmark loop
for i = 1:num_sizes
    n = sizes(i);
    fprintf('Testing n = %d (2^%d)\n', n, log2(n));
    
    % Sylvester method timing
    time_sylvester_cpu(i) = time_method(@() sylvester_hadamard(n), num_trials);
    time_sylvester_gpu(i) = time_method(@() sylvester_hadamard_gpu(n), num_trials);
    speedup_sylvester(i) = time_sylvester_cpu(i) / time_sylvester_gpu(i);
    
    % Kronecker method timing
    time_kronecker_cpu(i) = time_method(@() kronecker_hadamard(n), num_trials);
    time_kronecker_gpu(i) = time_method(@() kronecker_hadamard_gpu(n), num_trials);
    speedup_kronecker(i) = time_kronecker_cpu(i) / time_kronecker_gpu(i);
end

%% Plot results
figure('Position', [100 100 1400 600]);

% Execution time comparison
subplot(1, 2, 1);
loglog(sizes, time_sylvester_cpu, 'ro--', 'LineWidth', 2, 'DisplayName', 'Sylvester-CPU');
hold on;
loglog(sizes, time_sylvester_gpu, 'bo--', 'LineWidth', 2, 'DisplayName', 'Sylvester-GPU');
loglog(sizes, time_kronecker_cpu, 'rs--', 'LineWidth', 2, 'DisplayName', 'Kronecker-CPU');
loglog(sizes, time_kronecker_gpu, 'bs--', 'LineWidth', 2, 'DisplayName', 'Kronecker-GPU');
title('Execution Time Comparison');
xlabel('Matrix Size');
ylabel('Time (seconds)');
legend('Location', 'northwest');
grid on;
set(gca, 'FontSize', 12);

% Speedup comparison
subplot(1, 2, 2);
semilogx(sizes, speedup_sylvester, 'mo-', 'LineWidth', 2, 'DisplayName', 'Sylvester');
hold on;
semilogx(sizes, speedup_kronecker, 'co-', 'LineWidth', 2, 'DisplayName', 'Kronecker');
yline(speedup_threshold, 'k--', 'Speedup = 1', 'LineWidth', 1.5);
title('GPU Speedup Factor');
xlabel('Matrix Size');
ylabel('Speedup (CPU Time / GPU Time)');
legend('Location', 'northwest');
grid on;
set(gca, 'FontSize', 12);


