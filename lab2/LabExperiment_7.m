%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB EXPERIMENT 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('providedCode');
[x, fs] = audioread('Data/StillPluto_BitterPill.wav');
N = 882;
H = 441;
J = 10;

w = win('sin', N);
lh_sec = 0.5;
lp_Hz = 200;
[x_h,x_p] = HPSS(x,N,H,w,fs,lh_sec,lp_Hz);

novelty = onsetDetection(x_p,N,H,J);

featureRate = fs/H;
out = sonify_noveltyCurve(novelty,x,fs,featureRate);
audiowrite('sonified.wav', out, fs);