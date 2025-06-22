
clear
close all
clc

path = [pwd, '\Matrix\']

n = 2;
N = 2^n;

load([path,  'Hzz_', num2str(N^2), 'x', num2str(N^2) '.mat']);

who
