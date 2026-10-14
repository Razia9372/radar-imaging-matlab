clear all; 
close all;
clc;
%% signal in time domain: sum, 
dt = 0.1;
fs = 1/dt;
t = (-25:25)*dt;
N = length(t);
tau_y = -1;
Ty=3;
my_rectpuls = double(abs(t) <= 0.5);
x = rectpuls((t-tau_y/Ty));
z= x.*y;
figure;
subplot(4,1,2);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Time-Domain Signal');
grid on;
time = 0:dt:10;
signal = sin(2*pi*1*time) + 0.5*sin(2*pi*3*time);
%tasks for home:
%what happens with complex signals?


%%Fourier Transforms
X = fftshift(fft(signal));
frequencies = (-length(signal)/2:length(signal)/2-1) * (fs/length(signal));
magnitudeSpectrum = abs(X) / length(signal);
figure;
plot(frequencies, magnitudeSpectrum);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum');
grid on;


clear;
clc;
close all;

% Parameters
fs = 1000;             % Sampling frequency (Hz)
dt = 1/fs;             % Time step
t = 0:dt:1-dt;         % Time vector

% Signal: two sinusoidal components
x = sin(2*pi*50*t) + 0.5*sin(2*pi*120*t);

% Frequency vector
f = -200:1:200;

% Numerical approximation of CTFT
X = zeros(size(f));

for k = 1:length(f)
    X(k) = trapz(t, x .* exp(-1j*2*pi*f(k)*t));
end

% Plot original signal
figure;

subplot(2,1,1);
plot(t, x);
title('Time-Domain Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot CTFT magnitude
subplot(2,1,2);
plot(f, abs(X));
title('CTFT Magnitude (Numerical Approximation)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;
