% hadamard_n16384_benchmark.m
% Benchmark CPU vs GPU for N Hadamard matrix generation
% Compares Sylvester vs Kronecker methods with speedup calculation

clc;
clear all;
close all;

%% Parameters
n = 13;
N = 2^n;           % Fixed matrix size (2^14)
num_trials = 5;      % Number of timing trials

%% Warm-up runs (initialize GPU)
sylvester_hadamard_gpu(N);    % Initialize GPU context
kronecker_hadamard_gpu(N);    % before timing

%% CPU Timing
fprintf('=== CPU Timing ===\n');
time_sylvester_cpu = time_method(@() sylvester_hadamard(N), num_trials);
time_kronecker_cpu = time_method(@() kronecker_hadamard(N), num_trials);

%% GPU Timing
fprintf('\n=== GPU Timing ===\n');
time_sylvester_gpu = time_method(@() sylvester_hadamard_gpu(N), num_trials);
time_kronecker_gpu = time_method(@() kronecker_hadamard_gpu(N), num_trials);

%% Calculate Speedup Factors
speedup_sylvester = time_sylvester_cpu / time_sylvester_gpu;
speedup_kronecker = time_kronecker_cpu / time_kronecker_gpu;

%% Display Results
fprintf('\n=== Results for N=%d ===\n', N);
fprintf('Method          | CPU Time (s) | GPU Time (s) | Speedup\n');
fprintf('-------------------------------------------------------\n');
fprintf('Sylvester       | %11.4f | %11.4f | %7.2fx\n',...
        time_sylvester_cpu, time_sylvester_gpu, speedup_sylvester);
fprintf('Kronecker       | %11.4f | %11.4f | %7.2fx\n',...
        time_kronecker_cpu, time_kronecker_gpu, speedup_kronecker);

