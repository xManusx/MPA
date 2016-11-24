function [x_h,x_p] = HPSS(x,N,H,w,fs,lh_sec,lp_Hz)
% x:      Input signal
% N:      Frame length
% H:      Hopsize
% w:      Window function of length N
% fs:     Sampling rate of x
% lh_sec: Horizontal median filter length given in seconds
% lp_Hz:  Percussive median filter length given in Hertz

%% stft
X = stft(x, N, H, w);
%% power spectrogram
Y = abs(X).^2;
%% median filtering
Y_h = medianFilter(Y,ceil(fs/H*lh_sec),'h');
Y_p = medianFilter(Y,ceil(N/fs*lp_Hz),'p');
%% masking
M_h = double(Y_h >= Y_p);
M_p = double(Y_p >= Y_h);
X_h = M_h.*X;
X_p = M_p.*X;
%% istft
x_h = istft(X_h, H, w);
x_p = istft(X_p, H, w);
end