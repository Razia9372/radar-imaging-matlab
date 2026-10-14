
clear;
clc;
close all;

%% 1. Signal parameters
fs = 1000;
N = 1000;
n = 0:N-1;
t = n/fs;

%% 2. Generate signal
f1 = 50;
f2 = 120;

x = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t);

%% 3. Direct DFT implementation
X = zeros(1,N);

for k = 0:N-1
    X(k+1) = sum(x .* exp(-1j*2*pi*k*n/N));
end

%% 4. Frequency axis
f = (-N/2:N/2-1)*(fs/N);

% Shift spectrum to center zero frequency
X_shifted = fftshift(X)/N;

%% 5. Visualization
figure;

subplot(2,1,1);
plot(t,x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete-Time Signal');
grid on;

subplot(2,1,2);
stem(f,abs(X_shifted),'Marker','none');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Direct DFT Magnitude Spectrum');
xlim([-200 200]);
grid on;

%% 6. Save figure
exportgraphics(gcf,'dft_result.png');
