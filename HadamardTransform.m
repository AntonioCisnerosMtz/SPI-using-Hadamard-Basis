clear
close all
clc

n = 7; % max n = 7
N = 2^n;
I = double( imread('cameraman.tif'));
Inew = imresize(I,[N,N]); % image

%% Method 1
tic
H1 = kronecker_hadamard(N);
HT1 = H1*Inew*H1; %Hadamard Transform
IHT1 = (1/N^2)*(H1*HT1*H1); %Inverse Hadamard Transform
toc
%% Method 2
tic
H2 = kronecker_hadamard(N^2);
HT2 =reshape( H2 * Inew(:), [N,N] ); %Hadamard Transform
IHT2 = (1/N^2) * reshape( H2 * HT2(:), [N,N] ); %Inverse Hadamard Transform
toc
%% Method 3

tic
IHT3 = zeros(N,N);
for i = 1 : N^2;
    HT3(i) = H2(i,:) * Inew(:);   %Hadamard Transform 
    IHT3 = HT3(i) * reshape(H2(i,:)', [N,N]) + IHT3; 
end
% reshape(HT3, [N,N])
IHT3 = (1/N^2)*IHT3; %Inverse Hadamard Transform
toc
