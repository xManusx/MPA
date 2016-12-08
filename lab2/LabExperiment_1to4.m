%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB EXPERIMENT 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('providedCode');

% read signal
[signal, fs] = audioread('Data/CastanetsViolin.wav');

% STFT
N = 1024;
%N = 8192;
Hopsize = 512;
%H = 4096;
w = win('sin', N);
X = stft(signal, N, Hopsize, w);
% power spectrogram
Y = abs(X).^2;

% plot
visualize_matrix(Y, 10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB EXPERIMENT 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% filter length 3
%H_3 = medianFilter(Y,3,'h');
%V_3 = medianFilter(Y,3,'p');
%visualize_matrix(H_3, 10);
%visualize_matrix(V_3, 10);

% filter length 11
H = medianFilter(Y,11,'h');
V = medianFilter(Y,11,'p');
%visualize_matrix(H_11, 10);
%visualize_matrix(V_11, 10);

% filter length 51
%H_51 = medianFilter(Y,51,'h');
%V_51 = medianFilter(Y,51,'p');
%visualize_matrix(H_51, 10);
%visualize_matrix(V_51, 10);

% filter length 101
%H_101 = medianFilter(Y,101,'h');
%V_101 = medianFilter(Y,101,'p');
%visualize_matrix(H_101, 10);
%visualize_matrix(V_101, 10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB EXPERIMENT 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% filter length 11
M_h = double(H >= V);
M_p = double(V > H);

X_h = M_h.*X;
X_p = M_p.*X;
%Y_h = abs(X_h).^2;
%Y_p = abs(X_p).^2;
Y_h = M_h.*Y;
Y_p = M_p.*Y;

%visualize_matrix(X_h, 10);
%visualize_matrix(X_p, 10);
%visualize_matrix(Y_h, 10);
%visualize_matrix(X_p, 10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB EXPERIMENT 4

Sig_h = istft(X_h, Hopsize, w);
Sig_p = istft(X_p, Hopsize, w);
%subplot(2,1,1);
%plot(Sig_h+Sig_p);
%subplot(2,1,2);
%plot(signal);
audiowrite('harmonicComponent.wav', Sig_h, fs);
audiowrite('percussiveComponent.wav', Sig_p, fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
