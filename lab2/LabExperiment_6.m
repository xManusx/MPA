%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB EXPERIMENT 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('providedCode');
[x, fs] = audioread('Data/CastanetsViolin.wav');
N = 4410;
H = 2205;
f_chroma = simple_chroma( x, N, H, fs);
visualize_simpleChroma( f_chroma, H, fs );

w = win('sin', N);
lh_sec = 0.5;
lp_Hz = 200;
[x_h,x_p] = HPSS(x,N,H,w,fs,lh_sec,lp_Hz);

f_h_chroma = simple_chroma( x_h, N, H, fs);
visualize_simpleChroma( f_h_chroma, H, fs );