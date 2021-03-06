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
   pmin = P(pitch-0.5);
   pmax = P(pitch+0.5);
   
   Finterval = F >= pmin & F < pmax;

   for time = 1:n
       for freq = 1:m;
           if Finterval(1,freq)
               Y(pitch+1, time) = Y(pitch+1, time) + abs(S(freq, time))^2;
           end
       end
   end 
end

% Calculate chroma representation
C= zeros(12, n);
for pitch = 0 : 127
    for time = 1:n
        C((mod(pitch, 12))+1, time) = C(mod(pitch, 12)+1, time) + Y(pitch+1, time);
    end
end

% plot
pitches = 0:11;
image(T ,pitches, C);
title('Chroma representation');
set(gca, 'Ydir', 'normal');
