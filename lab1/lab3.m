% Read signal
[signal, Fs] = audioread('Scale_Cmajor_Piano.wav');

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

% Anonymous function to compute F_pitch(p)
P = @(p) 2^((p-69)/12)*440;

[m, n] = size(S);
% window time vector
T = [0:n-1];
T = T*H/Fs;
% 'frequencies of coeffs' vector
F = [0:m-1];
F = F*Fs/N;

% m x p
% log-frequency spectogram
Y = zeros(128, n);

for pitch = 0 : 127
   % compute min and max freq of P(pitch)
   pmin = P(pitch-0.5);
   pmax = P(pitch+0.5);
   
   % vector with 1 at every coeff index, that lies inside P(pitch)
   Finterval = F >= pmin & F < pmax;

   for time = 1:n
       for freq = 1:m;
           if Finterval(1,freq)
               Y(pitch+1, time) = Y(pitch+1, time) + abs(S(freq, time))^2;
           end
       end
   end 
end

% plot
pitches = 0:127;
counter = 1;
for var = [1, 10, 100, 1000, 10000]
   Ycomp = log(1+var*Y);
   h = subplot(2, 3, counter);
   image(T, pitches, Ycomp, 'Parent', h);
   set(h, 'Ydir', 'normal');
   colorbar;
   title(int2str(var));
   counter = counter + 1;
end

h = subplot(2, 3, 6);
image(T, pitches, Y, 'Parent', h);
set(h, 'Ydir', 'normal');
title('Uncompressed');
colorbar;


