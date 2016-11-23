

% Read signal
[signal, Fs] = audioread('Scale_Cmajor_Piano.wav');
%TODO try out different HopSizes or WindowSizes
% Window size
N = 4096;
% Step size
H = 2048;
% Hann-window
w = hann(N);

% Compute complex spectrogram
S = spectrogram(signal, w, N -H);
% Take abs and square of each element
Y = abs(S).^2;


P = @(p) 2^((p-69)/12)*440

[m, n] = size(S);
% window time vector
T = [0:n-1];
T = T*H/Fs;
% 'frequencies of coeffs' vector
F = [0:m-1];
F = F*Fs/N;
%spectrogram(signal, w, N-H, m, Fs, 'yaxis')
axis([T(1) T(end) F(1) F(end)]);