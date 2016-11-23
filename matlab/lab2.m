

% Read signal
[signal, Fs] = audioread('Tone_C4_Flute.wav');
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

Ycomp1 = log(1+1*Y)
Ycomp100 = log(1+100*Y)
Ycomp10000 = log(1+10000*Y)

[m, n] = size(S);
% window time vector
T = [0:n-1];
T = T*H/Fs;
% 'frequencies of coeffs' vector
F = [0:m-1];
F = F*Fs/N;
%spectrogram(signal, w, N-H, m, Fs, 'yaxis')
axis([T(1) T(end) F(1) F(end)]);

h = [];
h(1) = subplot(2,2,1)
h(2) = subplot(2,2,2)
h(3) = subplot(2,2,3)
h(4) = subplot(2,2,4)

image(T,F, Ycomp1, 'Parent', h(1))
set(h(1), 'Ydir', 'normal');
colorbar;
image(T,F, Ycomp100, 'Parent', h(2))
set(h(2), 'Ydir', 'normal');
colorbar;
image(T,F, Ycomp10000, 'Parent', h(3))
set(h(3), 'Ydir', 'normal');
colorbar;

image(T,F, Y, 'Parent', h(4))
set(h(4), 'Ydir', 'normal');
colorbar;
%xlim([0,1])

