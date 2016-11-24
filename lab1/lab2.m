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

[m, n] = size(S);
% window time vector
T = [0:n-1];
T = T*H/Fs;
% 'frequencies of coeffs' vector
F = [0:m-1];
F = F*Fs/N;

% plot
counter = 1;
for var = [1, 10, 100, 1000, 10000]
   Ycomp = log(1+var*Y);
   h = subplot(2, 3, counter);
   image(T, F, Ycomp, 'Parent', h);
   set(h, 'Ydir', 'normal');
   colorbar;
   title(int2str(var));
   counter = counter + 1;
end

h = subplot(2, 3, 6);
image(T,F, Y, 'Parent', h);
set(h, 'Ydir', 'normal');
title('Uncompressed');
colorbar;

