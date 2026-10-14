
clear;
clc;
close all;

%% 1. Signal parameters
fs = 1000;
N = 1000;
n = 0:N-1;
t = n/fs;

%% 2. Original signal
f1 = 50;
f2 = 120;

x = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t);

%% 3. Direct DFT
X = zeros(1,N);

for k = 0:N-1
    X(k+1) = sum(x .* exp(-1j*2*pi*k*n/N));
end

%% 4. Direct Inverse DFT
x_reconstructed = zeros(1,N);

for n_idx = 0:N-1
    k = 0:N-1;

    x_reconstructed(n_idx+1) = ...
        (1/N)*sum(X .* exp(1j*2*pi*k*n_idx/N));
end

% Remove tiny imaginary numerical errors
x_reconstructed = real(x_reconstructed);

%% 5. Reconstruction error
error = x - x_reconstructed;

MSE = mean(error.^2);
max_error = max(abs(error));

fprintf('Mean Squared Error: %.3e\n', MSE);
fprintf('Maximum Error: %.3e\n', max_error);

%% 6. Visualization
figure;

subplot(3,1,1);
plot(t,x,'b');
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t,x_reconstructed,'r');
title('Reconstructed Signal using IDFT');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t,error);
title('Reconstruction Error');
xlabel('Time (s)');
ylabel('Error');
grid on;

%% 7. Save results
exportgraphics(gcf,'idft_result.png');
