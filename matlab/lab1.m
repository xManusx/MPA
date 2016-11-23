% Read signal
[signal, Fs] = audioread('Sound_TwoSineTwoImpulse.wav');
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

[m, n] = size(S);
% window time vector
T = [0:n-1];
T = T*H/Fs;
% 'frequencies of coeffs' vector
F = [0:m-1];
F = F*Fs/N;

logY = 10*log10(Y);
%spectrogram(signal, w, N-H, m, Fs, 'yaxis')
axis([T(1) T(end) F(1) F(end)]);
image(T, F, logY);
set(gca, 'Ydir', 'normal');
colorbar;
%xlim([0,1])


%imagesc(T, F, S);

