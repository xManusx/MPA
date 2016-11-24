% Read signal
[signal, Fs] = audioread('Sound_TwoSineTwoImpulse.wav');

% Window size
N = 4096;
% Step size
H = 2048;
% Hann-window
w = hann(N);

% Compute complex spectrogram
S = spectrogram(signal, w, N - H);

% Take abs and square of each element
Y = abs(S).^2;

[m, n] = size(S);
% window time vector
T = [0:n-1];
T = T*H/Fs;
% 'frequencies of coeffs' vector
F = [0:m-1];
F = F*Fs/N;

% plots

% axis = indices
h = subplot(1, 3, 1);
x = [0:n-1];
y = [0:m-1];
image(x, y, Y, 'Parent', h);
set(h, 'Ydir', 'normal');
title('Indices as axis');
colorbar;

% axis = freq and time
h = subplot(1, 3, 2);
image(T, F, Y, 'Parent', h);
set(h, 'Ydir', 'normal');
title('Time and Frequencies as axis');
colorbar;

% log decibel-scale
h = subplot(1, 3, 3);
Ylog = 10*log10(Y);
image(T, F, Ylog, 'Parent', h);
set(h, 'Ydir', 'normal');
title('Logarithmic decibel-scale');
colorbar;

