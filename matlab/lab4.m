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
S = spectrogram(signal, w, N - H);
disp(size(S));
% Take abs and square of each element
Y = abs(S).^2;


P = @(p) 2^((p-69)/12)*440;



[m, n] = size(S);
% window time vector
T = [0:n-1];
T = T*H/Fs;
% 'frequencies of coeffs' vector
F = [0:m-1];
F = F*Fs/N;
%spectrogram(signal, w, N-H, m, Fs, 'yaxis')
% m x p
counter = 0;
Y = zeros(128, n);
for pitch = 0 : 127
   pmin = P(pitch-0.5);
   pmax = P(pitch+0.5);
   
   Finterval = F >= pmin & F < pmax;

   for time = 1:n
       for freq = 1:m;
           if Finterval(1,freq)
               Y(pitch+1, time) = Y(pitch+1, time) + abs(S(freq, time))^2;
               counter = counter+1;
           end
       end
   end 
end

C= zeros(12, n);

for pitch = 0 : 127
    for time = 1:n
        C((mod(pitch, 12))+1, time) = C(mod(pitch, 12)+1, time) + Y(pitch+1, time);
    end
end

pitches = 0:11;
%Ycomp = log(1+1*Y);
image(T,pitches, C);